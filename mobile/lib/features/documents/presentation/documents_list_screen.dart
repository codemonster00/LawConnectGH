import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/formatters.dart';
import '../../../shared/models/user.dart';

/// Documents screen showing templates and user's generated documents
class DocumentsListScreen extends ConsumerStatefulWidget {
  const DocumentsListScreen({super.key});

  @override
  ConsumerState<DocumentsListScreen> createState() => _DocumentsListScreenState();
}

class _DocumentsListScreenState extends ConsumerState<DocumentsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Mock data - TODO: Get from provider
  final List<DocumentTemplateItem> _templates = [
    DocumentTemplateItem(
      id: '1',
      name: 'Affidavit',
      category: 'Legal Declarations',
      description: 'Sworn written statement used as evidence in legal proceedings',
      fee: 50,
      estimatedTime: '1-2 hours',
      icon: Icons.gavel,
      color: AppColors.primary,
    ),
    DocumentTemplateItem(
      id: '2',
      name: 'Will & Testament',
      category: 'Estate Planning',
      description: 'Legal document expressing wishes for asset distribution',
      fee: 200,
      estimatedTime: '2-3 days',
      icon: Icons.article,
      color: AppColors.accent,
    ),
    DocumentTemplateItem(
      id: '3',
      name: 'Contract Agreement',
      category: 'Business',
      description: 'Legal agreement between two or more parties',
      fee: 150,
      estimatedTime: '1-2 days',
      icon: Icons.handshake,
      color: AppColors.info,
    ),
    DocumentTemplateItem(
      id: '4',
      name: 'Power of Attorney',
      category: 'Authorization',
      description: 'Legal document granting someone authority to act on your behalf',
      fee: 100,
      estimatedTime: '1 day',
      icon: Icons.security,
      color: AppColors.success,
    ),
  ];

  final List<GeneratedDocumentItem> _myDocuments = [
    GeneratedDocumentItem(
      id: '1',
      templateName: 'Affidavit',
      status: DocumentStatus.completed,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      completedAt: DateTime.now().subtract(const Duration(days: 1)),
      fee: 50,
    ),
    GeneratedDocumentItem(
      id: '2',
      templateName: 'Contract Agreement',
      status: DocumentStatus.inProgress,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      completedAt: null,
      fee: 150,
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
        title: const Text(AppStrings.legalDocuments),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.textInverse,
          unselectedLabelColor: AppColors.textInverse.withValues(alpha: 0.7),
          indicatorColor: AppColors.accent,
          tabs: const [
            Tab(text: 'Templates'),
            Tab(text: 'My Documents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Document templates
          _buildTemplatesTab(),
          
          // My documents
          _buildMyDocumentsTab(),
        ],
      ),
    );
  }

  Widget _buildTemplatesTab() {
    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Refresh templates
        await Future.delayed(const Duration(seconds: 1));
      },
      color: AppColors.primary,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header with search
          _buildTemplatesHeader(),
          const SizedBox(height: 16),
          
          // Popular templates
          Text(
            'Popular Templates',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          
          // Templates grid
          ..._templates.map((template) => _TemplateCard(
            template: template,
            onTap: () => _showTemplateDetails(template),
          )),
        ],
      ),
    );
  }

  Widget _buildMyDocumentsTab() {
    if (_myDocuments.isEmpty) {
      return _buildEmptyDocuments();
    }

    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Refresh my documents
        await Future.delayed(const Duration(seconds: 1));
      },
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _myDocuments.length,
        itemBuilder: (context, index) {
          final doc = _myDocuments[index];
          return _MyDocumentCard(
            document: doc,
            onTap: () => _showDocumentDetails(doc),
          );
        },
      ),
    );
  }

  Widget _buildTemplatesHeader() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search document templates...',
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
              filled: true,
              fillColor: AppColors.surface,
            ),
          ),
        ),
        const SizedBox(width: 12),
        IconButton(
          onPressed: () {
            // TODO: Show template filters
          },
          icon: Icon(
            Icons.filter_list,
            color: AppColors.primary,
          ),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surface,
            padding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyDocuments() {
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
                Icons.description_outlined,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No documents yet',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Request legal documents from verified lawyers',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textTertiary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _tabController.animateTo(0); // Switch to templates tab
              },
              icon: const Icon(Icons.add),
              label: const Text('Browse Templates'),
            ),
          ],
        ),
      ),
    );
  }

  void _showTemplateDetails(DocumentTemplateItem template) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (context, scrollController) => _TemplateDetailsSheet(
          template: template,
          scrollController: scrollController,
        ),
      ),
    );
  }

  void _showDocumentDetails(GeneratedDocumentItem document) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => _DocumentDetailsSheet(document: document),
    );
  }
}

/// Template card widget
class _TemplateCard extends StatelessWidget {
  final DocumentTemplateItem template;
  final VoidCallback onTap;

