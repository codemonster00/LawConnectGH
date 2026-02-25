import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_strings.dart';
import '../../../shared/models/user.dart';

/// Consultation booking screen with type, duration, scheduling, and payment
class ConsultationBookingScreen extends ConsumerStatefulWidget {
  final String lawyerId;
  
  const ConsultationBookingScreen({
    super.key,
    required this.lawyerId,
  });

  @override
  ConsumerState<ConsultationBookingScreen> createState() => _ConsultationBookingScreenState();
}

class _ConsultationBookingScreenState extends ConsumerState<ConsultationBookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _problemController = TextEditingController();
  
  ConsultationType _consultationType = ConsultationType.instant;
  int _selectedDuration = 15; // minutes
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  String? _selectedPaymentMethod;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.bookConsultation),
      ),
      body: const Center(
        child: Text('Consultation Booking - In Development'),
      ),
    );
  }
}

/// Mock data models
class LawyerBookingData {
  final String id;
  final String name;
  final String specialty;
  final double consultationFee15Min;
  final double consultationFee30Min;
  final double consultationFee60Min;
  final bool isAvailable;

  LawyerBookingData({
    required this.id,
    required this.name,
    required this.specialty,
    required this.consultationFee15Min,
    required this.consultationFee30Min,
    required this.consultationFee60Min,
    required this.isAvailable,
  });
}

class PaymentMethodOption {
  final String id;
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;

  PaymentMethodOption({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.color,
  });
}