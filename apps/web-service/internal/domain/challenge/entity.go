package challenge

import (
	"time"
)

type Challenge struct {
	ID            int       `db:"id" json:"id"`
	ChallengeType string    `db:"challenge_type" json:"challenge_type"`
	Difficulty    string    `db:"difficulty" json:"difficulty"`
	Question      string    `db:"question" json:"question"`
	CorrectAnswer string    `db:"correct_answer" json:"correct_answer"`
	WrongAnswers  []string  `db:"wrong_answers" json:"wrong_answers,omitempty"`
	Explanation   *string   `db:"explanation" json:"explanation,omitempty"`
	Category      *string   `db:"category" json:"category,omitempty"`
	TimesUsed     int       `db:"times_used" json:"times_used"`
	IsActive      bool      `db:"is_active" json:"is_active"`
	CreatedAt     time.Time `db:"created_at" json:"created_at"`
}

type ChallengeRequest struct {
	Type       string `json:"type" validate:"required,oneof=math trivia word_game riddle pattern"`
	Difficulty string `json:"difficulty" validate:"required,oneof=easy medium hard"`
}

type ChallengeResponse struct {
	ID          int      `json:"id"`
	Type        string   `json:"type"`
	Difficulty  string   `json:"difficulty"`
	Question    string   `json:"question"`
	Options     []string `json:"options,omitempty"`
	Category    *string  `json:"category,omitempty"`
	PointReward int      `json:"point_reward"`
	XpReward    int      `json:"xp_reward"`
	TimeLimit   int      `json:"time_limit"`
}

type SubmitAnswerRequest struct {
	ChallengeID int    `json:"challenge_id" validate:"required"`
	Answer      string `json:"answer" validate:"required"`
}

type SubmitAnswerResponse struct {
	IsCorrect     bool    `json:"is_correct"`
	CorrectAnswer string  `json:"correct_answer"`
	Explanation   *string `json:"explanation,omitempty"`
	PointsEarned  int     `json:"points_earned"`
	XpEarned      int     `json:"xp_earned"`
	Message       string  `json:"message"`
}
