import 'package:equatable/equatable.dart';

sealed class BackgroundSyncEvent extends Equatable {
  const BackgroundSyncEvent();

  @override
  List<Object?> get props => [];
}

final class InitializeBackgroundSyncEvent extends BackgroundSyncEvent {
  final Duration syncFrequency;
  final bool enableDebugMode;

  const InitializeBackgroundSyncEvent({
    this.syncFrequency = const Duration(minutes: 15),
    this.enableDebugMode = false,
  });

  @override
  List<Object?> get props => [syncFrequency, enableDebugMode];
}

final class TriggerImmediateSyncEvent extends BackgroundSyncEvent {}

final class EnableBackgroundSyncEvent extends BackgroundSyncEvent {
  final Duration syncFrequency;

  const EnableBackgroundSyncEvent({
    this.syncFrequency = const Duration(minutes: 15),
  });

  @override
  List<Object?> get props => [syncFrequency];
}

final class DisableBackgroundSyncEvent extends BackgroundSyncEvent {}

final class UpdateSyncFrequencyEvent extends BackgroundSyncEvent {
  final Duration frequency;

  const UpdateSyncFrequencyEvent(this.frequency);

  @override
  List<Object?> get props => [frequency];
}

final class CheckSyncStatusEvent extends BackgroundSyncEvent {}

final class SyncCompletedEvent extends BackgroundSyncEvent {
  final bool success;

  const SyncCompletedEvent({required this.success});

  @override
  List<Object?> get props => [success];
}
