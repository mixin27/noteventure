import 'package:equatable/equatable.dart';

import '../../domain/entities/app_theme.dart';

sealed class ThemesState extends Equatable {
  const ThemesState();

  @override
  List<Object?> get props => [];
}

final class ThemesInitial extends ThemesState {}

class ThemesLoading extends ThemesState {}

final class ThemesLoaded extends ThemesState {
  final List<AppTheme> themes;
  final AppTheme? activeTheme;

  const ThemesLoaded(this.themes, this.activeTheme);

  int get totalThemes => themes.length;
  int get unlockedCount => themes.where((t) => t.isUnlocked).length;

  List<AppTheme> get unlocked => themes.where((t) => t.isUnlocked).toList();
  List<AppTheme> get locked => themes.where((t) => !t.isUnlocked).toList();

  @override
  List<Object?> get props => [themes, activeTheme];
}

final class ThemesError extends ThemesState {
  final String message;

  const ThemesError(this.message);

  @override
  List<Object?> get props => [message];
}

final class ThemeUnlocked extends ThemesState {
  final AppTheme theme;

  const ThemeUnlocked(this.theme);

  @override
  List<Object?> get props => [theme];
}
