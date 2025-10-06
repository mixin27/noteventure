package database

import (
	"context"
	"database/sql"
	"errors"

	"github.com/google/uuid"
	"github.com/jmoiron/sqlx"

	"github.com/mixin27/noteventure/web-service/internal/domain/user"
)

type UserRepository struct {
	db *sqlx.DB
}

func NewUserRepository(db *sqlx.DB) *UserRepository {
	return &UserRepository{db: db}
}

func (r *UserRepository) Create(ctx context.Context, u *user.User) error {
	query := `
        INSERT INTO users (id, email, username, password_hash, created_at, updated_at, is_active)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        RETURNING id
    `

	u.ID = uuid.New()

	return r.db.QueryRowContext(
		ctx,
		query,
		u.ID,
		u.Email,
		u.Username,
		u.PasswordHash,
		u.CreatedAt,
		u.UpdatedAt,
		u.IsActive,
	).Scan(&u.ID)
}

func (r *UserRepository) FindByEmail(ctx context.Context, email string) (*user.User, error) {
	var u user.User
	query := `SELECT * FROM users WHERE email = $1 AND is_active = true`

	err := r.db.GetContext(ctx, &u, query, email)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, errors.New("user not found")
		}
		return nil, err
	}

	return &u, nil
}

func (r *UserRepository) FindByID(ctx context.Context, id uuid.UUID) (*user.User, error) {
	var u user.User
	query := `SELECT * FROM users WHERE id = $1 AND is_active = true`

	err := r.db.GetContext(ctx, &u, query, id)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, errors.New("user not found")
		}
		return nil, err
	}

	return &u, nil
}

func (r *UserRepository) FindByUsername(ctx context.Context, username string) (*user.User, error) {
	var u user.User
	query := `SELECT * FROM users WHERE username = $1 AND is_active = true`

	err := r.db.GetContext(ctx, &u, query, username)
	if err != nil {
		if errors.Is(err, sql.ErrNoRows) {
			return nil, errors.New("user not found")
		}
		return nil, err
	}

	return &u, nil
}

func (r *UserRepository) Update(ctx context.Context, u *user.User) error {
	query := `
        UPDATE users
        SET email = $1, username = $2, updated_at = $3, last_sync_at = $4
        WHERE id = $5
    `

	_, err := r.db.ExecContext(ctx, query, u.Email, u.Username, u.UpdatedAt, u.LastSyncAt, u.ID)
	return err
}
