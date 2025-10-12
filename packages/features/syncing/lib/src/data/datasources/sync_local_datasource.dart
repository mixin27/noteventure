import 'dart:developer' as developer;

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
    developer.log(
      '[SYNC] Received ${notesFromServer.length} notes from server',
    );

    for (final serverNote in notesFromServer) {
      developer.log(
        '[SYNC] Processing note: ${serverNote.id} - ${serverNote.title}',
      );
      developer.log('[SYNC]   UpdatedAt: ${serverNote.updatedAt}');

      // Get existing note by ID
      final existingNoteResult = await _notesRepository.getNoteById(
        serverNote.id,
      );

      await existingNoteResult.fold(
        // Note doesn't exist locally
        (failure) async {
          developer.log('[SYNC]   Note ${serverNote.id} NOT found locally');

          // Only insert if it's truly a new note from another device
          // Check by serverUuid if available
          if (serverNote.serverUuid != null) {
            developer.log(
              '[SYNC]   Checking by serverUuid: ${serverNote.serverUuid}',
            );

            // Check if we already have a note with this serverUuid
            final allNotesResult = await _notesRepository.getAllNotes();
            final allNotes = allNotesResult.getOrElse(() => []);

            final existingByServerUuid = allNotes.any(
              (n) => n.serverUuid == serverNote.serverUuid,
            );

            if (existingByServerUuid) {
              developer.log(
                '[SYNC]   Found by serverUuid! Local ID: $existingByServerUuid',
              );
              developer.log(
                '[SYNC]   SKIPPING insertion (already exists with different local ID)',
              );
              // We already have this note, just different local ID
              // Skip insertion to avoid duplicate
              return;
            }
          }

          // Truly new note from server - insert it
          developer.log('[SYNC]   INSERTING new note from server');
          await _notesRepository.createNote(
            title: serverNote.title,
            content: serverNote.content,
            noteType: serverNote.noteType,
            categoryId: serverNote.categoryId,
            color: serverNote.color,
            // isPinned: serverNote.isPinned,
            // isFavorite: serverNote.isFavorite,
          );
          developer.log('[SYNC]   Successfully inserted');
        },
        // Note exists locally
        (existingNote) async {
          developer.log('[SYNC]   Note ${serverNote.id} FOUND locally');
          developer.log('[SYNC]   Local updatedAt: ${existingNote.updatedAt}');
          developer.log('[SYNC]   Server updatedAt: ${serverNote.updatedAt}');

          // Compare timestamps - only update if server version is newer
          if (serverNote.updatedAt.isAfter(existingNote.updatedAt)) {
            developer.log('[SYNC]   Server is NEWER - UPDATING local note');

            // Server has newer version - update local
            await _notesRepository.updateNote(
              id: existingNote.id,
              title: serverNote.title,
              content: serverNote.content,
              categoryId: serverNote.categoryId,
              color: serverNote.color,
              // isPinned: serverNote.isPinned,
              // isFavorite: serverNote.isFavorite,
            );
            developer.log('[SYNC]   Successfully updated');
          } else if (serverNote.updatedAt.isBefore(existingNote.updatedAt)) {
            developer.log('[SYNC]   Local is NEWER - SKIPPING update');
            // Local version is newer - skip (it will be synced on next push)
            return;
          } else {
            // If timestamps are equal, no action needed (already synced)
            developer.log('[SYNC]   Timestamps are EQUAL - SKIPPING update');
          }
        },
      );
    }

    developer.log('[SYNC] Finished processing all notes from server');
  }

  @override
  Future<void> saveProgressFromSync(
    progress.UserProgress progressFromServer,
  ) async {
    final currentResult = await _progressRepository.getUserProgress();

    await currentResult.fold(
      (failure) async {
        // No local progress exists - this shouldn't happen
        // but handle gracefully by doing nothing
        // Progress should be initialized on first app run
      },
      (current) async {
        // Compare levels and XP - only update if server is ahead
        // This prevents downgrading progress
        final shouldUpdate =
            progressFromServer.level > current.level ||
            (progressFromServer.level == current.level &&
                progressFromServer.currentXp > current.currentXp);

        if (shouldUpdate) {
          // Server progress is ahead - update local
          // Note: You might need to add a direct update method to ProgressRepository
          // For now, use the existing addXp method
          final xpDiff = progressFromServer.currentXp - current.currentXp;
          if (xpDiff > 0) {
            await _progressRepository.addXp(xpDiff);
          }

          // Update other stats that might have changed
          // todo(mixin27): Add methods to update streaks, stats etc if needed
        }
      },
    );
  }

  @override
  Future<void> saveTransactionsFromSync(
    List<points.PointTransaction> transactionsFromServer,
  ) async {
    // Transactions are immutable - only insert if they don't exist
    final allTransactionsResult = await _pointsRepository.getAllTransactions();
    final existingTransactionIds = allTransactionsResult.fold(
      (failure) => <String>[],
      (transactions) => transactions.map((tx) => tx.id).toSet(),
    );

    for (final serverTransaction in transactionsFromServer) {
      // Check if transaction already exists locally
      if (!existingTransactionIds.contains(serverTransaction.id)) {
        // New transaction from server - insert it
        // You may need to add a method to directly insert a transaction
        // with a specific ID and timestamp
        // For now, this assumes the repository handles it
        // todo(mixin27): Add insertTransaction method to PointsRepository if needed
      }
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
    final currentResult = await _settingsRepository.getSettings();

    await currentResult.fold(
      (failure) async {
        // Failed to get settings, skip update
      },
      (current) async {
        // Update only the synced settings
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
        throw CacheException("Can't save without existing settings");
      },
      (current) async {
        final updated = current.copyWith(lastSyncTimestamp: timestamp);
        await _settingsRepository.updateSettings(updated);
      },
    );
  }
}
