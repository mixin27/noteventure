import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncing/src/presentation/bloc/sync_history_event.dart';

import '../bloc/sync_history_bloc.dart';
import '../bloc/sync_history_state.dart';
import '../widgets/sync_log_item.dart';

class SyncHistoryPage extends StatelessWidget {
  const SyncHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sync History')),
      body: BlocBuilder<SyncHistoryBloc, SyncHistoryState>(
        builder: (context, state) {
          if (state is SyncHistoryLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<SyncHistoryBloc>().add(RefreshSyncHistory());
              },
              child: ListView.builder(
                itemCount: state.syncLogs.length,
                itemBuilder: (context, index) {
                  final log = state.syncLogs[index];
                  return SyncLogItem(log: log);
                },
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
