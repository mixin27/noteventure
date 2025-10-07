package challenge

import (
	"context"
)

type Repository interface {
	GetRandomChallenge(ctx context.Context, challengeType, difficulty string) (*Challenge, error)
	GetChallengeByID(ctx context.Context, id int) (*Challenge, error)
	IncrementUsageCount(ctx context.Context, id int) error
	CreateChallenge(ctx context.Context, challenge *Challenge) error
	GetChallengesByType(ctx context.Context, challengeType string) ([]Challenge, error)
}
