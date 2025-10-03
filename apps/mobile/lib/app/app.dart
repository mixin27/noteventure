import 'package:achievements/achievements.dart';
import 'package:challenges/challenges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/notes.dart';
import 'package:points/points.dart';
import 'package:progress/progress.dart';
import 'package:settings/settings.dart';
import 'package:ui/ui.dart';

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
          create: (context) => getIt<SettingsBloc>()..add(LoadSettings()),
        ),
      ],

      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          // Determine theme mode from settings
          ThemeMode themeMode = ThemeMode.system;

          if (state is SettingsLoaded) {
            switch (state.settings.themeMode) {
              case 'light':
                themeMode = ThemeMode.light;
                break;
              case 'dark':
                themeMode = ThemeMode.dark;
                break;
              case 'system':
                themeMode = ThemeMode.system;
                break;
            }
          }

          return MaterialApp.router(
            title: 'Noteventure',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
