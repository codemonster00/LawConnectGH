#!/usr/bin/env python3

import os
import re

def fix_unused_variables():
    """Fix unused variables and fields issues"""
    
    os.chdir('/home/openclaw/.openclaw/workspace/LawConnectGH/mobile')
    
    files_fixed = 0
    
    # Fix unused variables in settings_screen.dart
    file_path = 'lib/features/settings/presentation/settings_screen.dart'
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        
        original_content = content
        
        # Comment out unused variables
        content = re.sub(r'(\s+)final colorScheme = Theme\.of\(context\)\.colorScheme;', r'\1// final colorScheme = Theme.of(context).colorScheme; // unused', content)
        content = re.sub(r'(\s+)final isDarkMode = Theme\.of\(context\)\.brightness == Brightness\.dark;', r'\1// final isDarkMode = Theme.of(context).brightness == Brightness.dark; // unused', content)
        
        if content != original_content:
            with open(file_path, 'w') as f:
                f.write(content)
            files_fixed += 1
            print(f"✅ Fixed unused variables in: {file_path}")
    except Exception as e:
        print(f"❌ Error processing {file_path}: {e}")
    
    # Fix unused variables in voice_recording_screen.dart
    file_path = 'lib/features/voice_recording/presentation/voice_recording_screen.dart'
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        
        original_content = content
        
        # Comment out unused theme variable
        content = re.sub(r'(\s+)final theme = Theme\.of\(context\);', r'\1// final theme = Theme.of(context); // unused', content)
        
        if content != original_content:
            with open(file_path, 'w') as f:
                f.write(content)
            files_fixed += 1
            print(f"✅ Fixed unused variables in: {file_path}")
    except Exception as e:
        print(f"❌ Error processing {file_path}: {e}")
    
    # Fix unused variables in saved_recordings_list.dart
    file_path = 'lib/features/voice_recording/presentation/widgets/saved_recordings_list.dart'
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        
        original_content = content
        
        # Comment out unused theme variable
        content = re.sub(r'(\s+)final theme = Theme\.of\(context\);', r'\1// final theme = Theme.of(context); // unused', content)
        
        if content != original_content:
            with open(file_path, 'w') as f:
                f.write(content)
            files_fixed += 1
            print(f"✅ Fixed unused variables in: {file_path}")
    except Exception as e:
        print(f"❌ Error processing {file_path}: {e}")
    
    # Fix unused variables in audio_waveform_visualizer.dart
    file_path = 'lib/features/voice_recording/presentation/widgets/audio_waveform_visualizer.dart'
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        
        original_content = content
        
        # Comment out unused renderBox variable
        content = re.sub(r'(\s+)final renderBox = context\.findRenderObject\(\) as RenderBox;', r'\1// final renderBox = context.findRenderObject() as RenderBox; // unused', content)
        
        if content != original_content:
            with open(file_path, 'w') as f:
                f.write(content)
            files_fixed += 1
            print(f"✅ Fixed unused variables in: {file_path}")
    except Exception as e:
        print(f"❌ Error processing {file_path}: {e}")
    
    # Fix unused variables in app_button.dart
    file_path = 'lib/shared/widgets/app_button.dart'
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        
        original_content = content
        
        # Comment out unused variables
        content = re.sub(r'(\s+)final buttonStyle = FilledButton\.styleFrom\(', r'\1// final buttonStyle = FilledButton.styleFrom( // unused', content)
        content = re.sub(r'(\s+)final isDisabled = onPressed == null;', r'\1// final isDisabled = onPressed == null; // unused', content)
        
        if content != original_content:
            with open(file_path, 'w') as f:
                f.write(content)
            files_fixed += 1
            print(f"✅ Fixed unused variables in: {file_path}")
    except Exception as e:
        print(f"❌ Error processing {file_path}: {e}")
    
    # Fix unused variables in consultation_status_badge.dart
    file_path = 'lib/shared/widgets/consultation_status_badge.dart'
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        
        original_content = content
        
        # Comment out unused isActive variable
        content = re.sub(r'(\s+)final bool isActive = status == ConsultationStatus\.active;', r'\1// final bool isActive = status == ConsultationStatus.active; // unused', content)
        
        if content != original_content:
            with open(file_path, 'w') as f:
                f.write(content)
            files_fixed += 1
            print(f"✅ Fixed unused variables in: {file_path}")
    except Exception as e:
        print(f"❌ Error processing {file_path}: {e}")
    
    print(f"\n🎉 Unused variable fixes complete!")
    print(f"✏️  Files modified: {files_fixed}")

if __name__ == "__main__":
    print("🧹 Fixing unused variables...")
    fix_unused_variables()