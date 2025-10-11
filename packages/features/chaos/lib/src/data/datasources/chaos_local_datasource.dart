import 'package:database/database.dart';
import 'package:drift/drift.dart';

import '../models/chaos_event_model.dart';

abstract class ChaosLocalDataSource {
  Future<List<ChaosEventModel>> getAllEvents();
  Future<List<ChaosEventModel>> getRecentEvents({int limit});
  Future<ChaosEventModel> triggerRandomEvent();
  Future<void> resolveEvent(String id);
  Stream<List<ChaosEventModel>> watchEvents();
}

class ChaosLocalDataSourceImpl implements ChaosLocalDataSource {
  final ChaosEventsDao chaosEventsDao;

  ChaosLocalDataSourceImpl(this.chaosEventsDao);

  @override
  Future<List<ChaosEventModel>> getAllEvents() async {
    final events = await chaosEventsDao.getAllEvents();
    return events.map((e) => ChaosEventModel.fromDrift(e)).toList();
  }

  @override
  Future<List<ChaosEventModel>> getRecentEvents({int limit = 10}) async {
    final events = await chaosEventsDao.getRecentEvents(limit: limit);
    return events.map((e) => ChaosEventModel.fromDrift(e)).toList();
  }

  @override
  Future<ChaosEventModel> triggerRandomEvent() async {
    // Generate random event
    final event = _generateRandomEvent();

    // Insert into database
    await chaosEventsDao.insertEvent(event);

    // Fetch and return
    final insertedEvent = await chaosEventsDao.getAllEvents();
    final found = insertedEvent.firstWhere((e) => e.id == event.id.toString());
    return ChaosEventModel.fromDrift(found);
  }

  @override
  Future<void> resolveEvent(String id) async {
    await chaosEventsDao.markAsResolved(id);
  }

  @override
  Stream<List<ChaosEventModel>> watchEvents() {
    return chaosEventsDao.watchAllEvents().map(
      (list) => list.map((e) => ChaosEventModel.fromDrift(e)).toList(),
    );
  }

  ChaosEventsCompanion _generateRandomEvent() {
    final events = _getChaosEventTemplates();
    final random = events[DateTime.now().millisecond % events.length];

    return ChaosEventsCompanion.insert(
      id: Value(uuid.v4()),
      eventKey: random['key']!,
      eventType: random['type']!,
      title: random['title']!,
      message: random['message']!,
      pointsAwarded: Value(int.parse(random['points']!)),
    );
  }

  List<Map<String, String>> _getChaosEventTemplates() {
    return [
      // Positive events
      {
        'key': 'lucky_day',
        'type': 'positive',
        'title': 'Lucky Day!',
        'message': '50% off all actions for 1 hour',
        'points': '0',
      },
      {
        'key': 'points_jackpot',
        'type': 'positive',
        'title': 'Points Jackpot!',
        'message': 'Triple points on your next challenge',
        'points': '0',
      },
      {
        'key': 'free_preview',
        'type': 'positive',
        'title': 'Free Preview Pass',
        'message': 'Preview notes for free for the next hour',
        'points': '0',
      },
      {
        'key': 'bonus_points',
        'type': 'positive',
        'title': 'Bonus Points!',
        'message': 'Here are some free points!',
        'points': '50',
      },

      // Negative events
      {
        'key': 'surprise_audit',
        'type': 'negative',
        'title': 'Surprise Audit',
        'message': 'A random note has been locked',
        'points': '0',
      },
      {
        'key': 'chaos_mode',
        'type': 'negative',
        'title': 'Chaos Mode Activated',
        'message': 'All actions cost double for 30 minutes',
        'points': '0',
      },
      {
        'key': 'mystery_cost',
        'type': 'negative',
        'title': 'Mystery Challenge',
        'message': 'Next action has unknown cost',
        'points': '0',
      },

      // Neutral events
      {
        'key': 'random_message',
        'type': 'neutral',
        'title': 'Random Thought',
        'message': 'You have been productive today!',
        'points': '0',
      },
      {
        'key': 'fun_fact',
        'type': 'neutral',
        'title': 'Fun Fact',
        'message': 'Did you know? You can disable chaos mode',
        'points': '0',
      },
    ];
  }
}
