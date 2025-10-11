import 'package:core/core.dart';
import 'package:notes/notes.dart' as notes_domain;
import 'package:progress/progress.dart' as progress_domain;
import 'package:points/points.dart' as points_domain;

class SyncMappers {
  // ============================================================================
  // Note Mappers
  // ============================================================================

  static NoteSyncDto noteToDto(notes_domain.Note note, String deviceId) {
    return NoteSyncDto(
      id: note.id,
      title: note.title,
      content: note.content,
      noteType: note.noteType.name,
      isLocked: note.isLocked,
      unlockDate: note.unlockDate,
      categoryId: note.categoryId,
      sortOrder: note.sortOrder,
      color: note.color,
      isPinned: note.isPinned,
      isFavorite: note.isFavorite,
      requiredChallengeLevel: note.requiredChallengeLevel,
      isDeleted: note.isDeleted,
      deletedAt: note.deletedAt,
      editCount: note.editCount,
      createdAt: note.createdAt,
      updatedAt: note.updatedAt,
      deviceId: deviceId,
      version: 1, // You can add version tracking if needed
    );
  }

  static notes_domain.Note dtoToNote(NoteSyncDto dto) {
    return notes_domain.Note(
      id: dto.id,
      title: dto.title,
      content: dto.content,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      editCount: dto.editCount,
      noteType: notes_domain.NoteType.fromString(dto.noteType),
      isLocked: dto.isLocked,
      unlockDate: dto.unlockDate,
      categoryId: dto.categoryId,
      sortOrder: dto.sortOrder,
      color: dto.color,
      isPinned: dto.isPinned,
      isFavorite: dto.isFavorite,
      requiredChallengeLevel: dto.requiredChallengeLevel,
      isDeleted: dto.isDeleted,
      deletedAt: dto.deletedAt,
      serverUuid: dto.id,
    );
  }

  // ============================================================================
  // Progress Mappers
  // ============================================================================

  static ProgressSyncDto progressToDto(
    progress_domain.UserProgress progress,
    bool chaosEnabled,
    int challengeTimeLimit,
    String personalityTone,
    bool soundEnabled,
    bool notificationsEnabled,
  ) {
    return ProgressSyncDto(
      totalPoints: 0, // todo(mixin27): Get from points system
      lifetimePointsEarned: 0, // todo(mixin27): Get from points system
      lifetimePointsSpent: 0, // todo(mixin27): Get from points system
      level: progress.level,
      currentXp: progress.currentXp,
      xpToNextLevel: progress.xpToNextLevel,
      currentStreak: progress.currentStreak,
      longestStreak: progress.longestStreak,
      lastChallengeDate: progress.lastChallengeDate,
      totalChallengesSolved: progress.totalChallengesSolved,
      totalChallengesFailed: progress.totalChallengesFailed,
      totalNotesCreated: progress.totalNotesCreated,
      totalNotesDeleted: progress.totalNotesDeleted,
      chaosEnabled: chaosEnabled,
      challengeTimeLimit: challengeTimeLimit,
      personalityTone: personalityTone,
      soundEnabled: soundEnabled,
      notificationsEnabled: notificationsEnabled,
      updatedAt: DateTime.now(),
    );
  }

  static progress_domain.UserProgress dtoToProgress(ProgressSyncDto dto) {
    // Calculate total XP
    final totalXp = _calculateTotalXp(dto.level, dto.currentXp);

    return progress_domain.UserProgress(
      level: dto.level,
      currentXp: dto.currentXp,
      xpToNextLevel: dto.xpToNextLevel,
      totalXp: totalXp,
      currentStreak: dto.currentStreak,
      longestStreak: dto.longestStreak,
      lastChallengeDate: dto.lastChallengeDate,
      totalChallengesSolved: dto.totalChallengesSolved,
      totalChallengesFailed: dto.totalChallengesFailed,
      totalNotesCreated: dto.totalNotesCreated,
      totalNotesDeleted: dto.totalNotesDeleted,
    );
  }

  // ============================================================================
  // Transaction Mappers
  // ============================================================================

  static TransactionSyncDto transactionToDto(
    points_domain.PointTransaction transaction,
  ) {
    return TransactionSyncDto(
      id: transaction.id,
      amount: transaction.amount,
      reason: transaction.reason,
      description: transaction.description,
      relatedNoteId: transaction.relatedNoteId?.toString(),
      relatedChallengeId: transaction.relatedChallengeId?.toString(),
      relatedEventId: transaction.relatedEventId,
      balanceAfter: transaction.balanceAfter,
      timestamp: transaction.timestamp,
    );
  }

  static points_domain.PointTransaction dtoToTransaction(
    TransactionSyncDto dto,
  ) {
    return points_domain.PointTransaction(
      id: dto.id,
      amount: dto.amount,
      reason: dto.reason,
      description: dto.description,
      timestamp: dto.timestamp,
      relatedNoteId: dto.relatedNoteId,
      relatedChallengeId: dto.relatedChallengeId,
      relatedEventId: dto.relatedEventId,
      balanceAfter: dto.balanceAfter,
      serverUuid: dto.id,
    );
  }

  // ============================================================================
  // Helper Methods
  // ============================================================================

  static int _calculateTotalXp(int level, int currentXp) {
    // Use your existing XpCalculator if available
    // For now, simple calculation
    int totalXp = currentXp;
    for (int i = 1; i < level; i++) {
      totalXp += _xpForLevel(i);
    }
    return totalXp;
  }

  static int _xpForLevel(int level) {
    // Should match your XpCalculator logic
    return 100 * level;
  }
}
