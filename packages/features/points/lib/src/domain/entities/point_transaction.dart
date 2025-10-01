import 'package:equatable/equatable.dart';

class PointTransaction extends Equatable {
  final int id;
  final int amount;
  final String reason;
  final String? description;
  final DateTime timestamp;
  final int? relatedNoteId;
  final int? relatedChallengeId;
  final int? relatedEventId;
  final int balanceAfter;

  const PointTransaction({
    required this.id,
    required this.amount,
    required this.reason,
    this.description,
    required this.timestamp,
    this.relatedNoteId,
    this.relatedChallengeId,
    this.relatedEventId,
    required this.balanceAfter,
  });

  @override
  List<Object?> get props => [
    id,
    amount,
    reason,
    description,
    timestamp,
    relatedNoteId,
    relatedChallengeId,
    relatedEventId,
    balanceAfter,
  ];
}
