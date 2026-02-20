import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_text_field.dart';

/// Mobile Money payment screen for MTN, Vodafone, AirtelTigo
class MoMoPaymentScreen extends ConsumerStatefulWidget {
  final double amount;
  final String description;
  final String? consultationId;

  const MoMoPaymentScreen({
    super.key,
    required this.amount,
    required this.description,
    this.consultationId,
  });

  @override
  ConsumerState<MoMoPaymentScreen> createState() => _MoMoPaymentScreenState();
}

class _MoMoPaymentScreenState extends ConsumerState<MoMoPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  
  MoMoProvider? _selectedProvider;
  bool _isLoading = false;
  PaymentStep _currentStep = PaymentStep.selectProvider;

  final List<MoMoProvider> _providers = [
    MoMoProvider(
      id: 'mtn',
      name: 'MTN Mobile Money',
      logo: 'assets/images/mtn_logo.png',
      color: AppColors.warning,
      prefix: '024',
      validPrefixes: ['024', '054', '055', '059'],
    ),
    MoMoProvider(
      id: 'vodafone',
      name: 'Vodafone Cash',
      logo: 'assets/images/vodafone_logo.png',
      color: AppColors.error,
      prefix: '020',
      validPrefixes: ['020', '050'],
    ),
    MoMoProvider(
      id: 'airteltigo',
      name: 'AirtelTigo Money',
      logo: 'assets/images/airteltigo_logo.png',
      color: AppColors.primary,
      prefix: '027',
      validPrefixes: ['027', '057', '026', '056'],
    ),
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _selectProvider(MoMoProvider provider) {
    setState(() {
      _selectedProvider = provider;
      _currentStep = PaymentStep.enterPhone;
    });
  }

  void _goBack() {
    if (_currentStep == PaymentStep.enterPhone) {
      setState(() {
        _currentStep = PaymentStep.selectProvider;
        _selectedProvider = null;
      });
    } else {
      context.pop();
    }
  }

  Future<void> _processPayment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    
    try {
      // TODO: Integrate with actual payment API
      await Future.delayed(const Duration(seconds: 3)); // Simulate API call
      
      setState(() {
        _currentStep = PaymentStep.processing;
      });
      
      // Simulate processing
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _currentStep = PaymentStep.success;
      });
    } catch (e) {
      setState(() {
        _currentStep = PaymentStep.failed;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }
    
    final prefix = value.substring(0, 3);
    if (_selectedProvider != null && 
        !_selectedProvider!.validPrefixes.contains(prefix)) {
      return 'Invalid ${_selectedProvider!.name} number';
    }
    
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentStep != PaymentStep.selectProvider) {
          _goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          title: const Text(
            'Mobile Money Payment',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: _goBack,
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [
            // Payment summary
            _buildPaymentSummary(),
            
            // Payment steps
            Expanded(
              child: _buildCurrentStep(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Summary',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                Formatters.formatCurrency(widget.amount),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(color: AppColors.primary),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Amount',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                Formatters.formatCurrency(widget.amount),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case PaymentStep.selectProvider:
        return _buildProviderSelection();
      case PaymentStep.enterPhone:
        return _buildPhoneEntry();
      case PaymentStep.processing:
        return _buildProcessing();
      case PaymentStep.success:
        return _buildSuccess();
      case PaymentStep.failed:
        return _buildFailed();
    }
  }

  Widget _buildProviderSelection() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select your Mobile Money provider',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: _providers.length,
              itemBuilder: (context, index) {
                final provider = _providers[index];
                return _ProviderCard(
                  provider: provider,
                  onTap: () => _selectProvider(provider),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneEntry() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selected provider info
            AppCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _selectedProvider!.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.phone_android,
                      color: _selectedProvider!.color,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedProvider!.name,
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Supported: ${_selectedProvider!.validPrefixes.join(', ')}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
            Text(
              'Enter your phone number',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            AppTextField(
              controller: _phoneController,
              label: 'Phone Number',
              hint: '${_selectedProvider!.prefix} XXX XXXX',
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone),
              validator: _validatePhoneNumber,
            ),
            
            const SizedBox(height: 24),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.info.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.info,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Payment Instructions',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.info,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '1. You will receive a payment prompt on your phone\n'
                    '2. Enter your Mobile Money PIN to approve\n'
                    '3. Wait for payment confirmation',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            
            AppButton.primary(
              text: 'Continue Payment',
              onPressed: _processPayment,
              isFullWidth: true,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessing() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: CircularProgressIndicator(
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Processing Payment',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Please check your phone for a payment prompt and enter your PIN to complete the transaction.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.phone_android,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Waiting for approval on ${_phoneController.text}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccess() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                size: 50,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Payment Successful!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your payment of ${Formatters.formatCurrency(widget.amount)} has been processed successfully.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AppButton.primary(
              text: 'View Receipt',
              onPressed: () {
                // TODO: Navigate to receipt screen
                context.pop();
              },
              isFullWidth: true,
            ),
            const SizedBox(height: 12),
            AppButton.ghost(
              text: 'Done',
              onPressed: () => context.pop(),
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFailed() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 50,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Payment Failed',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'We couldn\'t process your payment. Please check your account balance and try again.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            AppButton.primary(
              text: 'Try Again',
              onPressed: () {
                setState(() {
                  _currentStep = PaymentStep.enterPhone;
                });
              },
              isFullWidth: true,
            ),
            const SizedBox(height: 12),
            AppButton.ghost(
              text: 'Cancel',
              onPressed: () => context.pop(),
              isFullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}

/// Provider card widget
class _ProviderCard extends StatelessWidget {
  final MoMoProvider provider;
  final VoidCallback onTap;

  const _ProviderCard({
    required this.provider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard.clickable(
      onTap: onTap,
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: provider.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.phone_android,
              color: provider.color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Supported networks: ${provider.validPrefixes.join(', ')}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.textTertiary,
          ),
        ],
      ),
    );
  }
}

/// Payment steps enum
enum PaymentStep {
  selectProvider,
  enterPhone,
  processing,
  success,
  failed,
}

/// Mobile Money provider data model
class MoMoProvider {
  final String id;
  final String name;
  final String logo;
  final Color color;
  final String prefix;
  final List<String> validPrefixes;

  const MoMoProvider({
    required this.id,
    required this.name,
    required this.logo,
    required this.color,
    required this.prefix,
    required this.validPrefixes,
  });
}