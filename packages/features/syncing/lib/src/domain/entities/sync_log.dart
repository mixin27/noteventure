class SyncLog {
  final String id;
  final SyncType syncType;
  final bool success;
  final String? errorMessage;
  final int notesSynced;
  final int transactionsSynced;
  final bool progressSynced;
  final int conflictsFound;
  final int? durationMs;
  final DateTime syncedAt;

  const SyncLog({
    required this.id,
    required this.syncType,
    required this.success,
    this.errorMessage,
    this.notesSynced = 0,
    this.transactionsSynced = 0,
    this.progressSynced = false,
    this.conflictsFound = 0,
    this.durationMs,
    required this.syncedAt,
  });
}

enum SyncType {
  manual,
  background;

  String get displayName => switch (this) {
    SyncType.manual => 'Manual',
    SyncType.background => 'Background',
  };

  static SyncType fromString(String value) {
    return SyncType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => SyncType.manual,
    );
  }
}
