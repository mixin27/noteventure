import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/chaos_events_table.dart';

part 'chaos_events_dao.g.dart';

@DriftAccessor(tables: [ChaosEvents])
class ChaosEventsDao extends DatabaseAccessor<AppDatabase>
    with _$ChaosEventsDaoMixin {
  ChaosEventsDao(super.db);

  // Get all events
  Future<List<ChaosEvent>> getAllEvents() async {
    return await select(chaosEvents).get();
  }

  // Get recent events (last N)
  Future<List<ChaosEvent>> getRecentEvents({int limit = 10}) async {
    final query = select(chaosEvents)
      ..orderBy([(t) => OrderingTerm.desc(t.triggeredAt)])
      ..limit(limit);
    return await query.get();
  }

  // Get unresolved events
  Future<List<ChaosEvent>> getUnresolvedEvents() async {
    final query = select(chaosEvents)
      ..where((tbl) => tbl.wasResolved.equals(false))
      ..orderBy([(t) => OrderingTerm.desc(t.triggeredAt)]);
    return await query.get();
  }

  // Get events by type
  Future<List<ChaosEvent>> getEventsByType(String type) async {
    final query = select(chaosEvents)
      ..where((tbl) => tbl.eventType.equals(type))
      ..orderBy([(t) => OrderingTerm.desc(t.triggeredAt)]);
    return await query.get();
  }

  // Get event by key
  Future<ChaosEvent?> getEventByKey(String key) async {
    final query = select(chaosEvents)..where((tbl) => tbl.eventKey.equals(key));
    return await query.getSingleOrNull();
  }

  // Insert event
  Future<int> insertEvent(ChaosEventsCompanion event) async {
    return await into(chaosEvents).insert(event);
  }

  // Mark event as resolved
  Future<void> markAsResolved(int id) async {
    await (update(chaosEvents)..where((tbl) => tbl.id.equals(id))).write(
      const ChaosEventsCompanion(wasResolved: Value(true)),
    );
  }

  // Delete event
  Future<void> deleteEvent(int id) async {
    await (delete(chaosEvents)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Delete old events (older than N days)
  Future<void> deleteOldEvents({int daysOld = 7}) async {
    final cutoffDate = DateTime.now().subtract(Duration(days: daysOld));
    await (delete(
      chaosEvents,
    )..where((tbl) => tbl.triggeredAt.isSmallerThanValue(cutoffDate))).go();
  }

  // Get events count
  Future<int> getEventsCount() async {
    final countQuery = selectOnly(chaosEvents)
      ..addColumns([chaosEvents.id.count()]);
    final result = await countQuery.getSingle();
    return result.read(chaosEvents.id.count()) ?? 0;
  }

  // Watch all events
  Stream<List<ChaosEvent>> watchAllEvents() {
    return (select(
      chaosEvents,
    )..orderBy([(t) => OrderingTerm.desc(t.triggeredAt)])).watch();
  }

  // Watch unresolved events
  Stream<List<ChaosEvent>> watchUnresolvedEvents() {
    return (select(chaosEvents)
          ..where((tbl) => tbl.wasResolved.equals(false))
          ..orderBy([(t) => OrderingTerm.desc(t.triggeredAt)]))
        .watch();
  }
}
