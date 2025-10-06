import 'package:achievements/achievements.dart';
import 'package:challenges/challenges.dart';
import 'package:chaos/chaos.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes/notes.dart';
import 'package:progress/progress.dart';
import 'package:settings/settings.dart';
import 'package:themes/themes.dart';

import '../pages/home_page.dart';
import '../pages/notes_page.dart';
import '../pages/splash_page.dart';
import 'route_constants.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteConstants.splash,
    routes: [
      GoRoute(
        path: RouteConstants.splash,
        name: RouteConstants.splashName,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteConstants.home,
        name: RouteConstants.homeName,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RouteConstants.notes,
        name: RouteConstants.notesName,
        builder: (context, state) => const NotesPage(),
      ),
      GoRoute(
        path: '${RouteConstants.noteDetail}/:id',
        name: RouteConstants.noteDetailName,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return NoteDetailPage(noteId: id);
        },
      ),
      GoRoute(
        path: RouteConstants.noteCreate,
        name: RouteConstants.noteCreateName,
        builder: (context, state) => const NoteEditorPage(),
      ),
      GoRoute(
        path: RouteConstants.challenges,
        name: RouteConstants.challengesName,
        builder: (context, state) => const ChallengesMenuPage(),
      ),
      GoRoute(
        path: RouteConstants.progress,
        name: RouteConstants.progressName,
        builder: (context, state) => const ProgressPage(),
      ),
      GoRoute(
        path: RouteConstants.achievements,
        name: RouteConstants.achievementsName,
        builder: (context, state) => const AchievementsPage(),
      ),
      GoRoute(
        path: RouteConstants.themes,
        name: RouteConstants.themesName,
        builder: (context, state) => const ThemesPage(),
      ),
      GoRoute(
        path: RouteConstants.settings,
        name: RouteConstants.settingsName,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: RouteConstants.chaos,
        name: RouteConstants.chaosName,
        builder: (context, state) => const ChaosHistoryPage(),
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}
