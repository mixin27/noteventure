package database

import (
	"context"
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

func (r *SyncRepository) UpsertNote(ctx context.Context, userID uuid.UUID, note *sync.NoteSync) error {
	query := `
        INSERT INTO notes (
            id, user_id, title, content, note_type, is_locked, unlock_date, category_id,
            sort_order, color, is_pinned, is_favorite, required_challenge_level,
            is_deleted, deleted_at, edit_count, created_at, updated_at, device_id, version, last_synced_at
        ) VALUES (
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, NOW()
        )
        ON CONFLICT (id) DO UPDATE SET
            title = EXCLUDED.title,
            content = EXCLUDED.content,
            note_type = EXCLUDED.note_type,
            is_locked = EXCLUDED.is_locked,
            unlock_date = EXCLUDED.unlock_date,
            category_id = EXCLUDED.category_id,
            sort_order = EXCLUDED.sort_order,
            color = EXCLUDED.color,
            is_pinned = EXCLUDED.is_pinned,
            is_favorite = EXCLUDED.is_favorite,
            required_challenge_level = EXCLUDED.required_challenge_level,
            is_deleted = EXCLUDED.is_deleted,
            deleted_at = EXCLUDED.deleted_at,
            edit_count = EXCLUDED.edit_count,
            updated_at = EXCLUDED.updated_at,
            device_id = EXCLUDED.device_id,
            version = EXCLUDED.version,
            last_synced_at = NOW()
        WHERE notes.updated_at < EXCLUDED.updated_at
    `

	_, err := r.db.ExecContext(ctx, query,
		note.ID, userID, note.Title, note.Content, note.NoteType, note.IsLocked,
		note.UnlockDate, note.CategoryID, note.SortOrder, note.Color, note.IsPinned,
		note.IsFavorite, note.RequiredChallengeLevel, note.IsDeleted, note.DeletedAt,
		note.EditCount, note.CreatedAt, note.UpdatedAt, note.DeviceID, note.Version,
	)

	return err
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
	if err != nil {
		return nil, err
	}

	return &progress, nil
}

func (r *SyncRepository) UpsertProgress(ctx context.Context, userID uuid.UUID, progress *sync.ProgressSync) error {
	query := `
        INSERT INTO user_progress (
            user_id, total_points, lifetime_points_earned, lifetime_points_spent,
            level, current_xp, xp_to_next_level, current_streak, longest_streak,
            last_challenge_date, total_challenges_solved, total_challenges_failed,
            total_notes_created, total_notes_deleted, chaos_enabled,
            challenge_time_limit, personality_tone, sound_enabled,
            notifications_enabled, updated_at
        ) VALUES (
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20
        )
        ON CONFLICT (user_id) DO UPDATE SET
            total_points = EXCLUDED.total_points,
            lifetime_points_earned = EXCLUDED.lifetime_points_earned,
            lifetime_points_spent = EXCLUDED.lifetime_points_spent,
            level = EXCLUDED.level,
            current_xp = EXCLUDED.current_xp,
            xp_to_next_level = EXCLUDED.xp_to_next_level,
            current_streak = EXCLUDED.current_streak,
            longest_streak = EXCLUDED.longest_streak,
            last_challenge_date = EXCLUDED.last_challenge_date,
            total_challenges_solved = EXCLUDED.total_challenges_solved,
            total_challenges_failed = EXCLUDED.total_challenges_failed,
            total_notes_created = EXCLUDED.total_notes_created,
            total_notes_deleted = EXCLUDED.total_notes_deleted,
            chaos_enabled = EXCLUDED.chaos_enabled,
            challenge_time_limit = EXCLUDED.challenge_time_limit,
            personality_tone = EXCLUDED.personality_tone,
            sound_enabled = EXCLUDED.sound_enabled,
            notifications_enabled = EXCLUDED.notifications_enabled,
            updated_at = EXCLUDED.updated_at
        WHERE user_progress.updated_at < EXCLUDED.updated_at
    `

	_, err := r.db.ExecContext(ctx, query,
		userID, progress.TotalPoints, progress.LifetimePointsEarned, progress.LifetimePointsSpent,
		progress.Level, progress.CurrentXp, progress.XpToNextLevel, progress.CurrentStreak,
		progress.LongestStreak, progress.LastChallengeDate, progress.TotalChallengesSolved,
		progress.TotalChallengesFailed, progress.TotalNotesCreated, progress.TotalNotesDeleted,
		progress.ChaosEnabled, progress.ChallengeTimeLimit, progress.PersonalityTone,
		progress.SoundEnabled, progress.NotificationsEnabled, progress.UpdatedAt,
	)

	return err
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

func (r *SyncRepository) UpsertTransaction(ctx context.Context, userID uuid.UUID, tx *sync.TransactionSync) error {
	query := `
        INSERT INTO point_transactions (
            id, user_id, amount, reason, description, related_note_id,
            related_challenge_id, related_event_id, balance_after, timestamp, synced_at
        ) VALUES (
            $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, NOW()
        )
        ON CONFLICT (id) DO NOTHING
    `

	_, err := r.db.ExecContext(ctx, query,
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
