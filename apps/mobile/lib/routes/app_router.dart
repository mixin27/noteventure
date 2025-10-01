import 'package:challenges/challenges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:points/points.dart';

import '../di/injection.dart';
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
        path: RouteConstants.challenges,
        name: RouteConstants.challengesName,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => getIt<PointsBloc>()..add(LoadPointBalance()),
              ),
              BlocProvider(create: (_) => getIt<ChallengeBloc>()),
            ],
            child: const ChallengesMenuPage(),
          );
        },
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Page not found: ${state.uri}'))),
  );
}
