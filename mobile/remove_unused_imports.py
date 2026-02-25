#!/usr/bin/env python3

import os
import re

def remove_unused_imports():
    """Remove specific unused imports based on flutter analyze output"""
    
    os.chdir('/home/openclaw/.openclaw/workspace/LawConnectGH/mobile')
    
    # Map of file paths to unused import lines to remove
    unused_imports = {
        'lib/app/router.dart': [
            "import '../features/payments/presentation/momo_payment_screen.dart';",
            "import '../features/notifications/presentation/notifications_screen.dart';",
            "import '../features/knowledge_base/presentation/knowledge_base_screen.dart';"
        ],
        'lib/features/auth/presentation/phone_auth_screen.dart': [
            "import '../../../core/constants/app_strings.dart';"
        ],
        'lib/features/auth/presentation/splash_screen.dart': [
            "import 'package:lottie/lottie.dart';"
        ],
        'lib/features/consultation/presentation/consultation_booking_screen.dart': [
            "import 'package:go_router/go_router.dart';",
            "import 'package:table_calendar/table_calendar.dart';",
            "import '../../../core/constants/app_colors.dart';",
            "import '../../../core/utils/formatters.dart';"
        ],
        'lib/features/consultation/presentation/consultations_list_screen.dart': [
            "import '../../../shared/widgets/shimmer_loading.dart';"
        ],
        'lib/features/documents/presentation/document_templates_screen.dart': [
            "import '../../../core/constants/app_colors.dart';"
        ],
        'lib/features/documents/presentation/documents_list_screen.dart': [
            "import 'package:go_router/go_router.dart';",
            "import '../../../app/router.dart';"
        ],
        'lib/features/knowledge_base/presentation/knowledge_base_screen.dart': [
            "import '../../../core/constants/app_strings.dart';"
        ],
        'lib/features/lawyers/presentation/lawyer_profile_screen.dart': [
            "import 'package:go_router/go_router.dart';",
            "import '../../../core/constants/app_strings.dart';"
        ],
        'lib/features/lawyers/presentation/lawyers_list_screen.dart': [
            "import 'package:go_router/go_router.dart';"
        ],
        'lib/features/notifications/presentation/notifications_screen.dart': [
            "import '../../../core/constants/app_strings.dart';",
            "import '../../../shared/widgets/shimmer_loading.dart';"
        ],
        'lib/features/payments/presentation/payment_methods_screen.dart': [
            "import '../../../core/constants/app_colors.dart';"
        ],
        'lib/features/profile/presentation/edit_profile_screen.dart': [
            "import '../../../core/constants/app_colors.dart';"
        ],
        'lib/features/reviews/presentation/lawyer_reviews_screen.dart': [
            "import 'package:cached_network_image/cached_network_image.dart';"
        ],
        'lib/features/settings/presentation/settings_screen.dart': [
            "import '../../../core/constants/app_strings.dart';"
        ],
        'lib/features/voice_recording/presentation/providers/voice_recording_provider.dart': [
            "import 'package:permission_handler/permission_handler.dart';"
        ],
        'test/widget_test.dart': [
            "import 'package:flutter/material.dart';"
        ]
    }
    
    files_modified = 0
    
    for file_path, imports_to_remove in unused_imports.items():
        try:
            if os.path.exists(file_path):
                with open(file_path, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                original_content = content
                
                # Remove each unused import
                for import_line in imports_to_remove:
                    # Remove the import line (with possible extra whitespace/newlines)
                    content = re.sub(rf'^{re.escape(import_line)}\s*\n', '', content, flags=re.MULTILINE)
                
                if content != original_content:
                    with open(file_path, 'w', encoding='utf-8') as f:
                        f.write(content)
                    files_modified += 1
                    print(f"✅ Cleaned imports in: {file_path}")
                    
        except Exception as e:
            print(f"❌ Error processing {file_path}: {e}")
    
    print(f"\n🎉 Import cleanup complete!")
    print(f"✏️  Files modified: {files_modified}")

if __name__ == "__main__":
    print("🧹 Removing unused imports...")
    remove_unused_imports()