import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

/// Document templates browsing screen
class DocumentTemplatesScreen extends ConsumerWidget {
  const DocumentTemplatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.documentTemplates),
      ),
      body: const Center(
        child: Text('Document Templates Screen - Coming Soon'),
      ),
    );
  }
}