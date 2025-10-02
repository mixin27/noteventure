import 'package:bloc/bloc.dart';

import '../../domain/usecases/get_settings.dart';
import '../../domain/usecases/reset_settings.dart';
import '../../domain/usecases/update_settings.dart';
import '../../domain/usecases/watch_settings.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettings getSettings;
  final UpdateSettings updateSettings;
  final ResetSettings resetSettings;
  final WatchSettings watchSettings;

  SettingsBloc({
    required this.getSettings,
    required this.updateSettings,
    required this.resetSettings,
    required this.watchSettings,
  }) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateSoundEnabled>(_onUpdateSoundEnabled);
    on<UpdateNotificationsEnabled>(_onUpdateNotificationsEnabled);
    on<UpdateChaosEnabled>(_onUpdateChaosEnabled);
    on<UpdateChallengeTimeLimit>(_onUpdateChallengeTimeLimit);
    on<UpdatePersonalityTone>(_onUpdatePersonalityTone);
    on<UpdateHapticFeedback>(_onUpdateHapticFeedback);
    on<UpdateThemeMode>(_onUpdateThemeMode);
    on<UpdateProfanityFilter>(_onUpdateProfanityFilter);
    on<ResetAllSettings>(_onResetAllSettings);
    on<SettingsUpdated>(_onSettingsUpdated);

    // Watch for settings changes
    watchSettings().listen((settings) {
      add(SettingsUpdated(settings));
    });
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(SettingsLoading());

    final result = await getSettings();

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (settings) => emit(SettingsLoaded(settings)),
    );
  }

  Future<void> _onUpdateSoundEnabled(
    UpdateSoundEnabled event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      final newSettings = currentSettings.copyWith(soundEnabled: event.enabled);
      await _updateAndEmit(newSettings, emit);
    }
  }

  Future<void> _onUpdateNotificationsEnabled(
    UpdateNotificationsEnabled event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      final newSettings = currentSettings.copyWith(
        notificationsEnabled: event.enabled,
      );
      await _updateAndEmit(newSettings, emit);
    }
  }

  Future<void> _onUpdateChaosEnabled(
    UpdateChaosEnabled event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      final newSettings = currentSettings.copyWith(chaosEnabled: event.enabled);
      await _updateAndEmit(newSettings, emit);
    }
  }

  Future<void> _onUpdateChallengeTimeLimit(
    UpdateChallengeTimeLimit event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      final newSettings = currentSettings.copyWith(
        challengeTimeLimit: event.seconds,
      );
      await _updateAndEmit(newSettings, emit);
    }
  }

  Future<void> _onUpdatePersonalityTone(
    UpdatePersonalityTone event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      final newSettings = currentSettings.copyWith(personalityTone: event.tone);
      await _updateAndEmit(newSettings, emit);
    }
  }

  Future<void> _onUpdateHapticFeedback(
    UpdateHapticFeedback event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      final newSettings = currentSettings.copyWith(
        hapticFeedbackEnabled: event.enabled,
      );
      await _updateAndEmit(newSettings, emit);
    }
  }

  Future<void> _onUpdateThemeMode(
    UpdateThemeMode event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      final newSettings = currentSettings.copyWith(themeMode: event.mode);
      await _updateAndEmit(newSettings, emit);
    }
  }

  Future<void> _onUpdateProfanityFilter(
    UpdateProfanityFilter event,
    Emitter<SettingsState> emit,
  ) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      final newSettings = currentSettings.copyWith(
        profanityFilter: event.enabled,
      );
      await _updateAndEmit(newSettings, emit);
    }
  }

  Future<void> _onResetAllSettings(
    ResetAllSettings event,
    Emitter<SettingsState> emit,
  ) async {
    final result = await resetSettings();

    result.fold((failure) => emit(SettingsError(failure.message)), (_) {
      emit(SettingsResetSuccess());
      add(LoadSettings());
    });
  }

  void _onSettingsUpdated(SettingsUpdated event, Emitter<SettingsState> emit) {
    emit(SettingsLoaded(event.settings));
  }

  Future<void> _updateAndEmit(
    dynamic newSettings,
    Emitter<SettingsState> emit,
  ) async {
    final result = await updateSettings(newSettings);

    result.fold(
      (failure) => emit(SettingsError(failure.message)),
      (_) {}, // Settings will be updated via watchSettings stream
    );
  }
}
