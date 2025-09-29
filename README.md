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
