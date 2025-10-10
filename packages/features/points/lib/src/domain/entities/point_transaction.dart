import 'package:equatable/equatable.dart';

class PointTransaction extends Equatable {
  final String id;
  final int amount;
  final String reason;
  final String? description;
  final DateTime timestamp;
  final String? relatedNoteId;
  final String? relatedChallengeId;
  final String? relatedEventId;
  final int balanceAfter;
  final String? serverUuid;

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
    this.serverUuid,
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
    serverUuid,
  ];
}
