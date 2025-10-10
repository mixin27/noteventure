import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Tools')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          // Auth Status
          _buildSection(
            title: 'Authentication Status',
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('State', state.runtimeType.toString()),
                    if (state is AuthAuthenticated) ...[
                      _buildInfoRow('User ID', state.user.id),
                      _buildInfoRow('Email', state.user.email),
                      _buildInfoRow('Username', state.user.username ?? 'N/A'),
                      const SizedBox(height: AppSpacing.sm),
                      ElevatedButton(
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: state.user.accessToken),
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Access token copied!'),
                              ),
                            );
                          }
                        },
                        child: const Text('Copy Access Token'),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // API Configuration
          _buildSection(
            title: 'API Configuration',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow('Base URL', ApiConfig.baseUrl),
                _buildInfoRow(
                  'Environment',
                  ApiConfig.baseUrl.contains('localhost')
                      ? 'Development'
                      : 'Production',
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Storage Info
          _buildSection(
            title: 'Storage',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final tokenStorage = TokenStorage();
                    final hasToken = await tokenStorage.hasValidToken();
                    final accessToken = await tokenStorage.getAccessToken();

                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Token Info'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Has Token: $hasToken'),
                              const SizedBox(height: 8),
                              Text(
                                'Token Preview: ${accessToken?.substring(0, 20) ?? 'N/A'}...',
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text('Check Token Storage'),
                ),
                const SizedBox(height: AppSpacing.sm),
                ElevatedButton(
                  onPressed: () async {
                    final tokenStorage = TokenStorage();
                    await tokenStorage.clearTokens();

                    final userStorage = UserStorage();
                    await userStorage.clearUser();

                    if (context.mounted) {
                      context.read<AuthBloc>().add(AuthCheckStatusRequested());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Storage cleared!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                  ),
                  child: const Text('Clear All Storage'),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          // Quick Actions
          _buildSection(
            title: 'Quick Actions',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthCheckStatusRequested());
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Refresh Auth Status'),
                ),
                const SizedBox(height: AppSpacing.sm),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogoutRequested());
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Force Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.warning,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: AppColors.textSecondaryLight),
            ),
          ),
        ],
      ),
    );
  }
}
