import 'package:achievements/achievements.dart';
import 'package:challenges/challenges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/notes.dart';
import 'package:points/points.dart';
import 'package:progress/progress.dart';
import 'package:settings/settings.dart';
import 'package:themes/themes.dart';
import 'package:ui/ui.dart' as ui;

import '../di/injection.dart';
import '../routes/app_router.dart';

class NoteventureApp extends StatelessWidget {
  const NoteventureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
          create: (context) => getIt<ThemesBloc>()
            ..add(InitializeThemesEvent())
            ..add(LoadThemes()),
        ),
        BlocProvider(
          create: (context) => getIt<SettingsBloc>()..add(LoadSettings()),
        ),
      ],

      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, settingsState) {
          return BlocBuilder<ThemesBloc, ThemesState>(
            builder: (context, themesState) {
              // Get theme mode from settings
              ThemeMode themeMode = ThemeMode.system;
              if (settingsState is SettingsLoaded) {
                themeMode = _parseThemeMode(settingsState.settings.themeMode);
              }

              // Get active theme colors
              ThemeData customLightTheme = ui.AppTheme.lightTheme;
              ThemeData customDarkTheme = ui.AppTheme.darkTheme;

              if (themesState is ThemesLoaded &&
                  themesState.activeTheme != null) {
                final activeTheme = themesState.activeTheme!;
                customLightTheme = activeTheme.toCustomLightTheme();
                customDarkTheme = activeTheme.toCustomDarkTheme();
              }

              return MaterialApp.router(
                title: 'Noteventure',
                debugShowCheckedModeBanner: false,
                theme: customLightTheme,
                darkTheme: customDarkTheme,
                themeMode: themeMode,
                routerConfig: AppRouter.router,
              );
            },
          );
        },
      ),
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
