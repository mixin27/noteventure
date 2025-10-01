import 'package:database/database.dart' as db;

import '../../domain/entities/point_transaction.dart';

class PointTransactionModel extends PointTransaction {
  const PointTransactionModel({
    required super.id,
    required super.amount,
    required super.reason,
    super.description,
    required super.timestamp,
    super.relatedNoteId,
    super.relatedChallengeId,
    super.relatedEventId,
    required super.balanceAfter,
  });

  factory PointTransactionModel.fromDrift(
    db.PointTransaction driftTransaction,
  ) {
    return PointTransactionModel(
      id: driftTransaction.id,
      amount: driftTransaction.amount,
      reason: driftTransaction.reason,
      description: driftTransaction.description,
      timestamp: driftTransaction.timestamp,
      relatedNoteId: driftTransaction.relatedNoteId,
      relatedChallengeId: driftTransaction.relatedChallengeId,
      relatedEventId: driftTransaction.relatedEventId,
      balanceAfter: driftTransaction.balanceAfter,
    );
  }

  PointTransaction toEntity() {
    return PointTransaction(
      id: id,
      amount: amount,
      reason: reason,
      description: description,
      timestamp: timestamp,
      relatedNoteId: relatedNoteId,
      relatedChallengeId: relatedChallengeId,
      relatedEventId: relatedEventId,
      balanceAfter: balanceAfter,
    );
  }
}
