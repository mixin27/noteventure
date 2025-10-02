import 'package:equatable/equatable.dart';

import '../../domain/entities/app_settings.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadSettings extends SettingsEvent {}

final class UpdateSoundEnabled extends SettingsEvent {
  final bool enabled;
  const UpdateSoundEnabled(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

final class UpdateNotificationsEnabled extends SettingsEvent {
  final bool enabled;
  const UpdateNotificationsEnabled(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

final class UpdateChaosEnabled extends SettingsEvent {
  final bool enabled;
  const UpdateChaosEnabled(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

final class UpdateChallengeTimeLimit extends SettingsEvent {
  final int seconds;
  const UpdateChallengeTimeLimit(this.seconds);

  @override
  List<Object?> get props => [seconds];
}

final class UpdatePersonalityTone extends SettingsEvent {
  final String tone;
  const UpdatePersonalityTone(this.tone);

  @override
  List<Object?> get props => [tone];
}

final class UpdateHapticFeedback extends SettingsEvent {
  final bool enabled;
  const UpdateHapticFeedback(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

final class UpdateThemeMode extends SettingsEvent {
  final String mode;
  const UpdateThemeMode(this.mode);

  @override
  List<Object?> get props => [mode];
}

final class UpdateProfanityFilter extends SettingsEvent {
  final bool enabled;
  const UpdateProfanityFilter(this.enabled);

  @override
  List<Object?> get props => [enabled];
}

final class ResetAllSettings extends SettingsEvent {}

final class SettingsUpdated extends SettingsEvent {
  final AppSettings settings;
  const SettingsUpdated(this.settings);

  @override
  List<Object?> get props => [settings];
}
