#!/usr/bin/env python3

import os
import re

def clean_remaining_warnings():
    """Clean up remaining warnings from flutter analyze"""
    
    os.chdir('/home/openclaw/.openclaw/workspace/LawConnectGH/mobile')
    
    files_fixed = 0
    
    # Comment out unused variables in settings_screen.dart
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
    
    # Fix unused theme variable in voice_recording_screen.dart - remove it since it's not used in this specific widget
    file_path = 'lib/features/voice_recording/presentation/voice_recording_screen.dart'
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        
        original_content = content
        
        # Find and comment out the unused theme variable in _SaveRecordingDialog
        # This one is specifically in _SaveRecordingDialog where theme is not used
        if 'class _SaveRecordingDialog' in content:
            # Replace just that specific occurrence
            pattern = r'(class _SaveRecordingDialog.*?@override\s+Widget build\(BuildContext context\) \{\s*)(final theme = Theme\.of\(context\);)'
            replacement = r'\1// final theme = Theme.of(context); // unused in this widget'
            content = re.sub(pattern, replacement, content, flags=re.DOTALL)
            
        if content != original_content:
            with open(file_path, 'w') as f:
                f.write(content)
            files_fixed += 1
            print(f"✅ Fixed unused theme variable in: {file_path}")
    except Exception as e:
        print(f"❌ Error processing {file_path}: {e}")
    
    # Comment out unused variables in audio_waveform_visualizer.dart
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
    
    # Comment out unused variables in app_button.dart  
    file_path = 'lib/shared/widgets/app_button.dart'
    try:
        with open(file_path, 'r') as f:
            content = f.read()
        
        original_content = content
        
        # Comment out unused variables - be more specific to avoid breaking actual code
        content = re.sub(r'(\s+)final buttonStyle = FilledButton\.styleFrom\(([^;]+);', r'\1// final buttonStyle = FilledButton.styleFrom(\2; // unused', content)
        content = re.sub(r'(\s+)final isDisabled = onPressed == null;', r'\1// final isDisabled = onPressed == null; // unused', content)
        
        if content != original_content:
            with open(file_path, 'w') as f:
                f.write(content)
            files_fixed += 1
            print(f"✅ Fixed unused variables in: {file_path}")
    except Exception as e:
        print(f"❌ Error processing {file_path}: {e}")
    
    print(f"\n🎉 Warning cleanup complete!")
    print(f"✏️  Files modified: {files_fixed}")

if __name__ == "__main__":
    print("🧹 Cleaning up remaining warnings...")
    clean_remaining_warnings()