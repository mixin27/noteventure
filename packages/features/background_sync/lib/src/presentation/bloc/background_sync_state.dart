import 'package:equatable/equatable.dart';

sealed class BackgroundSyncState extends Equatable {
  const BackgroundSyncState();

  @override
  List<Object?> get props => [];
}

final class BackgroundSyncInitial extends BackgroundSyncState {}

final class BackgroundSyncLoading extends BackgroundSyncState {}

final class BackgroundSyncEnabled extends BackgroundSyncState {
  final Duration syncFrequency;
  final DateTime? lastSyncTime;

  const BackgroundSyncEnabled({required this.syncFrequency, this.lastSyncTime});

  @override
  List<Object?> get props => [syncFrequency, lastSyncTime];
}

final class BackgroundSyncDisabled extends BackgroundSyncState {}

final class BackgroundSyncError extends BackgroundSyncState {
  final String message;

  const BackgroundSyncError(this.message);

  @override
  List<Object?> get props => [message];
}

final class BackgroundSyncTriggered extends BackgroundSyncState {}
