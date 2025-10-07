package database

import (
	"context"
	"database/sql"
	"encoding/json"
	"errors"

	"github.com/jmoiron/sqlx"

	"github.com/mixin27/noteventure/web-service/internal/domain/challenge"
)

type ChallengeRepository struct {
	db *sqlx.DB
}

func NewChallengeRepository(db *sqlx.DB) *ChallengeRepository {
	return &ChallengeRepository{db: db}
}

// Custom type to handle JSONB array
type challengeRow struct {
	ID            int             `db:"id"`
	ChallengeType string          `db:"challenge_type"`
	Difficulty    string          `db:"difficulty"`
	Question      string          `db:"question"`
	CorrectAnswer string          `db:"correct_answer"`
	WrongAnswers  json.RawMessage `db:"wrong_answers"`
	Explanation   *string         `db:"explanation"`
	Category      *string         `db:"category"`
	TimesUsed     int             `db:"times_used"`
	IsActive      bool            `db:"is_active"`
	CreatedAt     sql.NullTime    `db:"created_at"`
}

func (r *ChallengeRepository) GetRandomChallenge(ctx context.Context, challengeType, difficulty string) (*challenge.Challenge, error) {
	query := `
        SELECT id, challenge_type, difficulty, question, correct_answer,
               wrong_answers,
               explanation, category, times_used, is_active, created_at
        FROM challenge_questions
        WHERE challenge_type = $1 AND difficulty = $2 AND is_active = true
        ORDER BY RANDOM()
        LIMIT 1
    `

	var row challengeRow
	err := r.db.GetContext(ctx, &row, query, challengeType, difficulty)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, errors.New("no challenges found for the given criteria")
		}
		return nil, err
	}

	// Parse wrong_answers JSONB to string slice
	var wrongAnswers []string
	if row.WrongAnswers != nil {
		if err := json.Unmarshal(row.WrongAnswers, &wrongAnswers); err != nil {
			wrongAnswers = []string{}
		}
	}

	return &challenge.Challenge{
		ID:            row.ID,
		ChallengeType: row.ChallengeType,
		Difficulty:    row.Difficulty,
		Question:      row.Question,
		CorrectAnswer: row.CorrectAnswer,
		WrongAnswers:  wrongAnswers,
		Explanation:   row.Explanation,
		Category:      row.Category,
		TimesUsed:     row.TimesUsed,
		IsActive:      row.IsActive,
		CreatedAt:     row.CreatedAt.Time,
	}, nil
}

func (r *ChallengeRepository) GetChallengeByID(ctx context.Context, id int) (*challenge.Challenge, error) {
	query := `
        SELECT id, challenge_type, difficulty, question, correct_answer,
               wrong_answers,
               explanation, category, times_used, is_active, created_at
        FROM challenge_questions
        WHERE id = $1
    `

	var row challengeRow
	err := r.db.GetContext(ctx, &row, query, id)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, errors.New("challenge not found")
		}
		return nil, err
	}

	// Parse wrong_answers JSONB to string slice
	var wrongAnswers []string
	if row.WrongAnswers != nil {
		if err := json.Unmarshal(row.WrongAnswers, &wrongAnswers); err != nil {
			wrongAnswers = []string{}
		}
	}

	return &challenge.Challenge{
		ID:            row.ID,
		ChallengeType: row.ChallengeType,
		Difficulty:    row.Difficulty,
		Question:      row.Question,
		CorrectAnswer: row.CorrectAnswer,
		WrongAnswers:  wrongAnswers,
		Explanation:   row.Explanation,
		Category:      row.Category,
		TimesUsed:     row.TimesUsed,
		IsActive:      row.IsActive,
		CreatedAt:     row.CreatedAt.Time,
	}, nil
}

func (r *ChallengeRepository) IncrementUsageCount(ctx context.Context, id int) error {
	query := `
        UPDATE challenge_questions
        SET times_used = times_used + 1, last_used = NOW()
        WHERE id = $1
    `

	_, err := r.db.ExecContext(ctx, query, id)
	return err
}

func (r *ChallengeRepository) CreateChallenge(ctx context.Context, c *challenge.Challenge) error {
	query := `
        INSERT INTO challenge_questions (
            challenge_type, difficulty, question, correct_answer,
            wrong_answers, explanation, category, is_active
        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        RETURNING id
    `

	wrongAnswersJSON, err := json.Marshal(c.WrongAnswers)
	if err != nil {
		return err
	}

	return r.db.QueryRowContext(
		ctx, query,
		c.ChallengeType, c.Difficulty, c.Question, c.CorrectAnswer,
		wrongAnswersJSON, c.Explanation, c.Category, c.IsActive,
	).Scan(&c.ID)
}

func (r *ChallengeRepository) GetChallengesByType(ctx context.Context, challengeType string) ([]challenge.Challenge, error) {
	query := `
        SELECT id, challenge_type, difficulty, question, correct_answer,
               wrong_answers,
               explanation, category, times_used, is_active, created_at
        FROM challenge_questions
        WHERE challenge_type = $1 AND is_active = true
        ORDER BY times_used ASC
    `

	var rows []challengeRow
	err := r.db.SelectContext(ctx, &rows, query, challengeType)
	if err != nil {
		return nil, err
	}

	challenges := make([]challenge.Challenge, len(rows))
	for i, row := range rows {
		// Parse wrong_answers JSONB to string slice
		var wrongAnswers []string
		if row.WrongAnswers != nil {
			if err := json.Unmarshal(row.WrongAnswers, &wrongAnswers); err != nil {
				wrongAnswers = []string{}
			}
		}

		challenges[i] = challenge.Challenge{
			ID:            row.ID,
			ChallengeType: row.ChallengeType,
			Difficulty:    row.Difficulty,
			Question:      row.Question,
			CorrectAnswer: row.CorrectAnswer,
			WrongAnswers:  wrongAnswers,
			Explanation:   row.Explanation,
			Category:      row.Category,
			TimesUsed:     row.TimesUsed,
			IsActive:      row.IsActive,
			CreatedAt:     row.CreatedAt.Time,
		}
	}

	return challenges, nil
}
