import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:points/points.dart';

import '../../domain/usecases/activate_theme.dart';
import '../../domain/usecases/get_active_theme.dart';
import '../../domain/usecases/get_all_themes.dart';
import '../../domain/usecases/get_unlocked_themes.dart';
import '../../domain/usecases/initialize_theme.dart';
import '../../domain/usecases/unlock_theme.dart';
import '../../domain/usecases/watch_active_theme.dart';
import '../../domain/usecases/watch_themes.dart';
import 'themes_event.dart';
import 'themes_state.dart';

class ThemesBloc extends Bloc<ThemesEvent, ThemesState> {
  final GetAllThemes getAllThemes;
  final GetUnlockedThemes getUnlockedThemes;
  final GetActiveTheme getActiveTheme;
  final UnlockTheme unlockTheme;
  final ActivateTheme activateTheme;
  final InitializeThemes initializeThemes;
  final WatchThemes watchThemes;
  final WatchActiveTheme watchActiveTheme;
  final PointsBloc pointsBloc;

  StreamSubscription? _themesSubscription;
  StreamSubscription? _activeThemeSubscription;

  ThemesBloc({
    required this.getAllThemes,
    required this.getUnlockedThemes,
    required this.getActiveTheme,
    required this.unlockTheme,
    required this.activateTheme,
    required this.initializeThemes,
    required this.watchThemes,
    required this.watchActiveTheme,
    required this.pointsBloc,
  }) : super(ThemesInitial()) {
    on<LoadThemes>(_onLoadThemes);
    on<LoadUnlockedThemes>(_onLoadUnlockedThemes);
    on<UnlockThemeEvent>(_onUnlockTheme);
    on<ActivateThemeEvent>(_onActivateTheme);
    on<InitializeThemesEvent>(_onInitializeThemes);
    on<ThemesUpdated>(_onThemesUpdated);

    // Watch themes stream
    _themesSubscription = watchThemes().listen((themes) {
      if (!isClosed) {
        add(ThemesUpdated(themes));
      }
    });
  }

  @override
  Future<void> close() async {
    await _themesSubscription?.cancel();
    await _activeThemeSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadThemes(
    LoadThemes event,
    Emitter<ThemesState> emit,
  ) async {
    emit(ThemesLoading());

    final themesResult = await getAllThemes();
    final activeThemeResult = await getActiveTheme();

    themesResult.fold((failure) => emit(ThemesError(failure.message)), (
      themes,
    ) {
      activeThemeResult.fold(
        (failure) => emit(ThemesLoaded(themes, null)),
        (activeTheme) => emit(ThemesLoaded(themes, activeTheme)),
      );
    });
  }

  Future<void> _onLoadUnlockedThemes(
    LoadUnlockedThemes event,
    Emitter<ThemesState> emit,
  ) async {
    emit(ThemesLoading());

    final themesResult = await getUnlockedThemes();
    final activeThemeResult = await getActiveTheme();

    themesResult.fold((failure) => emit(ThemesError(failure.message)), (
      themes,
    ) {
      activeThemeResult.fold(
        (failure) => emit(ThemesLoaded(themes, null)),
        (activeTheme) => emit(ThemesLoaded(themes, activeTheme)),
      );
    });
  }

  Future<void> _onUnlockTheme(
    UnlockThemeEvent event,
    Emitter<ThemesState> emit,
  ) async {
    if (state is! ThemesLoaded) return;

    final currentState = state as ThemesLoaded;
    final theme = currentState.themes.firstWhere(
      (t) => t.themeKey == event.themeKey,
    );

    // Check if user has enough points
    final pointsState = pointsBloc.state;
    if (pointsState is PointsLoaded) {
      if (pointsState.balance < theme.unlockCost) {
        emit(const ThemesError('Not enough points to unlock this theme'));
        emit(currentState); // Restore previous state
        return;
      }
    }

    // Spend points
    pointsBloc.add(
      SpendPointsEvent(
        amount: theme.unlockCost,
        reason: 'theme_unlock',
        description: 'Unlocked ${theme.name} theme',
      ),
    );

    // Unlock theme
    final result = await unlockTheme(event.themeKey);

    result.fold(
      (failure) {
        emit(ThemesError(failure.message));
        emit(currentState); // Restore previous state
      },
      (_) {
        // Emit theme unlocked event
        AppEventBus().emit(
          ThemeUnlockedEvent(
            themeKey: event.themeKey,
            themeName: '', // Would need to fetch name
          ),
        );
        emit(ThemeUnlocked(theme));
        // Will be updated by stream
      },
    );
  }

  Future<void> _onActivateTheme(
    ActivateThemeEvent event,
    Emitter<ThemesState> emit,
  ) async {
    final result = await activateTheme(event.themeKey);

    result.fold(
      (failure) {
        emit(ThemesError(failure.message));
      },
      (_) {
        // Emit theme changed event
        AppEventBus().emit(ThemeChangedEvent(event.themeKey));
      }, // Will be updated by stream
    );
  }

  Future<void> _onInitializeThemes(
    InitializeThemesEvent event,
    Emitter<ThemesState> emit,
  ) async {
    await initializeThemes();
    add(LoadThemes());
  }

  Future<void> _onThemesUpdated(
    ThemesUpdated event,
    Emitter<ThemesState> emit,
  ) async {
    final activeThemeResult = await getActiveTheme();

    activeThemeResult.fold(
      (failure) => emit(ThemesLoaded(event.themes, null)),
      (activeTheme) => emit(ThemesLoaded(event.themes, activeTheme)),
    );
  }
}
