import 'package:achievements/achievements.dart';
import 'package:auth/auth.dart';
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
import 'router_refresh_stream.dart';

class AppRouter {
  final AuthStateNotifier authStateNotifier;

  AppRouter(this.authStateNotifier);

  late final GoRouter router = GoRouter(
    refreshListenable: RouterRefreshStream(authStateNotifier),
    initialLocation: RouteConstants.splash,
    redirect: _redirect,
    routes: _routes,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.uri}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(RouteConstants.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final authState = authStateNotifier.authState;
    final isAuthenticated = authState is AuthAuthenticated;
    final isInitialLoading =
        authState is AuthLoading && authState.isInitialCheck;

    // Define public routes
    final publicRoutes = [
      RouteConstants.splash,
      RouteConstants.login,
      RouteConstants.register,
    ];

    final isPublicRoute = publicRoutes.contains(state.matchedLocation);

    // While doing initial auth check, stay on splash
    if (isInitialLoading && state.matchedLocation == RouteConstants.splash) {
      return null;
    }

    // If initial loading and not on splash, go to splash
    if (isInitialLoading && state.matchedLocation != RouteConstants.splash) {
      return RouteConstants.splash;
    }

    // If on splash and auth is determined, redirect accordingly
    if (state.matchedLocation == RouteConstants.splash && !isInitialLoading) {
      if (isAuthenticated) {
        return RouteConstants.home;
      } else {
        return RouteConstants.login;
      }
    }

    // If authenticated and on public routes, go to home
    if (isAuthenticated && isPublicRoute) {
      return RouteConstants.home;
    }

    // If not authenticated and trying to access protected route, go to login
    if (!isAuthenticated && !isPublicRoute) {
      return RouteConstants.login;
    }

    return null;
  }

  List<RouteBase> get _routes => [
    GoRoute(
      path: RouteConstants.splash,
      name: RouteConstants.splashName,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RouteConstants.login,
      name: RouteConstants.loginName,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RouteConstants.register,
      name: RouteConstants.registerName,
      builder: (context, state) => const RegisterPage(),
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
  ];
}
