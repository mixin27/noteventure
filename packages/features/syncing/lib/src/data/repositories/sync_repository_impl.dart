import 'dart:convert';
import 'dart:developer';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/sync_repository.dart';
import '../datasources/sync_local_datasource.dart';
import '../datasources/sync_remote_datasource.dart';
import '../mappers/sync_mappers.dart';

class SyncRepositoryImpl implements SyncRepository {
  final SyncRemoteDataSource _remoteDataSource;
  final SyncLocalDataSource _localDataSource;

  SyncRepositoryImpl({
    required SyncRemoteDataSource remoteDataSource,
    required SyncLocalDataSource localDataSource,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource;

  @override
  Future<Either<Failure, SyncResult>> sync() async {
    try {
      // Get device ID
      final deviceId = await DeviceInfoHelper.getDeviceId();

      // Get last sync timestamp
      final lastSync = await _localDataSource.getLastSyncTimestamp();

      // Get local data to sync
      final notesToSync = await _localDataSource.getNotesToSync(lastSync);
      final progressToSync = await _localDataSource.getProgressToSync();
      final transactionsToSync = await _localDataSource.getTransactionsToSync(
        lastSync,
      );
      final settingsToSync = await _localDataSource.getSettingsToSync();

      // Map to DTOs
      final noteDtos = notesToSync
          .map((note) => SyncMappers.noteToDto(note, deviceId))
          .toList();

      final progressDto = progressToSync != null
          ? SyncMappers.progressToDto(
              progressToSync,
              settingsToSync.chaosEnabled,
              settingsToSync.challengeTimeLimit,
              settingsToSync.personalityTone,
              settingsToSync.soundEnabled,
              settingsToSync.notificationsEnabled,
            )
          : null;

      final transactionDtos = transactionsToSync
          .map((tx) => SyncMappers.transactionToDto(tx))
          .toList();

      // Create sync request
      final request = SyncRequest(
        deviceId: deviceId,
        lastSyncTimestamp: lastSync,
        notes: noteDtos.isNotEmpty ? noteDtos : null,
        progress: progressDto,
        transactions: transactionDtos.isNotEmpty ? transactionDtos : null,
      );

      log(jsonEncode(request.toJson()));

      // Perform sync
      final response = await _remoteDataSource.syncData(request: request);

      // Save synced data locally
      if (response.notes.isNotEmpty) {
        final notes = response.notes
            .map((dto) => SyncMappers.dtoToNote(dto))
            .toList();
        await _localDataSource.saveNotesFromSync(notes);
      }

      if (response.progress != null) {
        final progress = SyncMappers.dtoToProgress(response.progress!);
        await _localDataSource.saveProgressFromSync(progress);

        // Save settings from progress DTO
        await _localDataSource.saveSettingsFromSync(
          response.progress!.chaosEnabled,
          response.progress!.challengeTimeLimit,
          response.progress!.personalityTone,
          response.progress!.soundEnabled,
          response.progress!.notificationsEnabled,
        );
      }

      if (response.transactions.isNotEmpty) {
        final transactions = response.transactions
            .map((dto) => SyncMappers.dtoToTransaction(dto))
            .toList();
        await _localDataSource.saveTransactionsFromSync(transactions);
      }

      // Save last sync timestamp
      await _localDataSource.saveLastSyncTimestamp(response.syncedAt);

      // Create result
      final result = SyncResult(
        notesSynced: 0,
        transactionsSynced: 0,
        progressSynced: response.progress != null,
        conflictsFound: response.conflicts.length,
        syncedAt: response.syncedAt,
      );

      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Sync failed: $e'));
    }
  }

  @override
  Future<Either<Failure, SyncResult>> pullFromServer() async {
    try {
      // Get last sync timestamp
      final lastSync = await _localDataSource.getLastSyncTimestamp();

      // Pull data from server
      final response = await _remoteDataSource.pullData(
        lastSyncTimestamp: lastSync,
      );

      // Save synced data locally
      if (response.notes.isNotEmpty) {
        final notes = response.notes
            .map((dto) => SyncMappers.dtoToNote(dto))
            .toList();
        await _localDataSource.saveNotesFromSync(notes);
      }

      if (response.progress != null) {
        final progress = SyncMappers.dtoToProgress(response.progress!);
        await _localDataSource.saveProgressFromSync(progress);

        await _localDataSource.saveSettingsFromSync(
          response.progress!.chaosEnabled,
          response.progress!.challengeTimeLimit,
          response.progress!.personalityTone,
          response.progress!.soundEnabled,
          response.progress!.notificationsEnabled,
        );
      }

      if (response.transactions.isNotEmpty) {
        final transactions = response.transactions
            .map((dto) => SyncMappers.dtoToTransaction(dto))
            .toList();
        await _localDataSource.saveTransactionsFromSync(transactions);
      }

      // Save last sync timestamp
      await _localDataSource.saveLastSyncTimestamp(response.syncedAt);

      final result = SyncResult(
        notesSynced: response.notes.length,
        transactionsSynced: response.transactions.length,
        progressSynced: response.progress != null,
        conflictsFound: response.conflicts.length,
        syncedAt: response.syncedAt,
      );

      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Pull failed: $e'));
    }
  }

  @override
  Future<Either<Failure, DateTime>> pushToServer() async {
    try {
      // Get device ID
      final deviceId = await DeviceInfoHelper.getDeviceId();

      // Get last sync timestamp
      final lastSync = await _localDataSource.getLastSyncTimestamp();

      // Get local data to sync
      final notesToSync = await _localDataSource.getNotesToSync(lastSync);
      final progressToSync = await _localDataSource.getProgressToSync();
      final transactionsToSync = await _localDataSource.getTransactionsToSync(
        lastSync,
      );
      final settingsToSync = await _localDataSource.getSettingsToSync();

      // Map to DTOs
      final noteDtos = notesToSync
          .map((note) => SyncMappers.noteToDto(note, deviceId))
          .toList();

      final progressDto = progressToSync != null
          ? SyncMappers.progressToDto(
              progressToSync,
              settingsToSync.chaosEnabled,
              settingsToSync.challengeTimeLimit,
              settingsToSync.personalityTone,
              settingsToSync.soundEnabled,
              settingsToSync.notificationsEnabled,
            )
          : null;

      final transactionDtos = transactionsToSync
          .map((tx) => SyncMappers.transactionToDto(tx))
          .toList();

      // Create sync request
      final request = SyncRequest(
        deviceId: deviceId,
        lastSyncTimestamp: lastSync,
        notes: noteDtos.isNotEmpty ? noteDtos : null,
        progress: progressDto,
        transactions: transactionDtos.isNotEmpty ? transactionDtos : null,
      );

      // Push data to server
      final response = await _remoteDataSource.pushData(request: request);

      return Right(response.syncedAt);
    } on ApiException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Push failed: $e'));
    }
  }

  @override
  Future<Either<Failure, DateTime?>> getLastSyncTime() async {
    try {
      final lastSync = await _localDataSource.getLastSyncTimestamp();
      return Right(lastSync);
    } catch (e) {
      return Left(CacheFailure('Failed to get last sync time: $e'));
    }
  }
}
