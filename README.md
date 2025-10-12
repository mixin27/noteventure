# Noteventure

A gamified notes app where every action costs points earned by solving challenges.

## Project Structure

This is a monorepo using Dart's native workspace feature.

- `apps/mobile` - Main Flutter application
- `packages/shared/` - Shared packages (core, ui, database)
- `packages/features/` - Feature modules (notes, challenges, points, etc.)

## Getting Started

### Prerequisites

- Flutter SDK >= 3.5.0
- Dart SDK >= 3.5.0

### Setup

1. Clone the repository
2. Run `flutter pub get` from the root directory
3. Navigate to `apps/mobile` and run `flutter run`

### Development Commands

```bash
# Get dependencies for all packages
flutter pub get

# Run the mobile app
cd apps/mobile && flutter run

# Run build_runner (for code generation)
cd packages/shared/database
dart run build_runner build --delete-conflicting-outputs

# Run tests
dart test

# Format code
dart format .

# Analyze code
flutter analyze
```

### Architecture

- **Architecture Pattern:** Clean Architecture with Feature-Based structure
- **State Management:** BLoC (flutter_bloc)
- **Database:** Drift (SQLite)
- **Navigation:** go_router
- **Dependency Injection:** get_it + injectable
- **Communication:** Event Bus pattern for loose coupling between features

### Features

- Notes management with point-based economy
- Challenge system (math, trivia, word games, patterns)
- Progression system with XP and levels
- Achievements tracking
- Chaos events for unpredictability
- Unlockable themes
- Audio feedback
- Daily challenges

### License

This project is for personal use and learning purposes.

```bash
[log] [SYNC] Received 4 notes from server
[log] [SYNC] Processing note: d4b43d74-4165-4766-87b4-fe4a8bb80b42 - My First Note
[log] [SYNC]   UpdatedAt: 2025-10-10 11:16:12.000Z
[log] [SYNC]   Note d4b43d74-4165-4766-87b4-fe4a8bb80b42 NOT found locally
[log] [SYNC]   Checking by serverUuid: d4b43d74-4165-4766-87b4-fe4a8bb80b42
[log] [SYNC]   INSERTING new note from server
[log] [SYNC]   Successfully inserted
[log] [SYNC] Processing note: c6b7bc09-b396-4a99-b63c-241953b8b4c3 - My First Note
[log] [SYNC]   UpdatedAt: 2025-10-11 08:57:21.000Z
[log] [SYNC]   Note c6b7bc09-b396-4a99-b63c-241953b8b4c3 FOUND locally
[log] [SYNC]   Local updatedAt: 2025-10-11 15:27:21.000
[log] [SYNC]   Server updatedAt: 2025-10-11 08:57:21.000Z
[log] [SYNC]   Timestamps are EQUAL - SKIPPING update
[log] [SYNC] Processing note: bf7498ae-2abd-4319-9ec6-8fe0c8eb0647 - My First Note
[log] [SYNC]   UpdatedAt: 2025-10-11 08:57:43.000Z
[log] [SYNC]   Note bf7498ae-2abd-4319-9ec6-8fe0c8eb0647 FOUND locally
[log] [SYNC]   Local updatedAt: 2025-10-11 15:27:43.000
[log] [SYNC]   Server updatedAt: 2025-10-11 08:57:43.000Z
[log] [SYNC]   Timestamps are EQUAL - SKIPPING update
[log] [SYNC] Processing note: 40eda93a-4c34-472b-911e-fff56cd78914 - My First Note
[log] [SYNC]   UpdatedAt: 2025-10-11 09:04:47.000Z
[log] [SYNC]   Note 40eda93a-4c34-472b-911e-fff56cd78914 FOUND locally
[log] [SYNC]   Local updatedAt: 2025-10-11 15:34:47.000
[log] [SYNC]   Server updatedAt: 2025-10-11 09:04:47.000Z
[log] [SYNC]   Timestamps are EQUAL - SKIPPING update
[log] [SYNC] Finished processing all notes from server
```
