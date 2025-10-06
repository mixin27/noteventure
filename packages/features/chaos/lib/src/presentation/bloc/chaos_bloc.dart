import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:settings/settings.dart';

import '../../domain/usecases/get_recent_events.dart';
import '../../domain/usecases/trigger_random_event.dart';
import '../../domain/usecases/watch_chaos_events.dart';
import 'chaos_event.dart';
import 'chaos_state.dart';

class ChaosBloc extends Bloc<ChaosEvent, ChaosState> {
  final GetRecentEvents getRecentEvents;
  final TriggerRandomEvent triggerRandomEvent;
  final WatchChaosEvents watchChaosEvents;
  final WatchSettings watchSettings;

  StreamSubscription? _eventsSubscription;
  StreamSubscription? _settingsSubscription;
  bool _chaosEnabled = true;

  ChaosBloc({
    required this.getRecentEvents,
    required this.triggerRandomEvent,
    required this.watchChaosEvents,
    required this.watchSettings,
  }) : super(ChaosInitial()) {
    on<LoadRecentEvents>(_onLoadRecentEvents);
    on<TriggerRandomEventAction>(_onTriggerRandomEvent);
    on<ResolveEventAction>(_onResolveEvent);
    on<EventsUpdated>(_onEventsUpdated);

    // Watch events stream
    _eventsSubscription = watchChaosEvents().listen((events) {
      if (!isClosed) {
        add(EventsUpdated(events));
      }
    });

    // Watch settings for chaos enabled
    _settingsSubscription = watchSettings().listen((settings) {
      _chaosEnabled = settings.chaosEnabled;
    });
  }

  @override
  Future<void> close() async {
    await _eventsSubscription?.cancel();
    await _settingsSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadRecentEvents(
    LoadRecentEvents event,
    Emitter<ChaosState> emit,
  ) async {
    emit(ChaosLoading());

    final result = await getRecentEvents(limit: event.limit);

    result.fold(
      (failure) => emit(ChaosError(failure.message)),
      (events) => emit(ChaosLoaded(events)),
    );
  }

  Future<void> _onTriggerRandomEvent(
    TriggerRandomEventAction event,
    Emitter<ChaosState> emit,
  ) async {
    if (!_chaosEnabled) {
      emit(const ChaosError('Chaos mode is disabled'));
      return;
    }

    final result = await triggerRandomEvent();

    result.fold((failure) => emit(ChaosError(failure.message)), (event) {
      // Emit event via EventBus
      AppEventBus().emit(
        ChaosEventTriggeredEvent(
          eventKey: event.eventKey,
          eventType: event.eventType.name,
          title: event.title,
          message: event.message,
        ),
      );
      emit(ChaosEventTriggered(event));
    });
  }

  Future<void> _onResolveEvent(
    ResolveEventAction event,
    Emitter<ChaosState> emit,
  ) async {
    // Event will be updated via stream
  }

  void _onEventsUpdated(EventsUpdated event, Emitter<ChaosState> emit) {
    emit(ChaosLoaded(event.events));
  }
}
