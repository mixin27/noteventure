import 'package:equatable/equatable.dart';

import '../../domain/entities/chaos_event_entity.dart';

sealed class ChaosEvent extends Equatable {
  const ChaosEvent();

  @override
  List<Object?> get props => [];
}

final class LoadRecentEvents extends ChaosEvent {
  final int limit;
  const LoadRecentEvents({this.limit = 10});

  @override
  List<Object?> get props => [limit];
}

final class TriggerRandomEventAction extends ChaosEvent {}

final class ResolveEventAction extends ChaosEvent {
  final int eventId;
  const ResolveEventAction(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

final class EventsUpdated extends ChaosEvent {
  final List<ChaosEventEntity> events;
  const EventsUpdated(this.events);

  @override
  List<Object?> get props => [events];
}
