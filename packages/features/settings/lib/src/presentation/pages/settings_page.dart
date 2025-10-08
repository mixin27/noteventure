import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/app_settings.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_event.dart';
import '../bloc/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SettingsBloc, SettingsState>(
      listener: (context, state) {
        if (state is SettingsResetSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Settings reset to defaults'),
              backgroundColor: AppColors.success,
            ),
          );
        }
        if (state is SettingsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            tooltip: 'Reset to defaults',
            onPressed: () => _showResetDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          if (state is SettingsLoading) {
            return const LoadingIndicator(message: 'Loading settings...');
          }

          if (state is SettingsError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () => context.read<SettingsBloc>().add(LoadSettings()),
            );
          }

          if (state is SettingsLoaded) {
            final settings = state.settings;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Audio & Feedback Section
                  _buildSectionTitle(context, 'Audio & Feedback'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildAudioFeedbackSettings(context, settings),
                  const SizedBox(height: AppSpacing.lg),

                  // Gameplay Section
                  _buildSectionTitle(context, 'Gameplay'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildGameplaySettings(context, settings),
                  const SizedBox(height: AppSpacing.lg),

                  // Appearance Section
                  _buildSectionTitle(context, 'Appearance'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildAppearanceSettings(context, settings),
                  const SizedBox(height: AppSpacing.lg),

                  // Challenge Settings Section
                  _buildSectionTitle(context, 'Challenge Settings'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildChallengeSettings(context, settings),
                  const SizedBox(height: AppSpacing.lg),

                  // Content Section
                  _buildSectionTitle(context, 'Content'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildContentSettings(context, settings),
                  const SizedBox(height: AppSpacing.lg),

                  // About Section
                  _buildSectionTitle(context, 'About'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildAboutSection(context),
                  const SizedBox(height: AppSpacing.lg),

                  _buildSectionTitle(context, 'Account'),
                  const SizedBox(height: AppSpacing.sm),
                  _buildAuthSection(context),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildAudioFeedbackSettings(
    BuildContext context,
    AppSettings settings,
  ) {
    return CustomCard(
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Sound Effects'),
            subtitle: const Text('Play sounds for actions and feedback'),
            value: settings.soundEnabled,
            onChanged: (value) {
              context.read<SettingsBloc>().add(UpdateSoundEnabled(value));
            },
            secondary: const Icon(Icons.volume_up),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Haptic Feedback'),
            subtitle: const Text('Vibration feedback for interactions'),
            value: settings.hapticFeedbackEnabled,
            onChanged: (value) {
              context.read<SettingsBloc>().add(UpdateHapticFeedback(value));
            },
            secondary: const Icon(Icons.vibration),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Notifications'),
            subtitle: const Text('Daily challenges and chaos events'),
            value: settings.notificationsEnabled,
            onChanged: (value) {
              context.read<SettingsBloc>().add(
                UpdateNotificationsEnabled(value),
              );
            },
            secondary: const Icon(Icons.notifications),
          ),
        ],
      ),
    );
  }

  Widget _buildGameplaySettings(BuildContext context, AppSettings settings) {
    return CustomCard(
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('Chaos Mode'),
            subtitle: Text(
              settings.chaosEnabled
                  ? 'Random events are enabled'
                  : 'Random events are disabled',
            ),
            value: settings.chaosEnabled,
            onChanged: (value) {
              context.read<SettingsBloc>().add(UpdateChaosEnabled(value));
            },
            secondary: Icon(
              Icons.casino,
              color: settings.chaosEnabled ? AppColors.warning : null,
            ),
          ),
          if (!settings.chaosEnabled)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 20,
                      color: AppColors.info,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Chaos mode disabled. You can still disable it temporarily in-game for points.',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: AppColors.info),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAppearanceSettings(BuildContext context, AppSettings settings) {
    return CustomCard(
      child: Column(
        children: [
          ListTile(
            title: const Text('Theme Mode'),
            subtitle: Text(_getThemeModeLabel(settings.themeMode)),
            leading: Icon(_getThemeModeIcon(settings.themeMode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showThemeModeDialog(context, settings.themeMode),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeSettings(BuildContext context, AppSettings settings) {
    return CustomCard(
      child: Column(
        children: [
          ListTile(
            title: const Text('Challenge Time Limit'),
            subtitle: Text(
              '${settings.challengeTimeLimit} seconds per challenge',
            ),
            leading: const Icon(Icons.timer),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Column(
              children: [
                Slider(
                  value: settings.challengeTimeLimit.toDouble(),
                  min: 10,
                  max: 120,
                  divisions: 22, // (120-10)/5 = 22 steps of 5 seconds
                  label: '${settings.challengeTimeLimit}s',
                  onChanged: (value) {
                    context.read<SettingsBloc>().add(
                      UpdateChallengeTimeLimit(value.round()),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('10s', style: Theme.of(context).textTheme.bodySmall),
                    Text('120s', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Personality Tone'),
            subtitle: Text(_getPersonalityLabel(settings.personalityTone)),
            leading: Icon(_getPersonalityIcon(settings.personalityTone)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () =>
                _showPersonalityDialog(context, settings.personalityTone),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSettings(BuildContext context, AppSettings settings) {
    return CustomCard(
      child: SwitchListTile(
        title: const Text('Profanity Filter'),
        subtitle: const Text('Filter inappropriate language'),
        value: settings.profanityFilter,
        onChanged: (value) {
          context.read<SettingsBloc>().add(UpdateProfanityFilter(value));
        },
        secondary: const Icon(Icons.block),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          ListTile(
            title: const Text('Version'),
            subtitle: const Text('1.0.0'),
            leading: const Icon(Icons.info),
          ),
          const Divider(),
          ListTile(
            title: const Text('GitHub Repository'),
            subtitle: const Text('View source code'),
            leading: const Icon(Icons.code),
            trailing: const Icon(Icons.open_in_new),
            onTap: () async {
              final uri = Uri.parse('https://github.com/mixin27/noteventure');
              if (!await launchUrl(uri)) {
                throw Exception('Could not launch $uri');
              }
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Licenses'),
            subtitle: const Text('View open source licenses'),
            leading: const Icon(Icons.description),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showLicensePage(context: context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAuthSection(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go("/login");
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state is AuthAuthenticated ? state.user : null;
          return CustomCard(
            child: Column(
              children: [
                ListTile(
                  title: Text(user?.username ?? ""),
                  subtitle: Text(user?.email ?? ""),
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: AppColors.error),
                  title: Text(
                    'Logout',
                    style: TextStyle(color: AppColors.error),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              context.read<AuthBloc>().add(
                                AuthLogoutRequested(),
                              );
                            },
                            child: Text(
                              'Logout',
                              style: TextStyle(color: AppColors.error),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Helper methods
  String _getThemeModeLabel(String mode) {
    switch (mode) {
      case 'light':
        return 'Light';
      case 'dark':
        return 'Dark';
      case 'system':
        return 'System default';
      default:
        return 'System default';
    }
  }

  IconData _getThemeModeIcon(String mode) {
    switch (mode) {
      case 'light':
        return Icons.light_mode;
      case 'dark':
        return Icons.dark_mode;
      case 'system':
        return Icons.brightness_auto;
      default:
        return Icons.brightness_auto;
    }
  }

  String _getPersonalityLabel(String tone) {
    switch (tone) {
      case 'random':
        return 'Random (surprise me!)';
      case 'sarcastic':
        return 'Sarcastic';
      case 'wholesome':
        return 'Wholesome';
      case 'chaotic':
        return 'Chaotic';
      case 'deadpan':
        return 'Deadpan';
      default:
        return 'Random';
    }
  }

  IconData _getPersonalityIcon(String tone) {
    switch (tone) {
      case 'random':
        return Icons.shuffle;
      case 'sarcastic':
        return Icons.mood;
      case 'wholesome':
        return Icons.favorite;
      case 'chaotic':
        return Icons.whatshot;
      case 'deadpan':
        return Icons.sentiment_neutral;
      default:
        return Icons.shuffle;
    }
  }

  void _showThemeModeDialog(BuildContext context, String currentMode) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Theme Mode'),
        content: RadioGroup<String>(
          groupValue: currentMode,
          onChanged: (value) {
            if (value != null) {
              context.read<SettingsBloc>().add(UpdateThemeMode(value));
              Navigator.of(dialogContext).pop();
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: const Text('Light'),
                subtitle: const Text('Always use light theme'),
                value: 'light',
              ),
              RadioListTile<String>(
                title: const Text('Dark'),
                subtitle: const Text('Always use dark theme'),
                value: 'dark',
              ),
              RadioListTile<String>(
                title: const Text('System'),
                subtitle: const Text('Follow system settings'),
                value: 'system',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showPersonalityDialog(BuildContext context, String currentTone) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Personality Tone'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildPersonalityOption(
                context: context,
                dialogContext: dialogContext,
                value: 'random',
                title: 'Random',
                subtitle: 'Mix of all personalities',
                currentTone: currentTone,
              ),
              _buildPersonalityOption(
                context: context,
                dialogContext: dialogContext,
                value: 'sarcastic',
                title: 'Sarcastic',
                subtitle: 'Witty and teasing responses',
                currentTone: currentTone,
              ),
              _buildPersonalityOption(
                context: context,
                dialogContext: dialogContext,
                value: 'wholesome',
                title: 'Wholesome',
                subtitle: 'Supportive and encouraging',
                currentTone: currentTone,
              ),
              _buildPersonalityOption(
                context: context,
                dialogContext: dialogContext,
                value: 'chaotic',
                title: 'Chaotic',
                subtitle: 'Unpredictable and wild',
                currentTone: currentTone,
              ),
              _buildPersonalityOption(
                context: context,
                dialogContext: dialogContext,
                value: 'deadpan',
                title: 'Deadpan',
                subtitle: 'Dry and matter-of-fact',
                currentTone: currentTone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalityOption({
    required BuildContext context,
    required BuildContext dialogContext,
    required String value,
    required String title,
    required String subtitle,
    required String currentTone,
  }) {
    return RadioGroup<String>(
      groupValue: currentTone,
      onChanged: (selectedValue) {
        if (selectedValue != null) {
          context.read<SettingsBloc>().add(
            UpdatePersonalityTone(selectedValue),
          );
          Navigator.of(dialogContext).pop();
        }
      },
      child: RadioListTile<String>(
        title: Text(title),
        subtitle: Text(subtitle),
        value: value,
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
          'Are you sure you want to reset all settings to their default values? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<SettingsBloc>().add(ResetAllSettings());
              Navigator.of(dialogContext).pop();
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
