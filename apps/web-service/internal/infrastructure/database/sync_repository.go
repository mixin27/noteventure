package database

import (
	"context"
	"database/sql"
	"time"

	"github.com/google/uuid"
	"github.com/jmoiron/sqlx"

	"github.com/mixin27/noteventure/web-service/internal/domain/sync"
)

type SyncRepository struct {
	db *sqlx.DB
}

func NewSyncRepository(db *sqlx.DB) *SyncRepository {
	return &SyncRepository{db: db}
}

// Notes
func (r *SyncRepository) GetNotesSince(ctx context.Context, userID uuid.UUID, since *time.Time) ([]sync.NoteSync, error) {
	var notes []sync.NoteSync

	query := `
        SELECT id, title, content, note_type, is_locked, unlock_date, category_id,
               sort_order, color, is_pinned, is_favorite, required_challenge_level,
               is_deleted, deleted_at, edit_count, created_at, updated_at, device_id, version
        FROM notes
        WHERE user_id = $1 AND updated_at > $2
        ORDER BY updated_at ASC
    `

	sinceTime := time.Time{}
	if since != nil {
		sinceTime = *since
	}

	err := r.db.SelectContext(ctx, &notes, query, userID, sinceTime)
	return notes, err
}

// UpsertNote with proper conflict resolution
func (r *SyncRepository) UpsertNote(ctx context.Context, userID uuid.UUID, note *sync.NoteSync) error {
	// First, check if note exists and get its updated_at timestamp
	var existingUpdatedAt time.Time
	checkQuery := `SELECT updated_at FROM notes WHERE id = $1 AND user_id = $2`
	err := r.db.GetContext(ctx, &existingUpdatedAt, checkQuery, note.ID, userID)

	if err == sql.ErrNoRows {
		// Note doesn't exist - INSERT only
		insertQuery := `
            INSERT INTO notes (
                id, user_id, title, content, note_type, is_locked, unlock_date, category_id,
                sort_order, color, is_pinned, is_favorite, required_challenge_level,
                is_deleted, deleted_at, edit_count, created_at, updated_at, device_id, version, last_synced_at
            ) VALUES (
                $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, NOW()
            )
        `

		_, err = r.db.ExecContext(ctx, insertQuery,
			note.ID, userID, note.Title, note.Content, note.NoteType, note.IsLocked,
			note.UnlockDate, note.CategoryID, note.SortOrder, note.Color, note.IsPinned,
			note.IsFavorite, note.RequiredChallengeLevel, note.IsDeleted, note.DeletedAt,
			note.EditCount, note.CreatedAt, note.UpdatedAt, note.DeviceID, note.Version,
		)

		return err
	} else if err != nil {
		return err
	}

	// Note exists - check if client data is newer
	// Use UTC for comparison to avoid timezone issues
	clientTime := note.UpdatedAt.UTC()
	serverTime := existingUpdatedAt.UTC()

	if clientTime.After(serverTime) {
		// Client data is newer - UPDATE
		updateQuery := `
            UPDATE notes SET
                title = $1,
                content = $2,
                note_type = $3,
                is_locked = $4,
                unlock_date = $5,
                category_id = $6,
                sort_order = $7,
                color = $8,
                is_pinned = $9,
                is_favorite = $10,
                required_challenge_level = $11,
                is_deleted = $12,
                deleted_at = $13,
                edit_count = $14,
                updated_at = $15,
                device_id = $16,
                version = $17,
                last_synced_at = NOW()
            WHERE id = $18 AND user_id = $19
        `

		_, err = r.db.ExecContext(ctx, updateQuery,
			note.Title, note.Content, note.NoteType, note.IsLocked, note.UnlockDate,
			note.CategoryID, note.SortOrder, note.Color, note.IsPinned, note.IsFavorite,
			note.RequiredChallengeLevel, note.IsDeleted, note.DeletedAt, note.EditCount,
			note.UpdatedAt, note.DeviceID, note.Version, note.ID, userID,
		)

		return err
	} else if clientTime.Equal(serverTime) {
		// Same timestamp - already synced, just update last_synced_at
		_, err = r.db.ExecContext(ctx, `
            UPDATE notes SET last_synced_at = NOW()
            WHERE id = $1 AND user_id = $2
        `, note.ID, userID)

		return err
	}

	// Server data is newer - SKIP update (client will get it on next pull)
	return nil
}

// Progress
func (r *SyncRepository) GetProgress(ctx context.Context, userID uuid.UUID) (*sync.ProgressSync, error) {
	var progress sync.ProgressSync

	query := `
        SELECT total_points, lifetime_points_earned, lifetime_points_spent, level,
               current_xp, xp_to_next_level, current_streak, longest_streak,
               last_challenge_date, total_challenges_solved, total_challenges_failed,
               total_notes_created, total_notes_deleted, chaos_enabled,
               challenge_time_limit, personality_tone, sound_enabled,
               notifications_enabled, updated_at
        FROM user_progress
        WHERE user_id = $1
    `

	err := r.db.GetContext(ctx, &progress, query, userID)
	if err == sql.ErrNoRows {
		return nil, nil
	}
	if err != nil {
		return nil, err
	}

	return &progress, nil
}

