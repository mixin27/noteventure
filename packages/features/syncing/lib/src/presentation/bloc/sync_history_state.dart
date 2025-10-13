import 'package:equatable/equatable.dart';

import '../../domain/entities/sync_log.dart';

sealed class SyncHistoryState extends Equatable {
  const SyncHistoryState();

  @override
  List<Object?> get props => [];
}

final class SyncHistoryInitial extends SyncHistoryState {}

final class SyncHistoryLoading extends SyncHistoryState {
  const SyncHistoryLoading();
}

final class SyncHistoryLoaded extends SyncHistoryState {
  final List<SyncLog> syncLogs;

  const SyncHistoryLoaded({required this.syncLogs});

  @override
  List<Object?> get props => [syncLogs];
}

final class SyncHistoryCleared extends SyncHistoryState {
  final String message;

  const SyncHistoryCleared({
    this.message = 'Sync history cleared successfully!',
  });

  @override
  List<Object?> get props => [message];
}

final class SyncHistoryError extends SyncHistoryState {
  final String message;

  const SyncHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
