import 'package:equatable/equatable.dart';

sealed class PointsEvent extends Equatable {
  const PointsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadPointBalance extends PointsEvent {}

final class SpendPointsEvent extends PointsEvent {
  final int amount;
  final String reason;
  final String? description;
  final String? relatedNoteId;

  const SpendPointsEvent({
    required this.amount,
    required this.reason,
    this.description,
    this.relatedNoteId,
  });

  @override
  List<Object?> get props => [amount, reason, description, relatedNoteId];
}

final class EarnPointsEvent extends PointsEvent {
  final int amount;
  final String reason;
  final String? description;
  final String? relatedChallengeId;

  const EarnPointsEvent({
    required this.amount,
    required this.reason,
    this.description,
    this.relatedChallengeId,
  });

  @override
  List<Object?> get props => [amount, reason, description, relatedChallengeId];
}

final class CheckPointsEvent extends PointsEvent {
  final int required;

  const CheckPointsEvent(this.required);

  @override
  List<Object?> get props => [required];
}

final class LoadTransactionsEvent extends PointsEvent {
  final int? limit;

  const LoadTransactionsEvent({this.limit});

  @override
  List<Object?> get props => [limit];
}
