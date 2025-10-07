package challenge

import (
	"context"
	"math/rand"
	"strings"
)

type Service struct {
	repo Repository
}

func NewService(repo Repository) *Service {
	return &Service{repo: repo}
}

func (s *Service) GetChallenge(ctx context.Context, req *ChallengeRequest) (*ChallengeResponse, error) {
	// Get random challenge from database
	challenge, err := s.repo.GetRandomChallenge(ctx, req.Type, req.Difficulty)
	if err != nil {
		return nil, err
	}

	// Increment usage count
	if err := s.repo.IncrementUsageCount(ctx, challenge.ID); err != nil {
		// Log but don't fail
	}

	// Calculate rewards based on difficulty
	pointReward := s.calculatePoints(req.Difficulty)
	xpReward := s.calculateXP(req.Difficulty)
	timeLimit := s.calculateTimeLimit(req.Difficulty)

	// Prepare options for multiple choice questions
	var options []string
	if len(challenge.WrongAnswers) > 0 {
		options = append(options, challenge.CorrectAnswer)
		options = append(options, challenge.WrongAnswers...)
		// Shuffle options
		rand.Shuffle(len(options), func(i, j int) {
			options[i], options[j] = options[j], options[i]
		})
	}

	return &ChallengeResponse{
		ID:          challenge.ID,
		Type:        challenge.ChallengeType,
		Difficulty:  challenge.Difficulty,
		Question:    challenge.Question,
		Options:     options,
		Category:    challenge.Category,
		PointReward: pointReward,
		XpReward:    xpReward,
		TimeLimit:   timeLimit,
	}, nil
}

func (s *Service) SubmitAnswer(ctx context.Context, req *SubmitAnswerRequest) (*SubmitAnswerResponse, error) {
	// Get challenge
	challenge, err := s.repo.GetChallengeByID(ctx, req.ChallengeID)
	if err != nil {
		return nil, err
	}

	// Check answer (case-insensitive)
	isCorrect := strings.EqualFold(
		strings.TrimSpace(req.Answer),
		strings.TrimSpace(challenge.CorrectAnswer),
	)

	pointsEarned := 0
	xpEarned := 0
	message := ""

	if isCorrect {
		pointsEarned = s.calculatePoints(challenge.Difficulty)
		xpEarned = s.calculateXP(challenge.Difficulty)
		message = s.getSuccessMessage()
	} else {
		message = s.getFailureMessage()
	}

	return &SubmitAnswerResponse{
		IsCorrect:     isCorrect,
		CorrectAnswer: challenge.CorrectAnswer,
		Explanation:   challenge.Explanation,
		PointsEarned:  pointsEarned,
		XpEarned:      xpEarned,
		Message:       message,
	}, nil
}

func (s *Service) calculatePoints(difficulty string) int {
	switch difficulty {
	case "easy":
		return 10
	case "medium":
		return 20
	case "hard":
		return 30
	default:
		return 10
	}
}

func (s *Service) calculateXP(difficulty string) int {
	switch difficulty {
	case "easy":
		return 15
	case "medium":
		return 30
	case "hard":
		return 50
	default:
		return 15
	}
}

func (s *Service) calculateTimeLimit(difficulty string) int {
	switch difficulty {
	case "easy":
		return 60
	case "medium":
		return 45
	case "hard":
		return 30
	default:
		return 60
	}
}

func (s *Service) getSuccessMessage() string {
	messages := []string{
		"Excellent work!",
		"You got it right!",
		"Brilliant!",
		"Perfect answer!",
		"Well done!",
	}
	return messages[rand.Intn(len(messages))]
}

func (s *Service) getFailureMessage() string {
	messages := []string{
		"Not quite right, try again!",
		"Close, but not correct.",
		"Better luck next time!",
		"Keep trying!",
	}
	return messages[rand.Intn(len(messages))]
}
