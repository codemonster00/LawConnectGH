/// Base exception class for the app
abstract class AppException implements Exception {
  const AppException(this.message);
  
  final String message;
  
  @override
  String toString() => 'AppException: $message';
}

/// Network-related exceptions
class NetworkException extends AppException {
  const NetworkException(super.message);
  
  @override
  String toString() => 'NetworkException: $message';
}

/// API-related exceptions
class ApiException extends AppException {
  const ApiException(super.message);
  
  @override
  String toString() => 'ApiException: $message';
}

/// Server error (5xx status codes)
class ServerException extends AppException {
  const ServerException(super.message);
  
  @override
  String toString() => 'ServerException: $message';
}

/// Authentication failed (401)
class AuthenticationException extends AppException {
  const AuthenticationException(super.message);
  
  @override
  String toString() => 'AuthenticationException: $message';
}

/// Session expired or invalid token
class SessionExpiredException extends AppException {
  const SessionExpiredException() : super('Your session has expired. Please login again.');
  
  @override
  String toString() => 'SessionExpiredException: $message';
}

/// Authorization failed (403)
class AuthorizationException extends AppException {
  const AuthorizationException(super.message);
  
  @override
  String toString() => 'AuthorizationException: $message';
}

/// Resource not found (404)
class NotFoundException extends AppException {
  const NotFoundException(super.message);
  
  @override
  String toString() => 'NotFoundException: $message';
}

/// Validation error (400)
class ValidationException extends AppException {
  const ValidationException(super.message);
  
  @override
  String toString() => 'ValidationException: $message';
}

/// Conflict error (409)
class ConflictException extends AppException {
  const ConflictException(super.message);
  
  @override
  String toString() => 'ConflictException: $message';
}

/// Request cancelled
class CancellationException extends AppException {
  const CancellationException(super.message);
  
  @override
  String toString() => 'CancellationException: $message';
}

/// Unknown/unexpected error
class UnknownException extends AppException {
  const UnknownException(super.message);
  
  @override
  String toString() => 'UnknownException: $message';
}

/// Local storage exceptions
class StorageException extends AppException {
  const StorageException(super.message);
  
  @override
  String toString() => 'StorageException: $message';
}

/// Payment-related exceptions
class PaymentException extends AppException {
  const PaymentException(super.message);
  
  @override
  String toString() => 'PaymentException: $message';
}

/// Phone number validation exception
class InvalidPhoneException extends AppException {
  const InvalidPhoneException() : super('Please enter a valid Ghana phone number');
  
  @override
  String toString() => 'InvalidPhoneException: $message';
}

/// OTP validation exception
class InvalidOtpException extends AppException {
  const InvalidOtpException() : super('Invalid OTP code. Please check and try again.');
  
  @override
  String toString() => 'InvalidOtpException: $message';
}

/// SignalR connection exception
class SignalRException extends AppException {
  const SignalRException(super.message);
  
  @override
  String toString() => 'SignalRException: $message';
}