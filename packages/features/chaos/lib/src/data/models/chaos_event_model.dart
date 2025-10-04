import 'package:database/database.dart';

import '../../domain/entities/chaos_event_entity.dart';

class ChaosEventModel extends ChaosEventEntity {
  const ChaosEventModel({
    required super.id,
    required super.eventKey,
    required super.eventType,
    required super.title,
    required super.message,
    required super.triggeredAt,
    required super.wasResolved,
    required super.pointsAwarded,
  });

  factory ChaosEventModel.fromDrift(ChaosEvent data) {
    return ChaosEventModel(
      id: data.id,
      eventKey: data.eventKey,
      eventType: ChaosEventType.values.firstWhere(
        (e) => e.name == data.eventType,
        orElse: () => ChaosEventType.neutral,
      ),
      title: data.title,
      message: data.message,
      triggeredAt: data.triggeredAt,
      wasResolved: data.wasResolved,
      pointsAwarded: data.pointsAwarded,
    );
  }

  ChaosEventEntity toEntity() {
    return ChaosEventEntity(
      id: id,
      eventKey: eventKey,
      eventType: eventType,
      title: title,
      message: message,
      triggeredAt: triggeredAt,
      wasResolved: wasResolved,
      pointsAwarded: pointsAwarded,
    );
  }
}
