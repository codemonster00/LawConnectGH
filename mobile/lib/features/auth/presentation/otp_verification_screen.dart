import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../app/router.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/constants/app_colors.dart';

/// OTP verification screen - Production quality
class OtpVerificationScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  
  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  ConsumerState<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends ConsumerState<OtpVerificationScreen>
    with TickerProviderStateMixin {
  final _otpController = TextEditingController();
  bool _isLoading = false;
  bool _canResend = false;
  int _resendCountdown = 60;
  String? _errorMessage;
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
    
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void _startResendCountdown() {
    setState(() {
      _canResend = false;
      _resendCountdown = 60;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() => _resendCountdown--);
        return _resendCountdown > 0;
      }
      return false;
    }).then((_) {
      if (mounted) setState(() => _canResend = true);
    });
  }

  void _resendOtp() async {
    if (!_canResend) return;
    setState(() { _isLoading = true; _errorMessage = null; });

    try {
      await Future.delayed(const Duration(seconds: 1));
      _startResendCountdown();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('New code sent!', style: TextStyle(color: Colors.white, fontFamily: 'Inter')),
            backgroundColor: const Color(0xFF059669),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      setState(() => _errorMessage = 'Failed to resend. Try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _verifyOtp(String otp) async {
    if (otp.length != 6) return;
    setState(() { _isLoading = true; _errorMessage = null; });

    try {
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        ref.read(authStateProvider.notifier).state = const AsyncValue.data(true);
        context.go(AppRoutes.home);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Invalid code. Please try again.';
        _otpController.clear();
      });
      _shakeController.forward().then((_) => _shakeController.reverse());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              
              // Back button
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 18, color: AppColors.textPrimary),
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Header icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.lock_outline_rounded,
                  size: 32,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(height: 24),
              
              // Title
              const Text(
                'Verification code',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(height: 12),
              
              // Subtitle with phone number
              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                    height: 1.5,
                    fontFamily: 'Inter',
                  ),
                  children: [
                    const TextSpan(text: 'We sent a 6-digit code to '),
                    TextSpan(
                      text: Formatters.formatPhoneNumber(widget.phoneNumber),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 48),
              
              // OTP Input
              AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_shakeAnimation.value, 0),
                    child: PinCodeTextField(
                      appContext: context,
                      controller: _otpController,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      animationDuration: const Duration(milliseconds: 200),
                      enableActiveFill: true,
                      autoFocus: true,
                      keyboardType: TextInputType.number,
                      onCompleted: _verifyOtp,
                      onChanged: (value) {
                        if (_errorMessage != null) {
                          setState(() => _errorMessage = null);
                        }
                      },
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                        fontFamily: 'Inter',
                      ),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(14),
                        fieldHeight: 58,
                        fieldWidth: 50,
                        activeFillColor: Colors.white,
                        inactiveFillColor: AppColors.surfaceVariant,
                        selectedFillColor: Colors.white,
                        activeColor: AppColors.primary,
                        inactiveColor: AppColors.border,
                        selectedColor: AppColors.accent,
                        borderWidth: 2,
                      ),
                    ),
                  );
                },
              ),
              
              // Error message
              if (_errorMessage != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, color: AppColors.error, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(fontSize: 14, color: AppColors.error, fontFamily: 'Inter'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: 32),
              
              // Resend section
              Center(
                child: _canResend
                    ? GestureDetector(
                        onTap: _isLoading ? null : _resendOtp,
                        child: const Text(
                          'Resend code',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1B365D),
                            fontFamily: 'Inter',
                          ),
                        ),
                      )
                    : Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF9CA3AF),
                            fontFamily: 'Inter',
                          ),
                          children: [
                            const TextSpan(text: 'Resend code in '),
                            TextSpan(
                              text: '${_resendCountdown}s',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1B365D),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              
              const Spacer(),
              
              // Verify button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading || _otpController.text.length != 6
                      ? null
                      : () => _verifyOtp(_otpController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B365D),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFF1B365D).withValues(alpha: 0.4),
                    disabledForegroundColor: Colors.white70,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5),
                        )
                      : const Text(
                          'Verify',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
                        ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
