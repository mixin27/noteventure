import 'package:core/core.dart';
import 'package:database/database.dart';
import 'package:drift/drift.dart';

import '../models/point_transaction_model.dart';

abstract class PointsLocalDataSource {
  Future<int> getPointBalance();
  Future<bool> hasEnoughPoints(int required);
  Future<int> spendPoints({
    required int amount,
    required String reason,
    String? description,
    int? relatedNoteId,
  });
  Future<int> earnPoints({
    required int amount,
    required String reason,
    String? description,
    int? relatedChallengeId,
  });
  Future<List<PointTransactionModel>> getRecentTransactions(int limit);
  Future<List<PointTransactionModel>> getAllTransactions();
  Stream<int> watchPointBalance();
}

class PointsLocalDataSourceImpl implements PointsLocalDataSource {
  final UserProgressDao userProgressDao;
  final PointTransactionsDao pointTransactionsDao;

  PointsLocalDataSourceImpl(this.userProgressDao, this.pointTransactionsDao);

  @override
  Future<int> getPointBalance() async {
    final progress = await userProgressDao.getUserProgress();
    return progress?.totalPoints ?? 0;
  }

  @override
  Future<bool> hasEnoughPoints(int required) async {
    final balance = await getPointBalance();
    return balance >= required;
  }

  @override
  Future<int> spendPoints({
    required int amount,
    required String reason,
    String? description,
    int? relatedNoteId,
  }) async {
    final currentBalance = await getPointBalance();

    if (currentBalance < amount) {
      throw InsufficientPointsException(
        required: amount,
        current: currentBalance,
      );
    }

    final newBalance = currentBalance - amount;

    // Update balance
    await userProgressDao.updatePoints(newBalance);
    await userProgressDao.updateLifetimePointsSpent(amount);

    // Create transaction record
    final transaction = PointTransactionsCompanion.insert(
      amount: -amount, // Negative for spending
      reason: reason,
      description: Value(description),
      relatedNoteId: Value(relatedNoteId),
      balanceAfter: newBalance,
    );

    await pointTransactionsDao.createTransaction(transaction);

    // Emit event via EventBus
    AppEventBus().emit(
      PointsSpentEvent(
        amount: amount,
        action: reason,
        relatedId: relatedNoteId,
      ),
    );

    AppEventBus().emit(
      PointsChangedEvent(
        newBalance: newBalance,
        change: -amount,
        reason: reason,
      ),
    );

    return newBalance;
  }

  @override
  Future<int> earnPoints({
    required int amount,
    required String reason,
    String? description,
    int? relatedChallengeId,
  }) async {
    final currentBalance = await getPointBalance();
    final newBalance = currentBalance + amount;

    // Update balance
    await userProgressDao.updatePoints(newBalance);
    await userProgressDao.updateLifetimePointsEarned(amount);

    // Create transaction record
    final transaction = PointTransactionsCompanion.insert(
      amount: amount, // Positive for earning
      reason: reason,
      description: Value(description),
      relatedChallengeId: Value(relatedChallengeId),
      balanceAfter: newBalance,
    );

    await pointTransactionsDao.createTransaction(transaction);

    // Emit event via EventBus
    AppEventBus().emit(
      PointsEarnedEvent(
        amount: amount,
        source: reason,
        relatedId: relatedChallengeId,
      ),
    );

    AppEventBus().emit(
      PointsChangedEvent(
        newBalance: newBalance,
        change: amount,
        reason: reason,
      ),
    );

    return newBalance;
  }

  @override
  Future<List<PointTransactionModel>> getRecentTransactions(int limit) async {
    final transactions = await pointTransactionsDao.getRecentTransactions(
      limit,
    );
    return transactions.map((t) => PointTransactionModel.fromDrift(t)).toList();
  }

  @override
  Future<List<PointTransactionModel>> getAllTransactions() async {
    final transactions = await pointTransactionsDao.getAllTransactions();
    return transactions.map((t) => PointTransactionModel.fromDrift(t)).toList();
  }

  @override
  Stream<int> watchPointBalance() {
    return userProgressDao.watchUserProgress().map(
      (progress) => progress?.totalPoints ?? 0,
    );
  }
}
