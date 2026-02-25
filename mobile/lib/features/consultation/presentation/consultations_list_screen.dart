import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/user.dart';
/// Screen showing list of user's consultations (active and history)
class ConsultationsListScreen extends ConsumerStatefulWidget {
  const ConsultationsListScreen({super.key});

  @override
  ConsumerState<ConsultationsListScreen> createState() => _ConsultationsListScreenState();
}

class _ConsultationsListScreenState extends ConsumerState<ConsultationsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Mock data - TODO: Get from provider
  final List<ConsultationListItem> _activeConsultations = [
    ConsultationListItem(
      id: '1',
      lawyerName: 'Kwame Asante',
      specialty: 'Family Law',
      status: ConsultationStatus.active,
      type: ConsultationType.instant,
      startTime: DateTime.now().subtract(const Duration(minutes: 15)),
      duration: 30,
      fee: 120,
      unreadMessages: 2,
    ),
  ];

  final List<ConsultationListItem> _historyConsultations = [
    ConsultationListItem(
      id: '2',
      lawyerName: 'Akosua Boateng',
      specialty: 'Corporate Law',
      status: ConsultationStatus.completed,
      type: ConsultationType.scheduled,
      startTime: DateTime.now().subtract(const Duration(days: 3)),
      duration: 15,
      fee: 200,
      rating: 5,
    ),
    ConsultationListItem(
      id: '3',
      lawyerName: 'Kofi Mensah',
      specialty: 'Criminal Law',
      status: ConsultationStatus.completed,
      type: ConsultationType.instant,
      startTime: DateTime.now().subtract(const Duration(days: 7)),
      duration: 30,
      fee: 150,
      rating: 4,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.consultations),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.textInverse,
          unselectedLabelColor: AppColors.textInverse.withValues(alpha: 0.7),
          indicatorColor: AppColors.accent,
          tabs: [
            Tab(
              text: 'Active (${_activeConsultations.length})',
            ),
            Tab(
              text: 'History (${_historyConsultations.length})',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active consultations
          _activeConsultations.isEmpty
              ? _buildEmptyActive()
              : _buildConsultationsList(_activeConsultations, isActive: true),
          
          // History
          _historyConsultations.isEmpty
              ? _buildEmptyHistory()
              : _buildConsultationsList(_historyConsultations, isActive: false),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go(AppRoutes.lawyers),
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textPrimary,
        icon: const Icon(Icons.add),
        label: const Text(
          'New Consultation',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildConsultationsList(List<ConsultationListItem> consultations, {required bool isActive}) {
    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Refresh consultations
        await Future.delayed(const Duration(seconds: 1));
      },
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: consultations.length,
        itemBuilder: (context, index) {
          final consultation = consultations[index];
          return _ConsultationCard(
            consultation: consultation,
            isActive: isActive,
            onTap: () {
              if (isActive) {
                // Navigate to active chat
                // context.go('/consultations/${consultation.id}/chat');
              } else {
                // Show consultation details or rating
                _showConsultationDetails(consultation);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyActive() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No active consultations',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start a consultation with a verified lawyer to get legal advice',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => context.go(AppRoutes.lawyers),
              icon: const Icon(Icons.search),
              label: const Text('Find Lawyer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyHistory() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: AppColors.textTertiary,
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.noConsultations,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your completed consultations will appear here',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showConsultationDetails(ConsultationListItem consultation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => _ConsultationDetailsSheet(
          consultation: consultation,
          scrollController: scrollController,
        ),
      ),
    );
  }
}

/// Consultation card widget
class _ConsultationCard extends StatelessWidget {
  final ConsultationListItem consultation;
  final bool isActive;
  final VoidCallback onTap;

  const _ConsultationCard({
    required this.consultation,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  // Lawyer avatar
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: Text(
                      Formatters.getInitials(consultation.lawyerName),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Consultation info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                consultation.lawyerName,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Status badge
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(consultation.status).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _getStatusText(consultation.status),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: _getStatusColor(consultation.status),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          consultation.specialty,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              consultation.type == ConsultationType.instant 
                                  ? Icons.flash_on 
                                  : Icons.schedule,
                              size: 14,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              consultation.type == ConsultationType.instant 
                                  ? 'Instant' 
                                  : 'Scheduled',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${consultation.duration} min',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textTertiary,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              Formatters.formatCurrency(consultation.fee),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              
              // Additional info for active consultations
              if (isActive && consultation.unreadMessages != null && consultation.unreadMessages! > 0) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.message,
                        size: 16,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${consultation.unreadMessages} new message${consultation.unreadMessages == 1 ? '' : 's'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Tap to continue',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              // Additional info for completed consultations
              if (!isActive) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: AppColors.textTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      Formatters.formatDateTime(consultation.startTime),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                    const Spacer(),
                    // Rating stars
                    if (consultation.rating != null) ...[
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < consultation.rating! ? Icons.star : Icons.star_outline,
                            size: 14,
                            color: AppColors.accent,
                          );
                        }),
                      ),
                    ] else ...[
                      TextButton(
                        onPressed: () {
                          // TODO: Show rating dialog
                        },
                        child: const Text('Rate'),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(ConsultationStatus status) {
    switch (status) {
      case ConsultationStatus.active:
        return AppColors.success;
      case ConsultationStatus.pending:
        return AppColors.warning;
      case ConsultationStatus.completed:
        return AppColors.primary;
      case ConsultationStatus.cancelled:
        return AppColors.error;
    }
  }

  String _getStatusText(ConsultationStatus status) {
    switch (status) {
      case ConsultationStatus.active:
        return 'In Progress';
      case ConsultationStatus.pending:
        return 'Pending';
      case ConsultationStatus.completed:
        return 'Completed';
      case ConsultationStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Consultation details bottom sheet
class _ConsultationDetailsSheet extends StatelessWidget {
  final ConsultationListItem consultation;
  final ScrollController scrollController;

  const _ConsultationDetailsSheet({
    required this.consultation,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: ListView(
        controller: scrollController,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Header
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Text(
                  Formatters.getInitials(consultation.lawyerName),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      consultation.lawyerName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      consultation.specialty,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _getStatusText(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _getStatusColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Consultation details
          _buildDetailSection(context),
          
          // Actions
          if (consultation.status == ConsultationStatus.completed && consultation.rating == null) ...[
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  // TODO: Show rating dialog
                },
                icon: const Icon(Icons.star_outline),
                label: const Text('Rate Experience'),
              ),
            ),
          ],
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildDetailSection(BuildContext context) {
    return Column(
      children: [
        _DetailItem(
          icon: Icons.calendar_today,
          title: 'Date & Time',
          value: Formatters.formatDateTime(consultation.startTime),
        ),
        _DetailItem(
          icon: Icons.access_time,
          title: 'Duration',
          value: '${consultation.duration} minutes',
        ),
        _DetailItem(
          icon: consultation.type == ConsultationType.instant 
              ? Icons.flash_on 
              : Icons.schedule,
          title: 'Type',
          value: consultation.type == ConsultationType.instant 
              ? 'Instant Consultation' 
              : 'Scheduled Consultation',
        ),
        _DetailItem(
          icon: Icons.payments_outlined,
          title: 'Fee',
          value: Formatters.formatCurrency(consultation.fee),
        ),
        if (consultation.rating != null)
          _DetailItem(
            icon: Icons.star,
            title: 'Your Rating',
            value: '${consultation.rating} stars',
          ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (consultation.status) {
      case ConsultationStatus.active:
        return AppColors.success;
      case ConsultationStatus.pending:
        return AppColors.warning;
      case ConsultationStatus.completed:
        return AppColors.primary;
      case ConsultationStatus.cancelled:
        return AppColors.error;
    }
  }

  String _getStatusText() {
    switch (consultation.status) {
      case ConsultationStatus.active:
        return 'In Progress';
      case ConsultationStatus.pending:
        return 'Pending';
      case ConsultationStatus.completed:
        return 'Completed';
      case ConsultationStatus.cancelled:
        return 'Cancelled';
    }
  }
}

/// Detail item widget for consultation details
class _DetailItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _DetailItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppColors.primary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Mock data model for consultation list item
class ConsultationListItem {
  final String id;
  final String lawyerName;
  final String specialty;
  final ConsultationStatus status;
  final ConsultationType type;
  final DateTime startTime;
  final int duration;
  final double fee;
  final int? unreadMessages;
  final int? rating;

  ConsultationListItem({
    required this.id,
    required this.lawyerName,
    required this.specialty,
    required this.status,
    required this.type,
    required this.startTime,
    required this.duration,
    required this.fee,
    this.unreadMessages,
    this.rating,
  });
}