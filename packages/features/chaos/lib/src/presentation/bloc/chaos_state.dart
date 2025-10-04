import 'package:equatable/equatable.dart';

import '../../domain/entities/chaos_event_entity.dart';

sealed class ChaosState extends Equatable {
  const ChaosState();

  @override
  List<Object?> get props => [];
}

final class ChaosInitial extends ChaosState {}

final class ChaosLoading extends ChaosState {}

final class ChaosLoaded extends ChaosState {
  final List<ChaosEventEntity> events;

  const ChaosLoaded(this.events);

  @override
  List<Object?> get props => [events];
}

final class ChaosError extends ChaosState {
  final String message;

  const ChaosError(this.message);

  @override
  List<Object?> get props => [message];
}

final class ChaosEventTriggered extends ChaosState {
  final ChaosEventEntity event;

  const ChaosEventTriggered(this.event);

  @override
  List<Object?> get props => [event];
}
