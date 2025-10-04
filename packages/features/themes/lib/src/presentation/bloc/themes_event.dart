import 'package:equatable/equatable.dart';

import '../../domain/entities/app_theme.dart';

sealed class ThemesEvent extends Equatable {
  const ThemesEvent();

  @override
  List<Object?> get props => [];
}

final class LoadThemes extends ThemesEvent {}

final class LoadUnlockedThemes extends ThemesEvent {}

final class UnlockThemeEvent extends ThemesEvent {
  final String themeKey;
  const UnlockThemeEvent(this.themeKey);

  @override
  List<Object?> get props => [themeKey];
}

final class ActivateThemeEvent extends ThemesEvent {
  final String themeKey;
  const ActivateThemeEvent(this.themeKey);

  @override
  List<Object?> get props => [themeKey];
}

final class InitializeThemesEvent extends ThemesEvent {}

final class ThemesUpdated extends ThemesEvent {
  final List<AppTheme> themes;
  const ThemesUpdated(this.themes);

  @override
  List<Object?> get props => [themes];
}
