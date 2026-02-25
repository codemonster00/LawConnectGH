import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  
  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with TickerProviderStateMixin {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  
  bool _isLoading = false;
  String? _errorText;
  int _resendCountdown = 60;
  bool _canResend = false;
  
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  
  @override
  void initState() {
    super.initState();
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.surface,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _shakeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shakeController,
      curve: Curves.elasticIn,
    ));
    
    _startResendTimer();
    
    // Auto-focus the PIN input
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otpFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _otpFocusNode.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendCountdown = 60;
      _canResend = false;
    });
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendCountdown > 0) {
        setState(() {
          _resendCountdown--;
        });
        
        if (_resendCountdown > 0) {
          _startResendTimer();
        } else {
          setState(() {
            _canResend = true;
          });
        }
      }
    });
  }

  Future<void> _verifyOtp(String otp) async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      // For demo purposes, accept any 6-digit code
      if (otp.length == 6) {
        setState(() {
          _isLoading = false;
        });
        
        // Navigate to home screen
        context.go('/home');
      } else {
        setState(() {
          _isLoading = false;
          _errorText = 'Invalid verification code. Please try again.';
        });
        
        // Shake animation for error
        _shakeController.forward().then((_) {
          _shakeController.reset();
        });
        
        // Clear the PIN field
        _otpController.clear();
      }
    }
  }

  Future<void> _resendCode() async {
    if (!_canResend) return;
    
    // Simulate resend API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (mounted) {
      _startResendTimer();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Verification code sent to ${widget.phoneNumber}',
            style: AppTypography.body(color: AppColors.textInverse),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
          ),
          margin: const EdgeInsets.all(AppDimensions.spacing16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.contentPaddingHorizontalLarge,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppDimensions.spacing32),
              
              // Verification Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.phone_android,
                  size: 40,
                  color: AppColors.accent,
                ),
              )
              .animate()
              .scale(
                begin: const Offset(0.5, 0.5),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
              )
              .fadeIn(duration: const Duration(milliseconds: 400)),
              
              const SizedBox(height: AppDimensions.spacing32),
              
              // Title
              Text(
                'Verify your number',
                style: AppTypography.heroTitleMedium(),
                textAlign: TextAlign.center,
              )
              .animate()
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                delay: const Duration(milliseconds: 100),
              )
              .fadeIn(duration: const Duration(milliseconds: 400)),
              
              const SizedBox(height: AppDimensions.spacing16),
              
              // Subtitle with masked phone number
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTypography.body(color: AppColors.textSecondary),
                  children: [
                    const TextSpan(text: 'We sent a 6-digit code to\n'),
                    TextSpan(
                      text: widget.phoneNumber,
                      style: AppTypography.bodyMedium(color: AppColors.textPrimary),
                    ),
                  ],
                ),
              )
              .animate()
              .slideY(
                begin: 0.2,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                delay: const Duration(milliseconds: 200),
              )
              .fadeIn(duration: const Duration(milliseconds: 400)),
              
              const SizedBox(height: AppDimensions.spacing48),
              
              // PIN Code Input
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(
                      _shakeAnimation.value * 10 * 
                      (1 - _shakeAnimation.value) * 
                      ((_shakeAnimation.value * 20).round().isEven ? 1 : -1),
                      0,
                    ),
                    child: PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: _otpController,
                      focusNode: _otpFocusNode,
                      animationType: AnimationType.fade,
                      animationDuration: const Duration(milliseconds: 300),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textStyle: AppTypography.pageTitle(),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.buttonBorderRadius,
                        ),
                        fieldHeight: 64,
                        fieldWidth: 48,
                        borderWidth: 2,
                        activeFillColor: AppColors.card,
                        inactiveFillColor: AppColors.card,
                        selectedFillColor: AppColors.card,
                        activeColor: AppColors.accent,
                        inactiveColor: AppColors.border,
                        selectedColor: AppColors.accent,
                        disabledColor: AppColors.divider,
                        errorBorderColor: AppColors.error,
                      ),
                      enableActiveFill: true,
                      cursorColor: AppColors.accent,
                      onCompleted: (otp) {
                        _verifyOtp(otp);
                      },
                      onChanged: (value) {
                        if (_errorText != null) {
                          setState(() {
                            _errorText = null;
                          });
                        }
                      },
                      beforeTextPaste: (text) {
                        // Allow pasting only if it's 6 digits
                        return text?.replaceAll(RegExp(r'[^\d]'), '').length == 6;
                      },
                    ),
                  );
                },
              )
              .animate()
              .slideY(
                begin: 0.2,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                delay: const Duration(milliseconds: 300),
              )
              .fadeIn(duration: const Duration(milliseconds: 400)),
              
              const SizedBox(height: AppDimensions.spacing16),
              
              // Error Message
              if (_errorText != null)
                Text(
                  _errorText!,
                  style: AppTypography.caption(color: AppColors.error),
                  textAlign: TextAlign.center,
                )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 300))
                .slideY(begin: -0.2, duration: const Duration(milliseconds: 300)),
              
              const SizedBox(height: AppDimensions.spacing32),
              
              // Loading Indicator
              if (_isLoading)
                const CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
                )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 300)),
              
              const SizedBox(height: AppDimensions.spacing48),
              
              // Resend Code Section
              Column(
                children: [
                  Text(
                    "Didn't receive the code?",
                    style: AppTypography.body(color: AppColors.textSecondary),
                  ),
                  
                  const SizedBox(height: AppDimensions.spacing8),
                  
                  if (_canResend)
                    TextButton(
                      onPressed: _resendCode,
                      child: Text(
                        'Resend Code',
                        style: AppTypography.bodyMedium(color: AppColors.accent),
                      ),
                    )
                  else
                    Text(
                      'Resend in ${_resendCountdown}s',
                      style: AppTypography.body(color: AppColors.textTertiary),
                    ),
                ],
              )
              .animate()
              .slideY(
                begin: 0.2,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                delay: const Duration(milliseconds: 400),
              )
              .fadeIn(duration: const Duration(milliseconds: 400)),
              
              const SizedBox(height: AppDimensions.spacing32),
            ],
          ),
        ),
      ),
    );
  }
}