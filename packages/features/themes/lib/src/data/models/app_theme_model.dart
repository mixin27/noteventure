import 'package:database/database.dart';

import '../../domain/entities/app_theme.dart';

class AppThemeModel extends AppTheme {
  const AppThemeModel({
    required super.id,
    required super.themeKey,
    required super.name,
    required super.description,
    required super.unlockCost,
    required super.isUnlocked,
    super.unlockedAt,
    required super.isActive,
    required super.primaryColor,
    required super.secondaryColor,
    required super.backgroundColor,
    required super.surfaceColor,
    required super.themeStyle,
  });

  factory AppThemeModel.fromDrift(Theme data) {
    return AppThemeModel(
      id: data.id,
      themeKey: data.themeKey,
      name: data.name,
      description: data.description,
      unlockCost: data.unlockCost,
      isUnlocked: data.isUnlocked,
      unlockedAt: data.unlockedAt,
      isActive: data.isActive,
      primaryColor: data.primaryColor,
      secondaryColor: data.secondaryColor,
      backgroundColor: data.backgroundColor,
      surfaceColor: data.surfaceColor,
      themeStyle: data.themeStyle,
    );
  }

  AppTheme toEntity() {
    return AppTheme(
      id: id,
      themeKey: themeKey,
      name: name,
      description: description,
      unlockCost: unlockCost,
      isUnlocked: isUnlocked,
      unlockedAt: unlockedAt,
      isActive: isActive,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      backgroundColor: backgroundColor,
      surfaceColor: surfaceColor,
      themeStyle: themeStyle,
    );
  }
}
