#!/bin/bash

# Script to replace all .withOpacity() calls with .withValues() in Flutter project
# This addresses the deprecation warning in Flutter 3.27+

echo "🔧 Replacing .withOpacity() with .withValues() across the Flutter project..."

cd /home/openclaw/.openclaw/workspace/LawConnectGH/mobile

# Find all Dart files and replace .withOpacity(value) with .withValues(alpha: value)
find lib -name "*.dart" -exec sed -i 's/\.withOpacity(\([^)]*\))/.withValues(alpha: \1)/g' {} \;

echo "✅ All .withOpacity() calls replaced with .withValues()!"

# Also replace WillPopScope with PopScope
echo "🔧 Replacing WillPopScope with PopScope..."

find lib -name "*.dart" -exec sed -i 's/WillPopScope(/PopScope(/g' {} \;
find lib -name "*.dart" -exec sed -i 's/onWillPop:/canPop: false, onPopInvokedWithResult: (didPop, result) async { if (!didPop) { /g' {} \;

echo "✅ WillPopScope replacement completed!"
echo "🎉 All critical fixes applied!"