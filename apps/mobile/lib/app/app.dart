import 'package:achievements/achievements.dart';
import 'package:auth/auth.dart';
import 'package:challenges/challenges.dart';
import 'package:chaos/chaos.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/notes.dart';
import 'package:points/points.dart';
import 'package:progress/progress.dart';
import 'package:settings/settings.dart';
import 'package:themes/themes.dart';
import 'package:ui/ui.dart' as ui;
import 'package:syncing/syncing.dart';

import '../di/injection.dart';
import '../routes/app_router.dart';

class NoteventureApp extends StatefulWidget {
  const NoteventureApp({super.key});

  @override
  State<NoteventureApp> createState() => _NoteventureAppState();
}

class _NoteventureAppState extends State<NoteventureApp>
    with WidgetsBindingObserver {
  late final AuthBloc _authBloc;
  late final SyncBloc _syncBloc;
  late final AuthStateNotifier _authStateNotifier;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _authBloc = getIt<AuthBloc>();
    _syncBloc = getIt<SyncBloc>();

    _authStateNotifier = getIt<AuthStateNotifier>();
    _appRouter = getIt<AppRouter>();

    // Listen to auth state changes and update notifier
    _authBloc.stream.listen((state) {
      _authStateNotifier.updateAuthState(state);

      // Trigger sync when user logs in
      if (state is AuthAuthenticated) {
        // todo(mixin27): uncomment when get fixed
        // _syncBloc.add(SyncRequested());
      }
    });

    // Check initial auth status
    _authBloc.add(AuthCheckStatusRequested());

    // Initialize chaos service after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        AppEventBus().emit(AppPausedEvent());
        break;
      case AppLifecycleState.resumed:
        AppEventBus().emit(AppResumedEvent());
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _authBloc.close();
    _syncBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authBloc),
        BlocProvider.value(value: _syncBloc),
        BlocProvider(create: (context) => getIt<NotesBloc>()..add(NotesLoad())),
        BlocProvider(
          create: (context) => getIt<PointsBloc>()..add(LoadPointBalance()),
        ),
        BlocProvider(create: (context) => getIt<ChallengeBloc>()),
        BlocProvider(
          create: (context) => getIt<ProgressBloc>()..add(LoadUserProgress()),
        ),
        BlocProvider(
          create: (context) => getIt<AchievementsBloc>()
            ..add(InitializeAchievementsEvent())
            ..add(LoadAchievements()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ChaosBloc>()..add(const LoadRecentEvents(limit: 20)),
        ),
        BlocProvider(
          create: (context) => getIt<ThemesBloc>()
            ..add(InitializeThemesEvent())
            ..add(LoadThemes()),
        ),
        BlocProvider(
          create: (context) => getIt<SettingsBloc>()..add(LoadSettings()),
        ),
      ],

      child: _AppContent(_appRouter),
    );
  }
}

class _AppContent extends StatefulWidget {
  const _AppContent(this.appRouter);

  final AppRouter appRouter;

  @override
  State<_AppContent> createState() => __AppContentState();
}

class __AppContentState extends State<_AppContent> {
  ChaosTriggerService? _chaosTriggerService;

  @override
  void initState() {
    super.initState();

    // Initialize chaos service after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final chaosBloc = context.read<ChaosBloc>();
      _chaosTriggerService = ChaosTriggerService(chaosBloc);
    });
  }

  @override
  void dispose() {
    _chaosTriggerService?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return BlocBuilder<ThemesBloc, ThemesState>(
          builder: (context, themesState) {
            // Get theme mode from settings
            ThemeMode themeMode = ThemeMode.system;
            if (settingsState is SettingsLoaded) {
              themeMode = _parseThemeMode(settingsState.settings.themeMode);
            }

            // Start with defaults
            ThemeData lightTheme = ui.AppTheme.lightTheme;
            ThemeData darkTheme = ui.AppTheme.darkTheme;

            // Apply custom theme if active
            if (themesState is ThemesLoaded &&
                themesState.activeTheme != null) {
              final active = themesState.activeTheme!;

              if (active.themeStyle == 'light') {
                lightTheme = ui.ThemeBuilder.buildCustomTheme(
                  primary: active.primaryColorValue,
                  secondary: active.secondaryColorValue,
                  background: active.backgroundColorValue,
                  surface: active.surfaceColorValue,
                  isDark: false,
                );
              } else if (active.themeStyle == 'dark') {
                darkTheme = ui.ThemeBuilder.buildCustomTheme(
                  primary: active.primaryColorValue,
                  secondary: active.secondaryColorValue,
                  background: active.backgroundColorValue,
                  surface: active.surfaceColorValue,
                  isDark: true,
                );
              }
            }

            return MaterialApp.router(
              title: 'Noteventure',
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: themeMode,
              routerConfig: widget.appRouter.router,
            );
          },
        );
      },
    );
  }

  ThemeMode _parseThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }
}
