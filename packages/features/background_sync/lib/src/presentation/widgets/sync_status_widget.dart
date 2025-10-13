import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/background_sync_bloc.dart';
import '../bloc/background_sync_event.dart';
import '../bloc/background_sync_state.dart';

class SyncStatusWidget extends StatelessWidget {
  const SyncStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BackgroundSyncBloc, BackgroundSyncState>(
      listener: (context, state) {
        // Show snackbar when sync is triggered
        if (state is BackgroundSyncTriggered) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text('Syncing in background...'),
                ],
              ),
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        return Card(
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(_getIcon(state), color: _getColor(state), size: 32),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Background Sync',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getStatusText(state),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    if (state is BackgroundSyncEnabled)
                      Switch(
                        value: true,
                        onChanged: (value) {
                          context.read<BackgroundSyncBloc>().add(
                            DisableBackgroundSyncEvent(),
                          );
                        },
                      ),
                    if (state is BackgroundSyncDisabled)
                      Switch(
                        value: false,
                        onChanged: (value) {
                          context.read<BackgroundSyncBloc>().add(
                            const EnableBackgroundSyncEvent(),
                          );
                        },
                      ),
                  ],
                ),
                if (state is BackgroundSyncEnabled ||
                    state is BackgroundSyncTriggered) ...[
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: state is BackgroundSyncTriggered
                        ? null // Disable while syncing
                        : () {
                            context.read<BackgroundSyncBloc>().add(
                              TriggerImmediateSyncEvent(),
                            );
                          },
                    icon: state is BackgroundSyncTriggered
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
                    label: Text(
                      state is BackgroundSyncTriggered
                          ? 'Syncing...'
                          : 'Sync Now',
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getIcon(BackgroundSyncState state) {
    if (state is BackgroundSyncTriggered) return Icons.cloud_sync;
    if (state is BackgroundSyncEnabled) return Icons.cloud_done;
    if (state is BackgroundSyncDisabled) return Icons.cloud_off;
    if (state is BackgroundSyncError) return Icons.error_outline;
    if (state is BackgroundSyncLoading) return Icons.cloud_sync;
    return Icons.cloud_queue;
  }

  Color _getColor(BackgroundSyncState state) {
    if (state is BackgroundSyncEnabled) return Colors.green;
    if (state is BackgroundSyncTriggered) return Colors.orange;
    if (state is BackgroundSyncError) return Colors.red;
    if (state is BackgroundSyncLoading) return Colors.orange;
    return Colors.grey;
  }

  String _getStatusText(BackgroundSyncState state) {
    if (state is BackgroundSyncTriggered) {
      return 'Syncing now...';
    }
    if (state is BackgroundSyncEnabled) {
      final lastSyncText = state.lastSyncTime != null
          ? ' • Last synced ${_formatTime(state.lastSyncTime!)}'
          : '';
      return 'Active • Every ${state.syncFrequency.inMinutes} min$lastSyncText';
    }
    if (state is BackgroundSyncDisabled) return 'Disabled';
    if (state is BackgroundSyncError) return 'Error: ${state.message}';
    if (state is BackgroundSyncLoading) return 'Loading...';
    return 'Not initialized';
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
