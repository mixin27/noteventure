# Noteventure Web Service

Backend API for the Noteventure gamified notes app.

## Tech Stack

- **Go 1.25+** - Backend language
- **Fiber v2** - Web framework
- **PostgreSQL** - Database
- **JWT** - Authentication
- **sqlx** - Database toolkit

## Getting Started

### Prerequisites

- Go 1.21 or higher
- PostgreSQL 14+ (or use Docker)
- golang-migrate CLI (for migrations)

### Installation

1. Install dependencies:

```bash
cd apps/web-service
go mod download
```

2. Copy environment file:

```bash
cp .env.example .env
```

3. Start PostgreSQL (using Docker):

```bash
make docker-up
```

4. Run migrations:

```bash
make migrate-up
```

5. Start the server:

```bash
make run
```

The API will be available at `http://localhost:8080`

### Available Commands

```bash
make run           # Run the server
make build         # Build binary
make test          # Run tests
make migrate-up    # Run migrations
make migrate-down  # Rollback migrations
make docker-up     # Start Docker containers
make docker-down   # Stop Docker containers
```

### API Endpoints

#### Health Check

```bash
GET /health
```

#### APIv1

```
Base URL: /api/v1
```

(More endpoints to be documented as they're implemented)

### Project Structure

```bash
apps/web-service/
├── cmd/server/          # Application entry point
├── internal/            # Private application code
│   ├── domain/          # Business logic
│   ├── infrastructure/  # External services
│   └── api/             # HTTP handlers
├── pkg/                 # Public libraries
├── migrations/          # Database migrations
└── config/              # Configuration
```

### Development

#### Live Reload

Install Air for live reloading during development:

```bash
go install github.com/cosmtrek/air@latest
air
```

### Database Management

Access Adminer (database UI) at [http://localhost:8081](http://localhost:8081) when Docker is running.

## License

MIT
