# Useful commands

```bash
# Get dependencies for all packages (from root)
dart pub get
# or
flutter pub get

# Run the mobile app
cd apps/mobile
flutter run

# Run build_runner for specific package
cd packages/shared/database
dart run build_runner build --delete-conflicting-outputs

# Watch mode
dart run build_runner watch --delete-conflicting-outputs

# Run tests
dart test

# Analyze all packages
flutter analyze

# Format code
dart format .

# Clean
flutter clean
```
