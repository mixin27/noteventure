import 'package:equatable/equatable.dart';

sealed class ProgressEvent extends Equatable {
  const ProgressEvent();

  @override
  List<Object?> get props => [];
}

final class LoadUserProgress extends ProgressEvent {}

final class AddXpEvent extends ProgressEvent {
  final int amount;

  const AddXpEvent(this.amount);

  @override
  List<Object?> get props => [amount];
}

final class UpdateStreakEvent extends ProgressEvent {
  final bool success;

  const UpdateStreakEvent(this.success);

  @override
  List<Object?> get props => [success];
}
