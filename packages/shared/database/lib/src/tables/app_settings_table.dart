import 'package:drift/drift.dart';

/// Table for storing app-wide settings as key-value pairs.
///
/// Settings are stored as strings and parsed to appropriate types
/// when retrieved. This allows flexible storage of various setting types
/// without needing separate columns for each setting.
///
/// Common setting keys:
/// - sound_enabled: bool
/// - notifications_enabled: bool
/// - chaos_enabled: bool
/// - challenge_time_limit: int (seconds)
/// - personality_tone: string (random/sarcastic/wholesome/chaotic/deadpan)
/// - haptic_feedback_enabled: bool
/// - theme_mode: string (light/dark/system)
/// - show_tutorial: bool
/// - profanity_filter: bool
@DataClassName('AppSettingsData')
class AppSettings extends Table {
  /// Primary key
  IntColumn get id => integer().autoIncrement()();

  /// Setting key (e.g., 'sound_enabled', 'theme_mode')
  /// Must be unique to prevent duplicate settings
  TextColumn get settingKey => text().unique()();

  /// Setting value stored as string
  /// Will be parsed to appropriate type when retrieved:
  /// - 'true'/'false' for booleans
  /// - '30' for integers
  /// - 'random' for strings
  TextColumn get settingValue => text()();

  /// Timestamp of last update
  /// Useful for sync, debugging, and audit purposes
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
