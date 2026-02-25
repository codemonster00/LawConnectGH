import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_typography.dart';

class ConsultationChatScreen extends StatelessWidget {
  final String consultationId;
  
  const ConsultationChatScreen({
    super.key,
    required this.consultationId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat', style: AppTypography.pageTitle()),
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Text(
          'Chat Screen\nConsultation ID: $consultationId',
          style: AppTypography.body(),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}