import 'package:database/database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    // Create in-memory database for testing
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  group('AppDatabase', () {
    test('creates database and inserts initial data', () async {
      final userProgress = await database.userProgressDao.getUserProgress();
      expect(userProgress, isNotNull);
      expect(userProgress!.totalPoints, 100);
      expect(userProgress.level, 1);
    });

    test('inserts default achievements', () async {
      final achievements = await database.achievementsDao.getAllAchievements();
      expect(achievements.isNotEmpty, true);
      expect(achievements.length, greaterThan(5));
    });

    test('inserts default themes', () async {
      final themes = await database.themesDao.getAllThemes();
      expect(themes.isNotEmpty, true);

      final activeTheme = await database.themesDao.getActiveTheme();
      expect(activeTheme, isNotNull);
      expect(activeTheme!.themeKey, 'default');
    });
  });

  group('NotesDao', () {
    test('creates and retrieves note', () async {
      final note = NotesCompanion.insert(
        title: 'Test Note',
        content: 'This is a test note',
      );

      final noteId = await database.notesDao.createNote(note);
      expect(noteId, greaterThan(0));

      final retrieved = await database.notesDao.getNoteById(noteId);
      expect(retrieved, isNotNull);
      expect(retrieved!.title, 'Test Note');
      expect(retrieved.content, 'This is a test note');
    });

    test('soft deletes note', () async {
      final note = NotesCompanion.insert(
        title: 'To Delete',
        content: 'This will be deleted',
      );

      final noteId = await database.notesDao.createNote(note);
      await database.notesDao.softDeleteNote(noteId);

      final allNotes = await database.notesDao.getAllNotes();
      expect(allNotes.where((n) => n.id == noteId).isEmpty, true);

      final deletedNote = await database.notesDao.getNoteById(noteId);
      expect(deletedNote!.isDeleted, true);
    });

    test('searches notes', () async {
      await database.notesDao.createNote(
        NotesCompanion.insert(
          title: 'Flutter Tutorial',
          content: 'Learn Flutter basics',
        ),
      );

      await database.notesDao.createNote(
        NotesCompanion.insert(
          title: 'Dart Guide',
          content: 'Dart programming language',
        ),
      );

      final results = await database.notesDao.searchNotes('flutter');
      expect(results.length, 1);
      expect(results.first.title, 'Flutter Tutorial');
    });
  });

  group('UserProgressDao', () {
    test('updates points', () async {
      await database.userProgressDao.updatePoints(200);

      final progress = await database.userProgressDao.getUserProgress();
      expect(progress!.totalPoints, 200);
    });

    test('adds XP and levels up', () async {
      final result = await database.userProgressDao.addXp(150);

      expect(result['leveledUp'], true);
      expect(result['newLevel'], 2);
      expect(result['oldLevel'], 1);

      final progress = await database.userProgressDao.getUserProgress();
      expect(progress!.level, 2);
    });

    test('updates streak on success', () async {
      await database.userProgressDao.updateStreak(true);
      await database.userProgressDao.updateStreak(true);
      await database.userProgressDao.updateStreak(true);

      final progress = await database.userProgressDao.getUserProgress();
      expect(progress!.currentStreak, 3);
    });

    test('resets streak on failure', () async {
      await database.userProgressDao.updateStreak(true);
      await database.userProgressDao.updateStreak(true);
      await database.userProgressDao.updateStreak(false);

      final progress = await database.userProgressDao.getUserProgress();
      expect(progress!.currentStreak, 0);
    });
  });

  group('AchievementsDao', () {
    test('updates achievement progress', () async {
      const achievementKey = 'first_note';
      await database.achievementsDao.updateProgress(achievementKey, 1);

      final achievement = await database.achievementsDao.getAchievementByKey(
        achievementKey,
      );
      expect(achievement!.currentProgress, 1);
      expect(achievement.isUnlocked, true); // Target is 1
    });

    test('calculates unlock percentage', () async {
      await database.achievementsDao.unlockAchievement('first_note');
      await database.achievementsDao.unlockAchievement('speed_demon');

      final percentage = await database.achievementsDao.getUnlockPercentage();
      expect(percentage, greaterThan(0));
    });
  });

  group('ThemesDao', () {
    test('switches active theme', () async {
      await database.themesDao.setActiveTheme('retro_terminal');

      final activeTheme = await database.themesDao.getActiveTheme();
      expect(activeTheme!.themeKey, 'retro_terminal');

      // Check old theme is deactivated
      final defaultTheme = await database.themesDao.getThemeByKey('default');
      expect(defaultTheme!.isActive, false);
    });

    test('unlocks theme', () async {
      await database.themesDao.unlockTheme('vaporwave');

      final theme = await database.themesDao.getThemeByKey('vaporwave');
      expect(theme!.isUnlocked, true);
      expect(theme.unlockedAt, isNotNull);
    });
  });
}
