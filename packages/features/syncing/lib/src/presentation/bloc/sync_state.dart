import 'package:equatable/equatable.dart';

import '../../domain/repositories/sync_repository.dart';

sealed class SyncState extends Equatable {
  const SyncState();

  @override
  List<Object?> get props => [];
}

final class SyncInitial extends SyncState {}

class SyncInProgress extends SyncState {}

final class SyncSuccess extends SyncState {
  final SyncResult result;

  const SyncSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

final class SyncError extends SyncState {
  final String message;

  const SyncError(this.message);

  @override
  List<Object?> get props => [message];
}

final class LastSyncLoaded extends SyncState {
  final DateTime? lastSyncTime;

  const LastSyncLoaded(this.lastSyncTime);

  @override
  List<Object?> get props => [lastSyncTime];
}
