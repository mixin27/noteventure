package sync

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type Repository interface {
	// Notes
	GetNotesSince(ctx context.Context, userID uuid.UUID, since *time.Time) ([]NoteSync, error)
	UpsertNote(ctx context.Context, userID uuid.UUID, note *NoteSync) error

	// Progress
	GetProgress(ctx context.Context, userID uuid.UUID) (*ProgressSync, error)
	UpsertProgress(ctx context.Context, userID uuid.UUID, progress *ProgressSync) error

	// Transactions
	GetTransactionsSince(ctx context.Context, userID uuid.UUID, since *time.Time) ([]TransactionSync, error)
	UpsertTransaction(ctx context.Context, userID uuid.UUID, tx *TransactionSync) error

	// Sync log
	LogSync(ctx context.Context, userID uuid.UUID, entityType, entityID, action string) error
}
