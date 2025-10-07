.PHONY: help run build test migrate-up migrate-down migrate-create docker-up docker-down

help:
	@echo "Available commands:"
	@echo "  make run           - Run the server"
	@echo "  make build         - Build the binary"
	@echo "  make test          - Run tests"
	@echo "  make migrate-up    - Run database migrations"
	@echo "  make migrate-down  - Rollback database migrations"
	@echo "  make migrate-create NAME=migration_name - Create new migration"
	@echo "  make docker-up     - Start Docker containers"
	@echo "  make docker-down   - Stop Docker containers"

run:
	@echo "Starting server..."
	@go run cmd/server/main.go

build:
	@echo "Building binary..."
	@go build -o bin/server cmd/server/main.go

test:
	@echo "Running tests..."
	@go test -v ./...

migrate-up:
	@echo "Running migrations..."
	@migrate -path migrations -database "postgresql://postgres:postgres@localhost:5432/noteventure?sslmode=disable" up

migrate-down:
	@echo "Rolling back migrations..."
	@migrate -path migrations -database "postgresql://postgres:postgres@localhost:5432/noteventure?sslmode=disable" down 1

migrate-create:
	@echo "Creating migration: $(NAME)"
	@migrate create -ext sql -dir migrations -seq $(NAME)

docker-up:
	@echo "Starting Docker containers..."
	@docker-compose up -d

docker-down:
	@echo "Stopping Docker containers..."
	@docker-compose down

deps:
	@echo "Installing dependencies..."
	@go mod download
	@go mod tidy

lint:
	@echo "Running linter..."
	@golangci-lint run

dev:
	@echo "Starting development server with auto-reload..."
	@air
