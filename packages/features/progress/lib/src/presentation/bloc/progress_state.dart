import 'package:equatable/equatable.dart';

import '../../domain/entities/user_progress.dart';

sealed class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object?> get props => [];
}

final class ProgressInitial extends ProgressState {}

final class ProgressLoading extends ProgressState {}

final class ProgressLoaded extends ProgressState {
  final UserProgress progress;

  const ProgressLoaded(this.progress);

  @override
  List<Object?> get props => [progress];
}

final class ProgressLeveledUp extends ProgressState {
  final int oldLevel;
  final int newLevel;
  final UserProgress progress;

  const ProgressLeveledUp({
    required this.oldLevel,
    required this.newLevel,
    required this.progress,
  });

  @override
  List<Object?> get props => [oldLevel, newLevel, progress];
}

final class ProgressError extends ProgressState {
  final String message;

  const ProgressError(this.message);

  @override
  List<Object?> get props => [message];
}
