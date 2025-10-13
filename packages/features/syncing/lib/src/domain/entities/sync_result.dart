import 'package:equatable/equatable.dart';

/// Result of a sync operation
class SyncResult extends Equatable {
  final int notesSynced;
  final int transactionsSynced;
  final bool progressSynced;
  final int conflictsFound;
  final DateTime syncedAt;

  const SyncResult({
    required this.notesSynced,
    required this.transactionsSynced,
    required this.progressSynced,
    required this.conflictsFound,
    required this.syncedAt,
  });

  @override
  List<Object?> get props => [
    notesSynced,
    transactionsSynced,
    progressSynced,
    conflictsFound,
    syncedAt,
  ];
}
