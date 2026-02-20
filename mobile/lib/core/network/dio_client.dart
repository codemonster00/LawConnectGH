import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/api_endpoints.dart';
import '../constants/storage_keys.dart';
import '../errors/exceptions.dart';

/// HTTP client provider using Dio
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  // Add interceptors
  dio.interceptors.addAll([
    // Pretty logging (only in debug mode)
    if (const bool.fromEnvironment('dart.vm.product') == false)
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: true,
        error: true,
        maxWidth: 90,
      ),
    
    // JWT Authentication interceptor
    _JwtInterceptor(),
    
    // Error handling interceptor
    _ErrorInterceptor(),
    
    // Retry interceptor
    _RetryInterceptor(),
  ]);

  return dio;
});

/// JWT Authentication Interceptor
class _JwtInterceptor extends Interceptor {
  static const _storage = FlutterSecureStorage();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await _storage.read(key: StorageKeys.accessToken);
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    } catch (e) {
      handler.next(options);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized - token expired
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await _storage.read(key: StorageKeys.refreshToken);
        if (refreshToken != null) {
          // Attempt token refresh
          final dio = Dio();
          final response = await dio.post(
            '${ApiEndpoints.baseUrl}${ApiEndpoints.refreshToken}',
            data: {'refreshToken': refreshToken},
          );
          
          if (response.statusCode == 200) {
            final newToken = response.data['token'];
            final newRefreshToken = response.data['refreshToken'];
            
            // Update stored tokens
            await _storage.write(key: StorageKeys.accessToken, value: newToken);
            await _storage.write(key: StorageKeys.refreshToken, value: newRefreshToken);
            
            // Retry the original request with new token
            final requestOptions = err.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer $newToken';
            
            final retryResponse = await dio.fetch(requestOptions);
            return handler.resolve(retryResponse);
          }
        }
        
        // Refresh failed, clear tokens and redirect to login
        await _storage.deleteAll();
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: SessionExpiredException(),
        ));
      } catch (refreshError) {
        // Refresh failed, clear tokens
        await _storage.deleteAll();
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: SessionExpiredException(),
        ));
      }
    } else {
      handler.next(err);
    }
  }
}

/// Global error handling interceptor
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: NetworkException('Connection timeout. Please check your internet connection.'),
        ));
        break;
        
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode ?? 0;
        final message = err.response?.data?['message'] ?? 'Server error occurred';
        
        switch (statusCode) {
          case 400:
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: ValidationException(message),
            ));
            break;
          case 401:
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: AuthenticationException(message),
            ));
            break;
          case 403:
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: AuthorizationException(message),
            ));
            break;
          case 404:
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: NotFoundException(message),
            ));
            break;
          case 409:
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: ConflictException(message),
            ));
            break;
          case >= 500:
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: ServerException(message),
            ));
            break;
          default:
            handler.reject(DioException(
              requestOptions: err.requestOptions,
              error: ApiException('HTTP $statusCode: $message'),
            ));
        }
        break;
        
      case DioExceptionType.cancel:
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: CancellationException('Request was cancelled'),
        ));
        break;
        
      case DioExceptionType.unknown:
        if (err.message?.contains('SocketException') ?? false) {
          handler.reject(DioException(
            requestOptions: err.requestOptions,
            error: NetworkException('No internet connection'),
          ));
        } else {
          handler.reject(DioException(
            requestOptions: err.requestOptions,
            error: UnknownException('An unknown error occurred'),
          ));
        }
        break;
        
      default:
        handler.reject(DioException(
          requestOptions: err.requestOptions,
          error: UnknownException(err.message ?? 'Unknown error'),
        ));
    }
  }
}

/// Retry interceptor for network resilience
class _RetryInterceptor extends Interceptor {
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isRetryable = _isRetryable(err);
    final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
    
    if (isRetryable && retryCount < maxRetries) {
      // Wait before retrying
      await Future.delayed(Duration(milliseconds: (retryDelay.inMilliseconds * (retryCount + 1)).toInt()));
      
      // Increment retry count
      err.requestOptions.extra['retryCount'] = retryCount + 1;
      
      try {
        // Retry the request
        final dio = Dio();
        final response = await dio.fetch(err.requestOptions);
        handler.resolve(response);
      } catch (retryError) {
        // If retry also fails, pass the original error
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }

  bool _isRetryable(DioException error) {
    // Retry on timeout and connection errors
    return error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.sendTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           (error.type == DioExceptionType.unknown && 
            (error.message?.contains('SocketException') ?? false));
  }
}