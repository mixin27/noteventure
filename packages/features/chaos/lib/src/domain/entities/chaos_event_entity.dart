import 'package:equatable/equatable.dart';

class ChaosEventEntity extends Equatable {
  final int id;
  final String eventKey;
  final ChaosEventType eventType;
  final String title;
  final String message;
  final DateTime triggeredAt;
  final bool wasResolved;
  final int pointsAwarded;

  const ChaosEventEntity({
    required this.id,
    required this.eventKey,
    required this.eventType,
    required this.title,
    required this.message,
    required this.triggeredAt,
    required this.wasResolved,
    required this.pointsAwarded,
  });

  ChaosEventEntity copyWith({
    int? id,
    String? eventKey,
    ChaosEventType? eventType,
    String? title,
    String? message,
    DateTime? triggeredAt,
    bool? wasResolved,
    int? pointsAwarded,
  }) {
    return ChaosEventEntity(
      id: id ?? this.id,
      eventKey: eventKey ?? this.eventKey,
      eventType: eventType ?? this.eventType,
      title: title ?? this.title,
      message: message ?? this.message,
      triggeredAt: triggeredAt ?? this.triggeredAt,
      wasResolved: wasResolved ?? this.wasResolved,
      pointsAwarded: pointsAwarded ?? this.pointsAwarded,
    );
  }

  @override
  List<Object?> get props => [
    id,
    eventKey,
    eventType,
    title,
    message,
    triggeredAt,
    wasResolved,
    pointsAwarded,
  ];
}

enum ChaosEventType {
  positive,
  negative,
  neutral;

  String get displayName {
    switch (this) {
      case ChaosEventType.positive:
        return 'Positive';
      case ChaosEventType.negative:
        return 'Negative';
      case ChaosEventType.neutral:
        return 'Neutral';
    }
  }

  static ChaosEventType fromString(String value) {
    return ChaosEventType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => ChaosEventType.neutral,
    );
  }
}
