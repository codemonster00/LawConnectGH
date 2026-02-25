import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:country_picker/country_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  Country _selectedCountry = Country.from(json: {
    'e164_cc': '233',
    'iso2_cc': 'GH',
    'e164_sc': 0,
    'geographic': true,
    'level': 1,
    'name': 'Ghana',
    'example': '232123456',
    'display_name': 'Ghana (GH) [+233]',
    'full_example_with_plus_sign': '+233232123456',
    'display_name_no_e164_cc': 'Ghana (GH)',
    'e164_key': '233-GH-0'
  });
  
  bool _isLoading = false;
  String? _errorText;

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
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  void _selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          _selectedCountry = country;
          _errorText = null;
        });
      },
      countryListTheme: CountryListThemeData(
        bottomSheetHeight: MediaQuery.of(context).size.height * 0.8,
        backgroundColor: AppColors.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimensions.bottomSheetBorderRadius),
        ),
        inputDecoration: InputDecoration(
          filled: true,
          fillColor: AppColors.card,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.inputPaddingHorizontal,
            vertical: AppDimensions.inputPaddingVertical,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.inputBorderRadius),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.inputBorderRadius),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.inputBorderRadius),
            borderSide: const BorderSide(color: AppColors.accent, width: 2),
          ),
        ),
        searchTextStyle: AppTypography.body(),
        textStyle: AppTypography.body(),
      ),
    );
  }

  void _formatPhoneNumber(String value) {
    // Basic phone number formatting for Ghana
    String digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (_selectedCountry.phoneCode == '233' && digitsOnly.isNotEmpty) {
      // Ghana phone number formatting
      if (digitsOnly.length <= 3) {
        _phoneController.value = TextEditingValue(
          text: digitsOnly,
          selection: TextSelection.collapsed(offset: digitsOnly.length),
        );
      } else if (digitsOnly.length <= 6) {
        String formatted = '${digitsOnly.substring(0, 3)} ${digitsOnly.substring(3)}';
        _phoneController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      } else if (digitsOnly.length <= 9) {
        String formatted = '${digitsOnly.substring(0, 3)} ${digitsOnly.substring(3, 6)} ${digitsOnly.substring(6)}';
        _phoneController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      } else {
        // Limit to 9 digits for Ghana
        String limited = digitsOnly.substring(0, 9);
        String formatted = '${limited.substring(0, 3)} ${limited.substring(3, 6)} ${limited.substring(6)}';
        _phoneController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }
    } else {
      _phoneController.value = TextEditingValue(
        text: digitsOnly,
        selection: TextSelection.collapsed(offset: digitsOnly.length),
      );
    }
  }

  bool _isValidPhoneNumber() {
    String digitsOnly = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    
    if (_selectedCountry.phoneCode == '233') {
      // Ghana phone numbers are typically 9 digits
      return digitsOnly.length == 9 && 
             (digitsOnly.startsWith('20') || 
              digitsOnly.startsWith('23') || 
              digitsOnly.startsWith('24') || 
              digitsOnly.startsWith('25') || 
              digitsOnly.startsWith('26') || 
              digitsOnly.startsWith('27') || 
              digitsOnly.startsWith('28') || 
              digitsOnly.startsWith('50') || 
              digitsOnly.startsWith('54') || 
              digitsOnly.startsWith('55') || 
              digitsOnly.startsWith('59'));
    }
    
    return digitsOnly.length >= 7; // Basic validation for other countries
  }

  Future<void> _continue() async {
    setState(() {
      _errorText = null;
    });

    if (!_isValidPhoneNumber()) {
      setState(() {
        _errorText = 'Please enter a valid phone number';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      // Navigate to OTP screen
      context.go('/auth/otp', extra: {
        'phoneNumber': '+${_selectedCountry.phoneCode} ${_phoneController.text}',
      });
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.spacing32),
              
              // Welcome Title
              Text(
                'Welcome to\nLawConnect',
                style: AppTypography.heroTitle(),
              )
              .animate()
              .slideY(
                begin: 0.3,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
              )
              .fadeIn(duration: const Duration(milliseconds: 400)),
              
              const SizedBox(height: AppDimensions.spacing16),
              
              // Subtitle
              Text(
                'Enter your phone number to get started',
                style: AppTypography.body(color: AppColors.textSecondary),
              )
              .animate()
              .slideY(
                begin: 0.2,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                delay: const Duration(milliseconds: 100),
              )
              .fadeIn(duration: const Duration(milliseconds: 400)),
              
              const SizedBox(height: AppDimensions.spacing48),
              
              // Phone Number Input
              Container(
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(AppDimensions.inputBorderRadius),
                  border: Border.all(
                    color: _errorText != null ? AppColors.error : AppColors.border,
                    width: _errorText != null ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Country Code Picker
                    GestureDetector(
                      onTap: _selectCountry,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.spacing16,
                          vertical: AppDimensions.inputPaddingVertical,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: AppColors.border),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _selectedCountry.flagEmoji,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(width: AppDimensions.spacing8),
                            Text(
                              '+${_selectedCountry.phoneCode}',
                              style: AppTypography.body(),
                            ),
                            const SizedBox(width: AppDimensions.spacing4),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.textSecondary,
                              size: AppDimensions.iconMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Phone Number Input
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        focusNode: _phoneFocusNode,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: _selectedCountry.phoneCode == '233' 
                            ? '242 123 456' 
                            : 'Phone number',
                          hintStyle: AppTypography.body(color: AppColors.textTertiary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spacing16,
                            vertical: AppDimensions.inputPaddingVertical,
                          ),
                        ),
                        style: AppTypography.body(),
                        onChanged: _formatPhoneNumber,
                        onSubmitted: (_) => _continue(),
                      ),
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
              
              // Error Text
              if (_errorText != null) ...[
                const SizedBox(height: AppDimensions.spacing8),
                Text(
                  _errorText!,
                  style: AppTypography.caption(color: AppColors.error),
                )
                .animate()
                .fadeIn(duration: const Duration(milliseconds: 300))
                .slideY(begin: -0.2, duration: const Duration(milliseconds: 300)),
              ],
              
              const SizedBox(height: AppDimensions.spacing32),
              
              // Continue Button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isLoading ? null : _continue,
                  child: _isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.textInverse.withOpacity(0.7),
                          ),
                        ),
                      )
                    : Text(
                        'Continue',
                        style: AppTypography.button(),
                      ),
                ),
              )
              .animate()
              .slideY(
                begin: 0.2,
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOut,
                delay: const Duration(milliseconds: 300),
              )
              .fadeIn(duration: const Duration(milliseconds: 400)),
              
              const SizedBox(height: AppDimensions.spacing40),
              
              // Terms and Privacy
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: AppTypography.caption(color: AppColors.textTertiary),
                    children: [
                      const TextSpan(text: 'By continuing, you agree to our '),
                      TextSpan(
                        text: 'Terms of Service',
                        style: AppTypography.caption(color: AppColors.accent),
                      ),
                      const TextSpan(text: ' and '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: AppTypography.caption(color: AppColors.accent),
                      ),
                      const TextSpan(text: '.'),
                    ],
                  ),
                ),
              )
              .animate()
              .fadeIn(
                duration: const Duration(milliseconds: 400),
                delay: const Duration(milliseconds: 400),
              ),
              
              const SizedBox(height: AppDimensions.spacing32),
            ],
          ),
        ),
      ),
    );
  }
}