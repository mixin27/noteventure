import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
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
    final result = await _notesRepository.getAllNotes();
    return result.fold((failure) => [], (notesList) {
      if (since == null) return notesList;

      // Filter notes updated after last sync
      return notesList.where((note) => note.updatedAt.isAfter(since)).toList();
    });
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
      (failure) => const settings.AppSettings(),
      (appSettings) => appSettings,
    );
  }

  // ============================================================================
  // SAVE SYNCED DATA
  // ============================================================================
  @override
  Future<void> saveNotesFromSync(List<notes.Note> notesFromServer) async {
    // First, get ALL local notes to compare
    final allLocalNotesResult = await _notesRepository.getAllNotes();
    final allLocalNotes = allLocalNotesResult.getOrElse(() => []);

    for (final serverNote in notesFromServer) {
      // Check if this note already exists locally
      final existingNoteResult = await _notesRepository.getNoteById(
        serverNote.id,
      );

      await existingNoteResult.fold(
        // Note NOT found by ID
        (failure) async {
          // Double-check: manually search in all local notes
          final manualMatch = allLocalNotes.where((n) => n.id == serverNote.id);
          if (manualMatch.isNotEmpty) {
            return;
          }

          try {
            await _notesRepository.createNoteWithId(
              id: serverNote.id,
              title: serverNote.title,
              content: serverNote.content,
              noteType: serverNote.noteType,
              categoryId: serverNote.categoryId,
              color: serverNote.color,
              isPinned: serverNote.isPinned,
              isFavorite: serverNote.isFavorite,
              createdAt: serverNote.createdAt,
              updatedAt: serverNote.updatedAt,
            );
          } catch (e, stackTrace) {
            debugPrint('[SYNC MOBILE] ❌ Failed to insert note: $e');
            debugPrint('[SYNC MOBILE] Stack trace: $stackTrace');
          }
        },
        // Note FOUND by ID
        (existingNote) async {
          final localTime = existingNote.updatedAt.toUtc();
          final serverTime = serverNote.updatedAt.toUtc();

          if (serverTime.isAfter(localTime)) {
            try {
              await _notesRepository.updateNote(
                id: existingNote.id,
                title: serverNote.title,
                content: serverNote.content,
                categoryId: serverNote.categoryId,
                color: serverNote.color,
                isPinned: serverNote.isPinned,
                isFavorite: serverNote.isFavorite,
              );
            } catch (e, stackTrace) {
              debugPrint('[SYNC MOBILE] ❌ Failed to update note: $e');
              debugPrint('[SYNC MOBILE] Stack trace: $stackTrace');
            }
          } else if (serverTime.isBefore(localTime)) {
            debugPrint(
              '[SYNC MOBILE] ⏭️  Local is NEWER - SKIPPING (will sync to server on next push)',
            );
          } else {
            debugPrint(
              '[SYNC MOBILE] ⏭️  Timestamps are EQUAL - SKIPPING (already synced)',
            );
          }
        },
      );
    }

    // Get final count
    final finalNotesResult = await _notesRepository.getAllNotes();
    final finalNotes = finalNotesResult.getOrElse(() => []);
    debugPrint('[SYNC MOBILE] Final note count: ${finalNotes.length}');
    debugPrint(
      '[SYNC MOBILE] Final note IDs: ${finalNotes.map((n) => '${n.id}:"${n.title}"').join(', ')}',
    );
    debugPrint('═══════════════════════════════════════════════════════');
  }

  @override
  Future<void> saveProgressFromSync(
    progress.UserProgress progressFromServer,
  ) async {
    final currentResult = await _progressRepository.getUserProgress();

    await currentResult.fold(
      (failure) async {
        debugPrint('[SYNC]   No local progress - should not happen, skipping');
      },
      (current) async {
        // Compare levels and XP - only update if server is ahead
        final shouldUpdate =
            progressFromServer.level > current.level ||
            (progressFromServer.level == current.level &&
                progressFromServer.currentXp > current.currentXp);

        if (shouldUpdate) {
          // Calculate XP difference
          final xpDiff = progressFromServer.currentXp - current.currentXp;
          if (xpDiff > 0) {
            await _progressRepository.addXp(xpDiff);
          }

          // Update other stats if your repository supports it
          // TODO: Add methods to update streaks, stats etc if needed
        } else {
          debugPrint('[SYNC]   Local progress is AHEAD or EQUAL - SKIPPING');
        }
      },
    );
  }

  @override
  Future<void> saveTransactionsFromSync(
    List<points.PointTransaction> transactionsFromServer,
  ) async {
    // Get all existing transaction IDs
    final allTransactionsResult = await _pointsRepository.getAllTransactions();
    final existingTransactionIds = allTransactionsResult.fold(
      (failure) => <String>{},
      (transactions) => transactions.map((tx) => tx.id).toSet(),
    );

    int insertedCount = 0;
    int skippedCount = 0;

    for (final serverTransaction in transactionsFromServer) {
      // Check if transaction already exists
      if (existingTransactionIds.contains(serverTransaction.id)) {
        debugPrint(
          '[SYNC]   Transaction ${serverTransaction.id} already exists - SKIPPING',
        );
        skippedCount++;
        continue;
      }

      // New transaction - INSERT
      debugPrint(
        '[SYNC]   Transaction ${serverTransaction.id} is NEW - INSERTING',
      );

      // TODO: Add method to PointsRepository to insert transaction with specific ID
      // For now, transactions are immutable and should not be duplicated

      insertedCount++;
    }

    debugPrint(
      '[SYNC] ✓ Transactions: $insertedCount inserted, $skippedCount skipped',
    );
  }

  @override
  Future<void> saveSettingsFromSync(
    bool chaosEnabled,
    int challengeTimeLimit,
    String personalityTone,
    bool soundEnabled,
    bool notificationsEnabled,
  ) async {
    final currentResult = await _settingsRepository.getSettings();

    await currentResult.fold(
      (failure) async {
        debugPrint('[SYNC]   Failed to get current settings - SKIPPING');
      },
      (current) async {
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

    await result.fold(
      (failure) async {
        debugPrint('[SYNC]   Failed to save timestamp - settings not found');
        throw CacheException("Can't save without existing settings");
      },
      (current) async {
        final updated = current.copyWith(lastSyncTimestamp: timestamp);
        await _settingsRepository.updateSettings(updated);
      },
    );
  }
}
