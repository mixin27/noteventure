import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/point_transactions_table.dart';

part 'point_transactions_dao.g.dart';

@DriftAccessor(tables: [PointTransactions])
class PointTransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$PointTransactionsDaoMixin {
  PointTransactionsDao(super.db);

  /// Get all transactions
  Future<List<PointTransaction>> getAllTransactions() {
    return (select(pointTransactions)..orderBy([
          (tbl) =>
              OrderingTerm(expression: tbl.timestamp, mode: OrderingMode.desc),
        ]))
        .get();
  }

  /// Get recent transactions (limit)
  Future<List<PointTransaction>> getRecentTransactions(int limit) {
    return (select(pointTransactions)
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.timestamp,
              mode: OrderingMode.desc,
            ),
          ])
          ..limit(limit))
        .get();
  }

  /// Get transactions by reason
  Future<List<PointTransaction>> getTransactionsByReason(String reason) {
    return (select(pointTransactions)
          ..where((tbl) => tbl.reason.equals(reason))
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.timestamp,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Get transaction by ID
  Future<PointTransaction?> getTransactionById(String id) {
    return (select(
      pointTransactions,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Create transaction
  Future<int> createTransaction(PointTransactionsCompanion transaction) {
    return into(pointTransactions).insert(transaction);
  }

  /// Get total points earned
  Future<int> getTotalPointsEarned() async {
    final query = selectOnly(pointTransactions)
      ..addColumns([pointTransactions.amount.sum()])
      ..where(pointTransactions.amount.isBiggerThanValue(0));

    final result = await query.getSingleOrNull();
    return result?.read(pointTransactions.amount.sum()) ?? 0;
  }

  /// Get total points spent
  Future<int> getTotalPointsSpent() async {
    final query = selectOnly(pointTransactions)
      ..addColumns([pointTransactions.amount.sum()])
      ..where(pointTransactions.amount.isSmallerThanValue(0));

    final result = await query.getSingleOrNull();
    return (result?.read(pointTransactions.amount.sum()) ?? 0).abs();
  }

  /// Get transactions in date range
  Future<List<PointTransaction>> getTransactionsInRange(
    DateTime start,
    DateTime end,
  ) {
    return (select(pointTransactions)
          ..where((tbl) => tbl.timestamp.isBetweenValues(start, end))
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.timestamp,
              mode: OrderingMode.desc,
            ),
          ]))
        .get();
  }

  /// Watch recent transactions
  Stream<List<PointTransaction>> watchRecentTransactions(int limit) {
    return (select(pointTransactions)
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.timestamp,
              mode: OrderingMode.desc,
            ),
          ])
          ..limit(limit))
        .watch();
  }

  /// Delete old transactions (cleanup)
  Future<int> deleteTransactionsOlderThan(DateTime date) {
    return (delete(
      pointTransactions,
    )..where((tbl) => tbl.timestamp.isSmallerThanValue(date))).go();
  }
}
