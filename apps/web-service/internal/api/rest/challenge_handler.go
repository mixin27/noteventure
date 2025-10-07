package rest

import (
	"github.com/go-playground/validator/v10"
	"github.com/gofiber/fiber/v2"

	"github.com/mixin27/noteventure/web-service/internal/domain/challenge"
)

type ChallengeHandler struct {
	challengeService *challenge.Service
	validator        *validator.Validate
}

func NewChallengeHandler(challengeService *challenge.Service) *ChallengeHandler {
	return &ChallengeHandler{
		challengeService: challengeService,
		validator:        validator.New(),
	}
}

// GetRandomChallenge - Get a random challenge based on type and difficulty
func (h *ChallengeHandler) GetRandomChallenge(c *fiber.Ctx) error {
	var req challenge.ChallengeRequest

	// Parse query parameters
	req.Type = c.Query("type", "math")
	req.Difficulty = c.Query("difficulty", "easy")

	if err := h.validator.Struct(req); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error":   "Validation failed",
			"details": err.Error(),
		})
	}

	resp, err := h.challengeService.GetChallenge(c.Context(), &req)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.JSON(resp)
}

// SubmitAnswer - Submit an answer to a challenge
func (h *ChallengeHandler) SubmitAnswer(c *fiber.Ctx) error {
	var req challenge.SubmitAnswerRequest

	if err := c.BodyParser(&req); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error": "Invalid request body",
		})
	}

	if err := h.validator.Struct(req); err != nil {
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
			"error":   "Validation failed",
			"details": err.Error(),
		})
	}

	resp, err := h.challengeService.SubmitAnswer(c.Context(), &req)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{
			"error": err.Error(),
		})
	}

	return c.JSON(resp)
}
