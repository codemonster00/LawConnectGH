import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Theme mode state provider with persistence
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

/// Dynamic color preference provider with persistence  
final useDynamicColorProvider = StateNotifierProvider<DynamicColorNotifier, bool>((ref) {
  return DynamicColorNotifier();
});

/// Theme mode notifier that persists selection
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  static const String _key = 'theme_mode';
  
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeIndex = prefs.getInt(_key) ?? ThemeMode.system.index;
      state = ThemeMode.values[themeModeIndex];
    } catch (e) {
      // If loading fails, keep default system mode
      debugPrint('Failed to load theme mode: $e');
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_key, mode.index);
    } catch (e) {
      debugPrint('Failed to save theme mode: $e');
    }
  }
  
  void setLight() => setThemeMode(ThemeMode.light);
  void setDark() => setThemeMode(ThemeMode.dark);
  void setSystem() => setThemeMode(ThemeMode.system);
}

/// Dynamic color preference notifier with persistence
class DynamicColorNotifier extends StateNotifier<bool> {
  static const String _key = 'use_dynamic_color';
  
  DynamicColorNotifier() : super(true) {
    _loadDynamicColorPreference();
  }

  Future<void> _loadDynamicColorPreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      state = prefs.getBool(_key) ?? true; // Default to true
    } catch (e) {
      debugPrint('Failed to load dynamic color preference: $e');
    }
  }

  Future<void> setUseDynamicColor(bool use) async {
    state = use;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_key, use);
    } catch (e) {
      debugPrint('Failed to save dynamic color preference: $e');
    }
  }
  
  void toggle() => setUseDynamicColor(!state);
}

/// Computed provider for current brightness
final currentBrightnessProvider = Provider<Brightness>((ref) {
  return WidgetsBinding.instance.platformDispatcher.platformBrightness;
});

/// Helper provider to check if dark mode is active
final isDarkModeProvider = Provider<bool>((ref) {
  final themeMode = ref.watch(themeModeProvider);
  final currentBrightness = ref.watch(currentBrightnessProvider);
  
  switch (themeMode) {
    case ThemeMode.dark:
      return true;
    case ThemeMode.light:
      return false;
    case ThemeMode.system:
      return currentBrightness == Brightness.dark;
  }
});