#!/usr/bin/env python3

import os
import re
import glob

def fix_with_opacity_calls(content):
    """Replace .withOpacity(value) with .withValues(alpha: value)"""
    # Pattern to match .withOpacity(some_value) where some_value can be:
    # - a number (0.5, 0.8, etc.)
    # - a variable 
    # - an expression
    pattern = r'\.withOpacity\(([^)]+)\)'
    replacement = r'.withValues(alpha: \1)'
    return re.sub(pattern, replacement, content)

def fix_will_pop_scope(content):
    """Replace WillPopScope with PopScope (basic replacement)"""
    # For now, just replace the widget name - manual review needed for onWillPop
    content = content.replace('WillPopScope(', 'PopScope(')
    return content

def process_dart_files():
    """Process all Dart files in the lib directory"""
    
    os.chdir('/home/openclaw/.openclaw/workspace/LawConnectGH/mobile')
    
    # Find all .dart files in lib directory
    dart_files = glob.glob('lib/**/*.dart', recursive=True)
    
    total_files = 0
    modified_files = 0
    
    for file_path in dart_files:
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                original_content = f.read()
            
            total_files += 1
            
            # Apply fixes
            modified_content = fix_with_opacity_calls(original_content)
            modified_content = fix_will_pop_scope(modified_content)
            
            # Write back if content changed
            if modified_content != original_content:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(modified_content)
                modified_files += 1
                print(f"✅ Fixed: {file_path}")
            
        except Exception as e:
            print(f"❌ Error processing {file_path}: {e}")
    
    print(f"\n🎉 Processing complete!")
    print(f"📁 Total files processed: {total_files}")
    print(f"✏️  Files modified: {modified_files}")

if __name__ == "__main__":
    print("🔧 Starting Flutter deprecation fixes...")
    print("📍 Replacing .withOpacity() with .withValues()")
    print("📍 Replacing WillPopScope with PopScope")
    print()
    
    process_dart_files()