// UpsertProgress with conflict resolution
func (r *SyncRepository) UpsertProgress(ctx context.Context, userID uuid.UUID, progress *sync.ProgressSync) error {
	// Check if progress exists
	var existingUpdatedAt time.Time
	err := r.db.GetContext(ctx, &existingUpdatedAt,
		`SELECT updated_at FROM user_progress WHERE user_id = $1`, userID)

	if err == sql.ErrNoRows {
		// Progress doesn't exist - INSERT
		insertQuery := `
            INSERT INTO user_progress (
                user_id, total_points, lifetime_points_earned, lifetime_points_spent,
                level, current_xp, xp_to_next_level, current_streak, longest_streak,
                last_challenge_date, total_challenges_solved, total_challenges_failed,
                total_notes_created, total_notes_deleted, chaos_enabled,
                challenge_time_limit, personality_tone, sound_enabled,
                notifications_enabled, updated_at, last_synced_at
            ) VALUES (
                $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, NOW()
            )
        `

		_, err = r.db.ExecContext(ctx, insertQuery,
			userID, progress.TotalPoints, progress.LifetimePointsEarned, progress.LifetimePointsSpent,
			progress.Level, progress.CurrentXp, progress.XpToNextLevel, progress.CurrentStreak,
			progress.LongestStreak, progress.LastChallengeDate, progress.TotalChallengesSolved,
			progress.TotalChallengesFailed, progress.TotalNotesCreated, progress.TotalNotesDeleted,
			progress.ChaosEnabled, progress.ChallengeTimeLimit, progress.PersonalityTone,
			progress.SoundEnabled, progress.NotificationsEnabled, progress.UpdatedAt,
		)

		return err
	} else if err != nil {
		return err
	}

	// Progress exists - check if client data is newer
	if progress.UpdatedAt.After(existingUpdatedAt) {
		// Client data is newer - UPDATE
		updateQuery := `
            UPDATE user_progress SET
                total_points = $1,
                lifetime_points_earned = $2,
                lifetime_points_spent = $3,
                level = $4,
                current_xp = $5,
                xp_to_next_level = $6,
                current_streak = $7,
                longest_streak = $8,
                last_challenge_date = $9,
                total_challenges_solved = $10,
                total_challenges_failed = $11,
                total_notes_created = $12,
                total_notes_deleted = $13,
                chaos_enabled = $14,
                challenge_time_limit = $15,
                personality_tone = $16,
                sound_enabled = $17,
                notifications_enabled = $18,
                updated_at = $19,
                last_synced_at = NOW()
            WHERE user_id = $20
        `

		_, err = r.db.ExecContext(ctx, updateQuery,
			progress.TotalPoints, progress.LifetimePointsEarned, progress.LifetimePointsSpent,
			progress.Level, progress.CurrentXp, progress.XpToNextLevel, progress.CurrentStreak,
			progress.LongestStreak, progress.LastChallengeDate, progress.TotalChallengesSolved,
			progress.TotalChallengesFailed, progress.TotalNotesCreated, progress.TotalNotesDeleted,
			progress.ChaosEnabled, progress.ChallengeTimeLimit, progress.PersonalityTone,
			progress.SoundEnabled, progress.NotificationsEnabled, progress.UpdatedAt, userID,
		)

		return err
	}

	// Server data is newer or same - SKIP
	return nil
}

// Transactions
func (r *SyncRepository) GetTransactionsSince(ctx context.Context, userID uuid.UUID, since *time.Time) ([]sync.TransactionSync, error) {
	var transactions []sync.TransactionSync

	query := `
        SELECT id, amount, reason, description, related_note_id, related_challenge_id,
               related_event_id, balance_after, timestamp
        FROM point_transactions
        WHERE user_id = $1 AND timestamp > $2
        ORDER BY timestamp ASC
    `

	sinceTime := time.Time{}
	if since != nil {
		sinceTime = *since
	}

	err := r.db.SelectContext(ctx, &transactions, query, userID, sinceTime)
	return transactions, err
}

// UpsertTransaction - Transactions are immutable, only insert if not exists
func (r *SyncRepository) UpsertTransaction(ctx context.Context, userID uuid.UUID, tx *sync.TransactionSync) error {
	// Check if transaction already exists
	var exists bool
	err := r.db.GetContext(ctx, &exists,
		`SELECT EXISTS(SELECT 1 FROM point_transactions WHERE id = $1)`, tx.ID)

	if err != nil {
		return err
	}

	if exists {
		// Transaction already exists - SKIP (transactions are immutable)
		return nil
	}

	// Transaction doesn't exist - INSERT
	query := `
        INSERT INTO point_transactions (
            id, user_id, amount, reason, description, related_note_id,
            related_challenge_id, related_event_id, balance_after, timestamp, synced_at
        ) VALUES (
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, NOW()
        )
    `

	_, err = r.db.ExecContext(ctx, query,
		tx.ID, userID, tx.Amount, tx.Reason, tx.Description, tx.RelatedNoteID,
		tx.RelatedChallengeID, tx.RelatedEventID, tx.BalanceAfter, tx.Timestamp,
	)

	return err
}

func (r *SyncRepository) LogSync(ctx context.Context, userID uuid.UUID, entityType, entityID, action string) error {
	query := `
        INSERT INTO sync_log (user_id, entity_type, entity_id, action, synced_at)
        VALUES ($1, $2, $3, $4, NOW())
    `

	_, err := r.db.ExecContext(ctx, query, userID, entityType, entityID, action)
	return err
}
