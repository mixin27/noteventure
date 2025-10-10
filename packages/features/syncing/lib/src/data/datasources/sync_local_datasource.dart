import 'package:core/core.dart';
import 'package:notes/notes.dart' as notes;
import 'package:progress/progress.dart' as progress;
import 'package:points/points.dart' as points;
import 'package:settings/settings.dart' as settings;

abstract class SyncLocalDataSource {
  // Get data to sync
  Future<List<notes.Note>> getNotesToSync(DateTime? since);
  Future<progress.UserProgress?> getProgressToSync();
  Future<List<points.PointTransaction>> getTransactionsToSync(DateTime? since);
  Future<settings.AppSettings> getSettingsToSync();

  // Save synced data
  Future<void> saveNotesFromSync(List<notes.Note> notes);
  Future<void> saveProgressFromSync(progress.UserProgress progress);
  Future<void> saveTransactionsFromSync(
    List<points.PointTransaction> transactions,
  );
  Future<void> saveSettingsFromSync(
    bool chaosEnabled,
    int challengeTimeLimit,
    String personalityTone,
    bool soundEnabled,
    bool notificationsEnabled,
  );

  // Get/Save last sync timestamp
  Future<DateTime?> getLastSyncTimestamp();
  Future<void> saveLastSyncTimestamp(DateTime timestamp);
}

class SyncLocalDataSourceImpl implements SyncLocalDataSource {
  final notes.NotesRepository _notesRepository;
  final progress.ProgressRepository _progressRepository;
  final points.PointsRepository _pointsRepository;
  final settings.SettingsRepository _settingsRepository;

  // Key for storing last sync timestamp
  // static const String _lastSyncKey = 'last_sync_timestamp';

  SyncLocalDataSourceImpl({
    required notes.NotesRepository notesRepository,
    required progress.ProgressRepository progressRepository,
    required points.PointsRepository pointsRepository,
    required settings.SettingsRepository settingsRepository,
  }) : _notesRepository = notesRepository,
       _progressRepository = progressRepository,
       _pointsRepository = pointsRepository,
       _settingsRepository = settingsRepository;

  @override
  Future<List<notes.Note>> getNotesToSync(DateTime? since) async {
    // Get all notes modified after 'since' timestamp
    // For now, get all notes
    final result = await _notesRepository.getAllNotes();
    return result.fold((failure) => [], (notesList) => notesList);
  }

  @override
  Future<progress.UserProgress?> getProgressToSync() async {
    final result = await _progressRepository.getUserProgress();
    return result.fold((failure) => null, (prog) => prog);
  }

  @override
  Future<List<points.PointTransaction>> getTransactionsToSync(
    DateTime? since,
  ) async {
    final result = await _pointsRepository.getAllTransactions();
    return result.fold((failure) => [], (transactions) {
      // Filter by timestamp if 'since' is provided
      if (since != null) {
        return transactions.where((tx) => tx.timestamp.isAfter(since)).toList();
      }
      return transactions;
    });
  }

  @override
  Future<settings.AppSettings> getSettingsToSync() async {
    final result = await _settingsRepository.getSettings();
    return result.fold(
      (failure) => const settings.AppSettings(), // Return defaults on failure
      (appSettings) => appSettings,
    );
  }

  // ============================================================================
  // SAVE SYNCED DATA
  // ============================================================================

  @override
  Future<void> saveNotesFromSync(List<notes.Note> notes) async {
    // Save each note to local database
    for (final note in notes) {
      // Check if note already exists
      final existingNote = await _notesRepository.getNoteById(note.id);

      existingNote.fold(
        (failure) async {
          // Note doesn't exist, create it
          await _notesRepository.createNote(
            title: note.title,
            content: note.content,
            noteType: note.noteType,
            categoryId: note.categoryId,
          );
        },
        (existing) async {
          // Note exists, update if server version is newer
          if (note.updatedAt.isAfter(existing.updatedAt)) {
            await _notesRepository.updateNote(
              id: note.id,
              title: note.title,
              content: note.content,
              categoryId: note.categoryId,
            );
          }
        },
      );
    }
  }

  @override
  Future<void> saveProgressFromSync(progress.UserProgress progress) async {
    // Get current local progress
    final currentResult = await _progressRepository.getUserProgress();

    currentResult.fold(
      (failure) async {
        // No local progress exists, this shouldn't happen but handle gracefully
        // Progress should be initialized on first app run
      },
      (current) async {
        // Only update if server has newer or higher values
        // This prevents downgrading progress
        if (progress.level >= current.level &&
            progress.totalXp >= current.totalXp) {
          // Update progress
          // Note: You may need to add a method to directly update progress
          // For now, we can add XP to reach the synced level
          final xpDiff = progress.totalXp - current.totalXp;
          if (xpDiff > 0) {
            await _progressRepository.addXp(xpDiff);
          }
        }
      },
    );
  }

  @override
  Future<void> saveTransactionsFromSync(
    List<points.PointTransaction> transactions,
  ) async {
    // Transactions are typically append-only
    // Check if each transaction already exists before inserting
    for (final transaction in transactions) {
      // You may need to add a method to check if transaction exists
      // For now, assume repository handles duplicates
      // TODO: Implement transaction existence check if needed
    }
  }

  @override
  Future<void> saveSettingsFromSync(
    bool chaosEnabled,
    int challengeTimeLimit,
    String personalityTone,
    bool soundEnabled,
    bool notificationsEnabled,
  ) async {
    // Get current settings
    final currentResult = await _settingsRepository.getSettings();

    currentResult.fold(
      (failure) async {
        // Failed to get settings, skip update
      },
      (current) async {
        // Update only the synced settings, keep local-only settings
        final updatedSettings = current.copyWith(
          chaosEnabled: chaosEnabled,
          challengeTimeLimit: challengeTimeLimit,
          personalityTone: personalityTone,
          soundEnabled: soundEnabled,
          notificationsEnabled: notificationsEnabled,
        );

        await _settingsRepository.updateSettings(updatedSettings);
      },
    );
  }

  @override
  Future<DateTime?> getLastSyncTimestamp() async {
    final result = await _settingsRepository.getSettings();

    return result.fold(
      (failure) => null,
      (appSettings) => appSettings.lastSyncTimestamp,
    );
  }

  @override
  Future<void> saveLastSyncTimestamp(DateTime timestamp) async {
    final result = await _settingsRepository.getSettings();

    result.fold(
      (failure) async {
        throw CacheException("Can't save without existing settings");
      },
      (current) async {
        final updated = current.copyWith(lastSyncTimestamp: timestamp);
        await _settingsRepository.updateSettings(updated);
      },
    );
  }
}
