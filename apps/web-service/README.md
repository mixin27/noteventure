# Noteventure Web Service

Backend API for the Noteventure gamified notes app.

## Features

- ✅ User Authentication (JWT-based)
- ✅ Data Sync (Notes, Progress, Transactions)
- ✅ Challenge System (Math, Trivia, Word Games)
- ✅ PostgreSQL Database
- ✅ Clean Architecture

## Tech Stack

- **Go 1.21+** - Backend language
- **Fiber v2** - Web framework
- **PostgreSQL 16** - Database
- **JWT** - Authentication
- **sqlx** - Database toolkit
- **golang-migrate** - Database migrations

## Getting Started

### Prerequisites

- Go 1.21 or higher
- PostgreSQL 14+ (or use Docker)
- golang-migrate CLI

### Installation

1. Navigate to the project:
```bash
cd apps/web-service
```

2. Install dependencies:
```bash
go mod download
```

3. Copy environment file:
```bash
cp .env.example .env
```

4. Start PostgreSQL (using Docker):
```bash
make docker-up
```

5. Run migrations:
```bash
make migrate-up
```

6. Start the server:
```bash
make run
```

The API will be available at `http://localhost:8080`

## Available Commands

```bash
make run           # Run the server
make build         # Build binary
make test          # Run tests
make migrate-up    # Run migrations
make migrate-down  # Rollback migrations
make docker-up     # Start Docker containers
make docker-down   # Stop Docker containers
make deps          # Install dependencies
```

## API Documentation

### Base URL
```
http://localhost:8080/api/v1
```

### Authentication Endpoints

#### Register User
```http
POST /auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123",
  "username": "johndoe"
}
```

**Response:**
```json
{
  "user": {
    "id": "uuid",
    "email": "user@example.com",
    "username": "johndoe",
    "created_at": "2025-01-08T10:00:00Z"
  },
  "access_token": "eyJhbGc...",
  "refresh_token": "eyJhbGc..."
}
```

#### Login
```http
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response:** Same as register

### Sync Endpoints (Authenticated)

All sync endpoints require `Authorization: Bearer <token>` header.

#### Full Sync (Push + Pull)
```http
POST /sync
Authorization: Bearer <token>
Content-Type: application/json

{
  "device_id": "device-001",
  "last_sync_timestamp": "2025-01-08T10:00:00Z",
  "notes": [...],
  "progress": {...},
  "transactions": [...]
}
```

**Response:**
```json
{
  "notes": [...],
  "progress": {...},
  "transactions": [...],
  "conflicts": [],
  "synced_at": "2025-01-08T10:30:00Z"
}
```

#### Pull Only
```http
GET /sync/pull?last_sync=2025-01-08T10:00:00Z
Authorization: Bearer <token>
```

#### Push Only
```http
POST /sync/push
Authorization: Bearer <token>
Content-Type: application/json

{
  "device_id": "device-001",
  "notes": [...],
  "progress": {...}
}
```

### Challenge Endpoints (Authenticated)

#### Get Random Challenge
```http
GET /challenges/random?type=math&difficulty=easy
Authorization: Bearer <token>
```

**Query Parameters:**
- `type`: `math`, `trivia`, `word_game`, `riddle`, `pattern`
- `difficulty`: `easy`, `medium`, `hard`

**Response:**
```json
{
  "id": 1,
  "type": "math",
  "difficulty": "easy",
  "question": "What is 5 + 7?",
  "options": ["12", "10", "14", "15"],
  "point_reward": 10,
  "xp_reward": 15,
  "time_limit": 60
}
```

#### Submit Answer
```http
POST /challenges/submit
Authorization: Bearer <token>
Content-Type: application/json

{
  "challenge_id": 1,
  "answer": "12"
}
```

**Response:**
```json
{
  "is_correct": true,
  "correct_answer": "12",
  "explanation": null,
  "points_earned": 10,
  "xp_earned": 15,
  "message": "Excellent work!"
}
```

## Database Schema

### Main Tables

- **users** - User accounts
- **user_progress** - Points, XP, level, stats
- **notes** - User notes with sync metadata
- **challenge_questions** - Challenge pool
- **challenge_history** - Completed challenges
- **point_transactions** - Point history
- **chaos_events** - Chaos system events
- **user_achievements** - Achievement progress
- **themes** - Theme definitions and unlocks

## Project Structure

```
apps/web-service/
├── cmd/server/          # Application entry point
├── internal/            # Private application code
│   ├── domain/          # Business logic
│   │   ├── user/        # User domain
│   │   ├── sync/        # Sync domain
│   │   └── challenge/   # Challenge domain
│   ├── infrastructure/  # External services
│   │   └── database/    # Database implementations
│   └── api/             # HTTP handlers
│       └── rest/        # REST API handlers
├── pkg/                 # Public libraries
│   ├── jwt/            # JWT utilities
│   └── crypto/         # Password hashing
├── migrations/          # Database migrations
├── config/             # Configuration
└── Makefile
```

## Environment Variables

```bash
# Server
PORT=8080
ENVIRONMENT=development
ALLOWED_ORIGINS=*

# Database
DB_HOST=localhost
DB_PORT=5432
DB_USER=postgres
DB_PASSWORD=postgres
DB_NAME=noteventure
DB_SSL_MODE=disable

# JWT
JWT_SECRET=your-secret-key
JWT_ACCESS_TTL=15m
JWT_REFRESH_TTL=7d
```

## Development

### Adding New Migrations

```bash
make migrate-create NAME=your_migration_name
```

This creates two files:
- `migrations/XXXXXX_your_migration_name.up.sql`
- `migrations/XXXXXX_your_migration_name.down.sql`

### Running Tests

```bash
make test
```

### Database Management

Access Adminer (database UI) at http://localhost:8081 when Docker is running.

**Credentials:**
- System: PostgreSQL
- Server: postgres
- Username: postgres
- Password: postgres
- Database: noteventure

## Deployment

### Railway (Recommended)

1. Install Railway CLI:
```bash
npm i -g @railway/cli
```

2. Login:
```bash
railway login
```

3. Initialize project:
```bash
railway init
```

4. Add PostgreSQL:
```bash
railway add postgres
```

5. Deploy:
```bash
railway up
```

### Manual Deployment

1. Build binary:
```bash
make build
```

2. Copy binary and migrations to server

3. Set environment variables

4. Run migrations:
```bash
./migrate -path ./migrations -database "postgres://..." up
```

5. Start server:
```bash
./bin/server
```

## API Testing

### Using cURL

```bash
# Register
curl -X POST http://localhost:8080/api/v1/auth/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'

# Login and save token
TOKEN=$(curl -X POST http://localhost:8080/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}' \
  | jq -r '.access_token')

# Get challenge
curl "http://localhost:8080/api/v1/challenges/random?type=math&difficulty=easy" \
  -H "Authorization: Bearer $TOKEN"

# Sync data
curl -X POST http://localhost:8080/api/v1/sync \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"device_id":"test-device","notes":[],"progress":null}'
```

## Monitoring

### Health Check

```bash
curl http://localhost:8080/health
```

**Response:**
```json
{
  "status": "ok",
  "service": "noteventure-api"
}
```

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

MIT

## Support

For issues and questions, please open an issue on GitHub.
