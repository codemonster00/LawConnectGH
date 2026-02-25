import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_typography.dart';

class ConsultationBookingScreen extends StatefulWidget {
  const ConsultationBookingScreen({super.key});

  @override
  State<ConsultationBookingScreen> createState() => _ConsultationBookingScreenState();
}

class _ConsultationBookingScreenState extends State<ConsultationBookingScreen> {
  String _selectedType = 'chat';
  DateTime _selectedDate = DateTime.now();
  String? _selectedTime;
  final TextEditingController _issueController = TextEditingController();

  final List<String> _availableTimes = [
    '09:00 AM', '10:00 AM', '11:00 AM', '02:00 PM', '03:00 PM', '04:00 PM'
  ];

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
    _issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: Text(
          'Book Consultation',
          style: AppTypography.pageTitle(),
        ),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
          color: AppColors.textPrimary,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.contentPaddingHorizontalLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Consultation Type
            Text(
              'Consultation Type',
              style: AppTypography.sectionHeader(),
            )
            .animate()
            .fadeIn(duration: const Duration(milliseconds: 400)),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            _buildConsultationTypes()
            .animate()
            .slideY(begin: 0.1, delay: const Duration(milliseconds: 100))
            .fadeIn(duration: const Duration(milliseconds: 400)),
            
            const SizedBox(height: AppDimensions.sectionGap),
            
            // Date Selection
            Text(
              'Select Date',
              style: AppTypography.sectionHeader(),
            )
            .animate()
            .fadeIn(delay: const Duration(milliseconds: 200)),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            _buildDateSelector()
            .animate()
            .slideY(begin: 0.1, delay: const Duration(milliseconds: 300))
            .fadeIn(duration: const Duration(milliseconds: 400)),
            
            const SizedBox(height: AppDimensions.sectionGap),
            
            // Time Selection
            Text(
              'Select Time',
              style: AppTypography.sectionHeader(),
            )
            .animate()
            .fadeIn(delay: const Duration(milliseconds: 400)),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            _buildTimeSelector()
            .animate()
            .slideY(begin: 0.1, delay: const Duration(milliseconds: 500))
            .fadeIn(duration: const Duration(milliseconds: 400)),
            
            const SizedBox(height: AppDimensions.sectionGap),
            
            // Describe Issue
            Text(
              'Describe Your Legal Issue',
              style: AppTypography.sectionHeader(),
            )
            .animate()
            .fadeIn(delay: const Duration(milliseconds: 600)),
            
            const SizedBox(height: AppDimensions.spacing16),
            
            _buildIssueDescription()
            .animate()
            .slideY(begin: 0.1, delay: const Duration(milliseconds: 700))
            .fadeIn(duration: const Duration(milliseconds: 400)),
            
            const SizedBox(height: AppDimensions.spacing48),
            
            // Book Button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _selectedTime != null ? _bookConsultation : null,
                child: Text(
                  'Book Consultation - GHS 150',
                  style: AppTypography.button(),
                ),
              ),
            )
            .animate()
            .slideY(begin: 0.2, delay: const Duration(milliseconds: 800))
            .fadeIn(duration: const Duration(milliseconds: 400)),
            
            const SizedBox(height: AppDimensions.spacing32),
          ],
        ),
      ),
    );
  }

  Widget _buildConsultationTypes() {
    final types = [
      {'id': 'chat', 'title': 'Chat', 'subtitle': 'Text-based consultation', 'icon': Icons.chat},
      {'id': 'voice', 'title': 'Voice Call', 'subtitle': 'Audio consultation', 'icon': Icons.phone},
      {'id': 'video', 'title': 'Video Call', 'subtitle': 'Face-to-face consultation', 'icon': Icons.video_call},
    ];

    return Column(
      children: types.map((type) {
        final isSelected = _selectedType == type['id'];
        
        return Container(
          margin: const EdgeInsets.only(bottom: AppDimensions.spacing12),
          child: ListTile(
            onTap: () {
              HapticFeedback.lightImpact();
              setState(() {
                _selectedType = type['id'] as String;
              });
            },
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected 
                  ? AppColors.accent.withOpacity(0.2)
                  : AppColors.accent.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                type['icon'] as IconData,
                color: isSelected ? AppColors.accent : AppColors.textSecondary,
              ),
            ),
            title: Text(
              type['title'] as String,
              style: AppTypography.bodyMedium(
                color: isSelected ? AppColors.accent : AppColors.textPrimary,
              ),
            ),
            subtitle: Text(
              type['subtitle'] as String,
              style: AppTypography.caption(color: AppColors.textSecondary),
            ),
            trailing: Radio<String>(
              value: type['id'] as String,
              groupValue: _selectedType,
              onChanged: (value) {
                HapticFeedback.lightImpact();
                setState(() {
                  _selectedType = value!;
                });
              },
              activeColor: AppColors.accent,
            ),
            tileColor: isSelected 
              ? AppColors.accent.withOpacity(0.05)
              : AppColors.card,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
              side: BorderSide(
                color: isSelected ? AppColors.accent.withOpacity(0.3) : AppColors.border,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.accent.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Icon(
            Icons.calendar_today,
            color: AppColors.accent,
          ),
        ),
        title: Text(
          'Selected Date',
          style: AppTypography.body(),
        ),
        subtitle: Text(
          _formatDate(_selectedDate),
          style: AppTypography.bodyMedium(color: AppColors.accent),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.textTertiary,
        ),
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: _selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context).colorScheme.copyWith(
                    primary: AppColors.accent,
                  ),
                ),
                child: child!,
              );
            },
          );
          
          if (date != null) {
            setState(() {
              _selectedDate = date;
              _selectedTime = null; // Reset time selection
            });
          }
        },
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildTimeSelector() {
    return Wrap(
      spacing: AppDimensions.spacing12,
      runSpacing: AppDimensions.spacing12,
      children: _availableTimes.map((time) {
        final isSelected = _selectedTime == time;
        
        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            setState(() {
              _selectedTime = time;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing16,
              vertical: AppDimensions.spacing12,
            ),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.accent : AppColors.card,
              borderRadius: BorderRadius.circular(AppDimensions.buttonBorderRadius),
              border: Border.all(
                color: isSelected 
                  ? AppColors.accent 
                  : AppColors.border,
              ),
              boxShadow: isSelected ? [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ] : [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              time,
              style: AppTypography.bodyMedium(
                color: isSelected ? AppColors.textInverse : AppColors.textPrimary,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIssueDescription() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(AppDimensions.inputBorderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _issueController,
        maxLines: 4,
        decoration: InputDecoration(
          hintText: 'Please describe your legal issue in detail...',
          hintStyle: AppTypography.body(color: AppColors.textTertiary),
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
          contentPadding: const EdgeInsets.all(AppDimensions.inputPaddingHorizontal),
        ),
        style: AppTypography.body(),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    
    return '${date.day} ${months[date.month - 1]}, ${date.year}';
  }

  void _bookConsultation() {
    // Show success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.dialogBorderRadius),
        ),
        title: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.success.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppColors.success,
              ),
            ),
            const SizedBox(width: AppDimensions.spacing16),
            Expanded(
              child: Text(
                'Consultation Booked!',
                style: AppTypography.sectionHeader(),
              ),
            ),
          ],
        ),
        content: Text(
          'Your consultation has been successfully booked for ${_formatDate(_selectedDate)} at $_selectedTime.',
          style: AppTypography.body(),
        ),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/consultations');
            },
            child: Text(
              'View Consultations',
              style: AppTypography.button(),
            ),
          ),
        ],
      ),
    );
  }
}