  const _TemplateCard({
    required this.template,
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
          child: Row(
            children: [
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: template.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  template.icon,
                  color: template.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              
              // Template info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      template.category,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      template.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            Formatters.formatCurrency(template.fee),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.schedule,
                          size: 14,
                          color: AppColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          template.estimatedTime,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Arrow
              Icon(
                Icons.chevron_right,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// My document card widget
class _MyDocumentCard extends StatelessWidget {
  final GeneratedDocumentItem document;
  final VoidCallback onTap;

  const _MyDocumentCard({
    required this.document,
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
          child: Row(
            children: [
              // Document icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getStatusColor(document.status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getDocumentIcon(document.status),
                  color: _getStatusColor(document.status),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              
              // Document info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.templateName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getStatusColor(document.status).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getStatusText(document.status),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: _getStatusColor(document.status),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          Formatters.formatCurrency(document.fee),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Created: ${Formatters.formatTimeAgo(document.createdAt)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Actions or arrow
              if (document.status == DocumentStatus.completed)
                IconButton(
                  onPressed: () {
                    // TODO: Download document
                  },
                  icon: Icon(
                    Icons.download,
                    color: AppColors.primary,
                  ),
                )
              else
                Icon(
                  Icons.chevron_right,
                  color: AppColors.textTertiary,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.pending:
        return AppColors.warning;
      case DocumentStatus.inProgress:
        return AppColors.info;
      case DocumentStatus.completed:
        return AppColors.success;
      case DocumentStatus.rejected:
        return AppColors.error;
    }
  }

  IconData _getDocumentIcon(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.pending:
        return Icons.schedule;
      case DocumentStatus.inProgress:
        return Icons.edit_document;
      case DocumentStatus.completed:
        return Icons.check_circle;
      case DocumentStatus.rejected:
        return Icons.error;
    }
  }

  String _getStatusText(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.pending:
        return 'Pending';
      case DocumentStatus.inProgress:
        return 'In Progress';
      case DocumentStatus.completed:
        return 'Ready';
      case DocumentStatus.rejected:
        return 'Rejected';
    }
  }
}

/// Template details bottom sheet
class _TemplateDetailsSheet extends StatelessWidget {
  final DocumentTemplateItem template;
  final ScrollController scrollController;

  const _TemplateDetailsSheet({
    required this.template,
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
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: template.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  template.icon,
                  color: template.color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      template.category,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Description
          Text(
            'About This Document',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            template.description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          // Details
          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  icon: Icons.payments,
                  title: 'Fee',
                  value: Formatters.formatCurrency(template.fee),
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoCard(
                  icon: Icons.schedule,
                  title: 'Delivery',
                  value: template.estimatedTime,
                  color: AppColors.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Request button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Navigate to document request form
              },
              icon: const Icon(Icons.edit_document),
              label: Text('Request ${template.name}'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Document details bottom sheet  
class _DocumentDetailsSheet extends StatelessWidget {
  final GeneratedDocumentItem document;

  const _DocumentDetailsSheet({required this.document});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: _getStatusColor().withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getDocumentIcon(),
                  color: _getStatusColor(),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      document.templateName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
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
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Document details
          _DetailRow(
            label: 'Created',
            value: Formatters.formatDateTime(document.createdAt),
          ),
          if (document.completedAt != null)
            _DetailRow(
              label: 'Completed',
              value: Formatters.formatDateTime(document.completedAt!),
            ),
          _DetailRow(
            label: 'Fee',
            value: Formatters.formatCurrency(document.fee),
          ),
          const SizedBox(height: 24),
          
          // Actions
          Row(
            children: [
              if (document.status == DocumentStatus.completed) ...[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Share document
                    },
                    icon: const Icon(Icons.share),
                    label: const Text(AppStrings.shareDocument),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Download document
                    },
                    icon: const Icon(Icons.download),
                    label: const Text(AppStrings.downloadDocument),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // TODO: Cancel document request
                    },
                    child: const Text('Cancel Request'),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (document.status) {
      case DocumentStatus.pending:
        return AppColors.warning;
      case DocumentStatus.inProgress:
        return AppColors.info;
      case DocumentStatus.completed:
        return AppColors.success;
      case DocumentStatus.rejected:
        return AppColors.error;
    }
  }

  IconData _getDocumentIcon() {
    switch (document.status) {
      case DocumentStatus.pending:
        return Icons.schedule;
      case DocumentStatus.inProgress:
        return Icons.edit_document;
      case DocumentStatus.completed:
        return Icons.check_circle;
      case DocumentStatus.rejected:
        return Icons.error;
    }
  }

  String _getStatusText() {
    switch (document.status) {
      case DocumentStatus.pending:
        return 'Pending Review';
      case DocumentStatus.inProgress:
        return 'In Progress';
      case DocumentStatus.completed:
        return 'Ready for Download';
      case DocumentStatus.rejected:
        return 'Request Rejected';
    }
  }
}

/// Info card widget
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// Detail row widget
class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Mock data models
class DocumentTemplateItem {
  final String id;
  final String name;
  final String category;
  final String description;
  final double fee;
  final String estimatedTime;
  final IconData icon;
  final Color color;

  DocumentTemplateItem({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.fee,
    required this.estimatedTime,
    required this.icon,
    required this.color,
  });
}

class GeneratedDocumentItem {
  final String id;
  final String templateName;
  final DocumentStatus status;
  final DateTime createdAt;
  final DateTime? completedAt;
  final double fee;

  GeneratedDocumentItem({
    required this.id,
    required this.templateName,
    required this.status,
    required this.createdAt,
    this.completedAt,
    required this.fee,
  });
}