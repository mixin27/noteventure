import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sync_bloc.dart';
import '../bloc/sync_event.dart';
import '../bloc/sync_state.dart';

class SyncDetailsDialog extends StatefulWidget {
  const SyncDetailsDialog({super.key});

  @override
  State<SyncDetailsDialog> createState() => _SyncDetailsDialogState();
}

class _SyncDetailsDialogState extends State<SyncDetailsDialog> {
  @override
  void initState() {
    super.initState();
    // Load last sync time
    context.read<SyncBloc>().add(GetLastSyncRequested());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Sync Status'),
      content: BlocBuilder<SyncBloc, SyncState>(
        builder: (context, state) {
          if (state is SyncInProgress) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Syncing...'),
              ],
            );
          }

          if (state is LastSyncLoaded) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  'Last Sync',
                  state.lastSyncTime?.timeAgo ?? 'Never',
                ),
                const SizedBox(height: 8),
                _buildInfoRow(
                  'Status',
                  state.lastSyncTime != null ? 'Up to date' : 'Not synced',
                ),
              ],
            );
          }

          if (state is SyncSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 48),
                const SizedBox(height: 16),
                _buildInfoRow('Notes Synced', '${state.result.notesSynced}'),
                _buildInfoRow(
                  'Transactions',
                  '${state.result.transactionsSynced}',
                ),
                _buildInfoRow(
                  'Progress',
                  state.result.progressSynced ? 'Yes' : 'No',
                ),
                if (state.result.conflictsFound > 0)
                  _buildInfoRow(
                    'Conflicts',
                    '${state.result.conflictsFound}',
                    Colors.orange,
                  ),
              ],
            );
          }

          if (state is SyncError) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(state.message, style: const TextStyle(color: Colors.red)),
              ],
            );
          }

          return const Text('No sync information available');
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
        ElevatedButton.icon(
          onPressed: () {
            context.read<SyncBloc>().add(SyncRequested());
          },
          icon: const Icon(Icons.sync),
          label: const Text('Sync Now'),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, [Color? valueColor]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value, style: TextStyle(color: valueColor ?? Colors.grey[600])),
        ],
      ),
    );
  }
}
