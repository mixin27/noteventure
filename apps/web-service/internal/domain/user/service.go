package user

import (
	"context"
	"errors"
	"time"

	"github.com/mixin27/noteventure/web-service/config"
	"github.com/mixin27/noteventure/web-service/pkg/crypto"
	"github.com/mixin27/noteventure/web-service/pkg/jwt"
)

type Service struct {
	repo   Repository
	config *config.Config
}

func NewService(repo Repository, cfg *config.Config) *Service {
	return &Service{
		repo:   repo,
		config: cfg,
	}
}

func (s *Service) Register(ctx context.Context, req *RegisterRequest) (*AuthResponse, error) {
	// Check if user already exists
	existingUser, _ := s.repo.FindByEmail(ctx, req.Email)
	if existingUser != nil {
		return nil, errors.New("user with this email already exists")
	}

	// Check username if provided
	if req.Username != nil && *req.Username != "" {
		existingUser, _ = s.repo.FindByUsername(ctx, *req.Username)
		if existingUser != nil {
			return nil, errors.New("username already taken")
		}
	}

	// Hash password
	hashedPassword, err := crypto.HashPassword(req.Password)
	if err != nil {
		return nil, errors.New("failed to hash password")
	}

	// Create user
	now := time.Now()
	user := &User{
		Email:        req.Email,
		Username:     req.Username,
		PasswordHash: hashedPassword,
		CreatedAt:    now,
		UpdatedAt:    now,
		IsActive:     true,
	}

	if err := s.repo.Create(ctx, user); err != nil {
		return nil, err
	}

	// Generate tokens
	tokens, err := s.generateTokens(user)
	if err != nil {
		return nil, err
	}

	return &AuthResponse{
		User:         *user,
		AccessToken:  tokens.AccessToken,
		RefreshToken: tokens.RefreshToken,
	}, nil
}

func (s *Service) Login(ctx context.Context, req *LoginRequest) (*AuthResponse, error) {
	// Find user by email
	user, err := s.repo.FindByEmail(ctx, req.Email)
	if err != nil {
		return nil, errors.New("invalid email or password")
	}

	// Check password
	if !crypto.CheckPassword(req.Password, user.PasswordHash) {
		return nil, errors.New("invalid email or password")
	}

	// Generate tokens
	tokens, err := s.generateTokens(user)
	if err != nil {
		return nil, err
	}

	return &AuthResponse{
		User:         *user,
		AccessToken:  tokens.AccessToken,
		RefreshToken: tokens.RefreshToken,
	}, nil
}

func (s *Service) generateTokens(user *User) (*jwt.TokenPair, error) {
	accessTTL, err := time.ParseDuration(s.config.JWT.AccessTokenTTL)
	if err != nil {
		accessTTL = 15 * time.Minute
	}

	refreshTTL, err := time.ParseDuration(s.config.JWT.RefreshTokenTTL)
	if err != nil {
		refreshTTL = 7 * 24 * time.Hour
	}

	username := ""
	if user.Username != nil {
		username = *user.Username
	}

	return jwt.GenerateTokenPair(
		user.ID.String(),
		user.Email,
		username,
		s.config.JWT.Secret,
		accessTTL,
		refreshTTL,
	)
}

func (s *Service) ValidateToken(tokenString string) (*jwt.Claims, error) {
	return jwt.ValidateToken(tokenString, s.config.JWT.Secret)
}
