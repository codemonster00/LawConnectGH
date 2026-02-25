import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../providers/theme_provider.dart';

/// Settings screen with Material Design 3 interface and theme controls
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final themeMode = ref.watch(themeModeProvider);
    final useDynamicColor = ref.watch(useDynamicColorProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Section
            _SettingsSection(
              title: 'Appearance',
              icon: Icons.palette_rounded,
              children: [
                _ThemeModeCard(
                  currentMode: themeMode,
                  onModeChanged: (mode) {
                    ref.read(themeModeProvider.notifier).setThemeMode(mode);
                  },
                ),
                
                const SizedBox(height: 12),
                
                _DynamicColorCard(
                  isEnabled: useDynamicColor,
                  onToggle: () {
                    ref.read(useDynamicColorProvider.notifier).toggle();
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // App Section
            _SettingsSection(
              title: 'App Settings',
              icon: Icons.settings_rounded,
              children: [
                _SettingsTile(
                  leading: Icon(Icons.notifications_rounded),
                  title: 'Notifications',
                  subtitle: 'Manage notification preferences',
                  onTap: () {
                    // TODO: Navigate to notification settings
                  },
                ),
                
                const SizedBox(height: 8),
                
                _SettingsTile(
                  leading: Icon(Icons.security_rounded),
                  title: 'Privacy & Security',
                  subtitle: 'Manage your privacy settings',
                  onTap: () {
                    // TODO: Navigate to privacy settings
                  },
                ),
                
                const SizedBox(height: 8),
                
                _SettingsTile(
                  leading: Icon(Icons.language_rounded),
                  title: 'Language',
                  subtitle: 'English',
                  onTap: () {
                    // TODO: Show language picker
                  },
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // About Section
            _SettingsSection(
              title: 'About',
              icon: Icons.info_rounded,
              children: [
                _SettingsTile(
                  leading: Icon(Icons.help_rounded),
                  title: 'Help & Support',
                  subtitle: 'Get help with LawConnect GH',
                  onTap: () {
                    // TODO: Navigate to help
                  },
                ),
                
                const SizedBox(height: 8),
                
                _SettingsTile(
                  leading: Icon(Icons.gavel_rounded),
                  title: 'Terms of Service',
                  onTap: () {
                    // TODO: Show terms
                  },
                ),
                
                const SizedBox(height: 8),
                
                _SettingsTile(
                  leading: Icon(Icons.privacy_tip_rounded),
                  title: 'Privacy Policy',
                  onTap: () {
                    // TODO: Show privacy policy
                  },
                ),
                
                const SizedBox(height: 8),
                
                _SettingsTile(
                  leading: Icon(Icons.info_outline_rounded),
                  title: 'App Version',
                  subtitle: '1.0.0',
                ),
              ],
            ),
            
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

/// Settings section with title and children
class _SettingsSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    ).animate(
      effects: [
        const SlideEffect(
          duration: Duration(milliseconds: 300),
          begin: Offset(0, 0.2),
          curve: Curves.easeOut,
        ),
        const FadeEffect(
          duration: Duration(milliseconds: 400),
        ),
      ],
    );
  }
}

/// Theme mode selection card
class _ThemeModeCard extends StatelessWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onModeChanged;

  const _ThemeModeCard({
    required this.currentMode,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.brightness_6_rounded,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Theme Mode',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Theme options
            Row(
              children: [
                Expanded(
                  child: _ThemeOption(
                    icon: Icons.light_mode_rounded,
                    label: 'Light',
                    isSelected: currentMode == ThemeMode.light,
                    onTap: () => onModeChanged(ThemeMode.light),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ThemeOption(
                    icon: Icons.dark_mode_rounded,
                    label: 'Dark',
                    isSelected: currentMode == ThemeMode.dark,
                    onTap: () => onModeChanged(ThemeMode.dark),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ThemeOption(
                    icon: Icons.auto_mode_rounded,
                    label: 'Auto',
                    isSelected: currentMode == ThemeMode.system,
                    onTap: () => onModeChanged(ThemeMode.system),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual theme option
class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected 
              ? colorScheme.primaryContainer 
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: isSelected 
              ? Border.all(color: colorScheme.primary, width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onSurfaceVariant,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: isSelected 
                    ? colorScheme.onPrimaryContainer
                    : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Dynamic color toggle card
class _DynamicColorCard extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onToggle;

  const _DynamicColorCard({
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      child: SwitchListTile(
        secondary: Icon(
          Icons.color_lens_rounded,
          color: colorScheme.primary,
        ),
        title: Text(
          'Dynamic Colors',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          'Use colors from your wallpaper (Android 12+)',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        value: isEnabled,
        onChanged: (_) => onToggle(),
      ),
    );
  }
}

/// Settings tile widget
class _SettingsTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.leading,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: leading,
        title: Text(
          title,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null 
            ? Text(
                subtitle!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            : null,
        trailing: onTap != null 
            ? Icon(
                Icons.chevron_right_rounded,
                color: theme.colorScheme.onSurfaceVariant,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}