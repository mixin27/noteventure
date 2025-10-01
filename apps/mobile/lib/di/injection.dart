import 'package:challenges/challenges.dart';
import 'package:get_it/get_it.dart';
import 'package:database/database.dart';
import 'package:notes/notes.dart';
import 'package:points/points.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Initialize database
  final database = AppDatabase();
  getIt.registerSingleton<AppDatabase>(database);

  // Register DAOs
  getIt.registerSingleton<NotesDao>(NotesDao(database));
  getIt.registerSingleton<UserProgressDao>(UserProgressDao(database));
  getIt.registerSingleton<PointTransactionsDao>(PointTransactionsDao(database));

  // Initialize features
  initNotesFeature();
  initPointsFeature();
  initChallengesFeature();
}
