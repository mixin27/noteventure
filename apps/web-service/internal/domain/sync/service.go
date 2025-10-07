package sync

import (
	"context"
	"time"

	"github.com/google/uuid"
)

type Service struct {
	repo Repository
}

func NewService(repo Repository) *Service {
	return &Service{repo: repo}
}

func (s *Service) Pull(ctx context.Context, userID uuid.UUID, lastSync *time.Time) (*SyncResponse, error) {
	// Get all changes since last sync
	notes, err := s.repo.GetNotesSince(ctx, userID, lastSync)
	if err != nil {
		return nil, err
	}

	progress, err := s.repo.GetProgress(ctx, userID)
	if err != nil {
		// If no progress exists yet, return nil (first sync)
		progress = nil
	}

	transactions, err := s.repo.GetTransactionsSince(ctx, userID, lastSync)
	if err != nil {
		return nil, err
	}

	return &SyncResponse{
		Notes:        notes,
		Progress:     progress,
		Transactions: transactions,
		Conflicts:    []Conflict{}, // TODO: Implement conflict detection
		SyncedAt:     time.Now(),
	}, nil
}

func (s *Service) Push(ctx context.Context, userID uuid.UUID, req *SyncRequest) error {
	// Sync notes
	for _, note := range req.Notes {
		if err := s.repo.UpsertNote(ctx, userID, &note); err != nil {
			return err
		}

		action := "update"
		if note.IsDeleted {
			action = "delete"
		}

		if err := s.repo.LogSync(ctx, userID, "note", note.ID.String(), action); err != nil {
			return err
		}
	}

	// Sync progress
	if req.Progress != nil {
		if err := s.repo.UpsertProgress(ctx, userID, req.Progress); err != nil {
			return err
		}

		if err := s.repo.LogSync(ctx, userID, "progress", userID.String(), "update"); err != nil {
			return err
		}
	}

	// Sync transactions
	for _, tx := range req.Transactions {
		if err := s.repo.UpsertTransaction(ctx, userID, &tx); err != nil {
			return err
		}

		if err := s.repo.LogSync(ctx, userID, "transaction", tx.ID.String(), "create"); err != nil {
			return err
		}
	}

	return nil
}

func (s *Service) Sync(ctx context.Context, userID uuid.UUID, req *SyncRequest) (*SyncResponse, error) {
	// First push client changes
	if err := s.Push(ctx, userID, req); err != nil {
		return nil, err
	}

	// Then pull server changes
	return s.Pull(ctx, userID, req.LastSyncTimestamp)
}
