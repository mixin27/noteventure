package sync

import (
	"time"

	"github.com/google/uuid"
)

type SyncRequest struct {
	LastSyncTimestamp *time.Time        `json:"last_sync_timestamp"`
	DeviceID          string            `json:"device_id" validate:"required"`
	Notes             []NoteSync        `json:"notes,omitempty"`
	Progress          *ProgressSync     `json:"progress,omitempty"`
	Transactions      []TransactionSync `json:"transactions,omitempty"`
}

type SyncResponse struct {
	Notes        []NoteSync        `json:"notes"`
	Progress     *ProgressSync     `json:"progress,omitempty"`
	Transactions []TransactionSync `json:"transactions"`
	Conflicts    []Conflict        `json:"conflicts,omitempty"`
	SyncedAt     time.Time         `json:"synced_at"`
}

type NoteSync struct {
	ID                     uuid.UUID  `db:"id" json:"id"`
	Title                  string     `db:"title" json:"title"`
	Content                string     `db:"content" json:"content"`
	NoteType               string     `db:"note_type" json:"note_type"`
	IsLocked               bool       `db:"is_locked" json:"is_locked"`
	UnlockDate             *time.Time `db:"unlock_date" json:"unlock_date,omitempty"`
	CategoryID             *int       `db:"category_id" json:"category_id,omitempty"`
	SortOrder              int        `db:"sort_order" json:"sort_order"`
	Color                  *string    `db:"color" json:"color,omitempty"`
	IsPinned               bool       `db:"is_pinned" json:"is_pinned"`
	IsFavorite             bool       `db:"is_favorite" json:"is_favorite"`
	RequiredChallengeLevel *int       `db:"required_challenge_level" json:"required_challenge_level,omitempty"`
	IsDeleted              bool       `db:"is_deleted" json:"is_deleted"`
	DeletedAt              *time.Time `db:"deleted_at" json:"deleted_at,omitempty"`
	EditCount              int        `db:"edit_count" json:"edit_count"`
	CreatedAt              time.Time  `db:"created_at" json:"created_at"`
	UpdatedAt              time.Time  `db:"updated_at" json:"updated_at"`
	DeviceID               string     `db:"device_id" json:"device_id"`
	Version                int        `db:"version" json:"version"`
}

type ProgressSync struct {
	TotalPoints           int        `db:"total_points" json:"total_points"`
	LifetimePointsEarned  int        `db:"lifetime_points_earned" json:"lifetime_points_earned"`
	LifetimePointsSpent   int        `db:"lifetime_points_spent" json:"lifetime_points_spent"`
	Level                 int        `db:"level" json:"level"`
	CurrentXp             int        `db:"current_xp" json:"current_xp"`
	XpToNextLevel         int        `db:"xp_to_next_level" json:"xp_to_next_level"`
	CurrentStreak         int        `db:"current_streak" json:"current_streak"`
	LongestStreak         int        `db:"longest_streak" json:"longest_streak"`
	LastChallengeDate     *time.Time `db:"last_challenge_date" json:"last_challenge_date,omitempty"`
	TotalChallengesSolved int        `db:"total_challenges_solved" json:"total_challenges_solved"`
	TotalChallengesFailed int        `db:"total_challenges_failed" json:"total_challenges_failed"`
	TotalNotesCreated     int        `db:"total_notes_created" json:"total_notes_created"`
	TotalNotesDeleted     int        `db:"total_notes_deleted" json:"total_notes_deleted"`
	ChaosEnabled          bool       `db:"chaos_enabled" json:"chaos_enabled"`
	ChallengeTimeLimit    int        `db:"challenge_time_limit" json:"challenge_time_limit"`
	PersonalityTone       string     `db:"personality_tone" json:"personality_tone"`
	SoundEnabled          bool       `db:"sound_enabled" json:"sound_enabled"`
	NotificationsEnabled  bool       `db:"notifications_enabled" json:"notifications_enabled"`
	UpdatedAt             time.Time  `db:"updated_at" json:"updated_at"`
}

type TransactionSync struct {
	ID                 uuid.UUID  `db:"id" json:"id"`
	Amount             int        `db:"amount" json:"amount"`
	Reason             string     `db:"reason" json:"reason"`
	Description        *string    `db:"description" json:"description,omitempty"`
	RelatedNoteID      *uuid.UUID `db:"related_note_id" json:"related_note_id,omitempty"`
	RelatedChallengeID *uuid.UUID `db:"related_challenge_id" json:"related_challenge_id,omitempty"`
	RelatedEventID     *int       `db:"related_event_id" json:"related_event_id,omitempty"`
	BalanceAfter       int        `db:"balance_after" json:"balance_after"`
	Timestamp          time.Time  `db:"timestamp" json:"timestamp"`
}

type Conflict struct {
	EntityType string      `json:"entity_type"`
	EntityID   string      `json:"entity_id"`
	Reason     string      `json:"reason"`
	ServerData interface{} `json:"server_data"`
	ClientData interface{} `json:"client_data"`
}
