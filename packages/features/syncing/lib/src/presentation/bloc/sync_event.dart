import 'package:equatable/equatable.dart';

sealed class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object?> get props => [];
}

final class SyncRequested extends SyncEvent {}

final class PullRequested extends SyncEvent {}

final class PushRequested extends SyncEvent {}

final class GetLastSyncRequested extends SyncEvent {}
