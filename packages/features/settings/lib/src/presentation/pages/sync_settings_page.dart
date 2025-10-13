import 'package:background_sync/background_sync.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncing/syncing.dart' as sync;

/// Unified sync settings page that handles both manual and background sync
class SyncSettingsPage extends StatelessWidget {
  const SyncSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sync Settings')),
      body: ListView(
        children: [
          // ═══════════════════════════════════════════════════════════════
          // SECTION 1: Manual Sync (using regular sync package)
          // ═══════════════════════════════════════════════════════════════
          _buildSectionHeader(context, 'Manual Sync'),

          BlocBuilder<sync.SyncBloc, sync.SyncState>(
            builder: (context, state) {
              final isSyncing = state is sync.SyncInProgress;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isSyncing ? Icons.sync : Icons.sync_outlined,
                            size: 32,
                            color: isSyncing ? Colors.blue : Colors.grey,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sync Now',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isSyncing
                                      ? 'Syncing your notes...'
                                      : 'Manually sync your notes',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: isSyncing
                            ? null
                            : () {
                                context.read<sync.SyncBloc>().add(
                                  sync.SyncRequested(),
                                );
                              },
                        icon: isSyncing
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Icon(Icons.sync),
                        label: Text(isSyncing ? 'Syncing...' : 'Sync Now'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 16),
          const Divider(),

          // ═══════════════════════════════════════════════════════════════
          // SECTION 2: Background Sync (using background_sync package)
          // ═══════════════════════════════════════════════════════════════
          _buildSectionHeader(context, 'Background Sync'),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Automatically sync your notes in the background, '
              'even when the app is closed.',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),

          // Background sync status widget
          const SyncStatusWidget(),

          // Background sync settings (frequency slider)
          const SyncSettingsWidget(),

          const Divider(),

          // ═══════════════════════════════════════════════════════════════
          // SECTION 3: Sync Options
          // ═══════════════════════════════════════════════════════════════
          _buildSectionHeader(context, 'Options'),

          SwitchListTile(
            secondary: const Icon(Icons.wifi),
            title: const Text('Wi-Fi Only'),
            subtitle: const Text('Only sync when connected to Wi-Fi'),
            value: false, // todo(mixin27): Implement
            onChanged: (value) {
              // todo(mixin27): Implement Wi-Fi only sync
            },
          ),

          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Sync History'),
            subtitle: const Text('View sync logs'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const sync.SyncHistoryPage()),
              );
            },
          ),

          const Divider(),

          // ═══════════════════════════════════════════════════════════════
          // SECTION 4: Information
          // ═══════════════════════════════════════════════════════════════
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About Sync'),
            onTap: () => _showAboutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('About Sync'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Manual Sync',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• Sync your notes on demand\n'
                '• Instant synchronization\n'
                '• Best when you need immediate updates',
              ),
              SizedBox(height: 16),
              Text(
                'Background Sync',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• Automatic synchronization\n'
                '• Works even when app is closed\n'
                '• Minimum frequency: 15 minutes (Android limitation)\n'
                '• Keeps your notes up-to-date across devices',
              ),
              SizedBox(height: 16),
              Text(
                'Both types of sync use the same backend and ensure your '
                'notes are always synchronized.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}
