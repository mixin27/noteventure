import 'package:flutter/material.dart';

import '../../domain/entities/sync_log.dart';

class SyncLogItem extends StatelessWidget {
  final SyncLog log;

  const SyncLogItem({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(log.id),
      subtitle: Wrap(
        runSpacing: 10,
        spacing: 5,
        children: [
          Text(log.syncType.displayName),
          Text(log.success ? "Success" : "Failed"),
          Text(log.syncedAt.toIso8601String()),
        ],
      ),
    );
  }
}
