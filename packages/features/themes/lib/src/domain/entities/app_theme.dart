
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppTheme extends Equatable {
  final int id;
  final String themeKey;
  final String name;
  final String description;
  final int unlockCost;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final bool isActive;
  final String primaryColor;
  final String secondaryColor;
  final String backgroundColor;
  final String surfaceColor;
  final String themeStyle; // light, dark, custom

  const AppTheme({
    required this.id,
    required this.themeKey,
    required this.name,
    required this.description,
    required this.unlockCost,
    required this.isUnlocked,
    this.unlockedAt,
    required this.isActive,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.surfaceColor,
    required this.themeStyle,
  });

  Color get primaryColorValue => Color(int.parse(primaryColor.substring(1), radix: 16) + 0xFF000000);
  Color get secondaryColorValue => Color(int.parse(secondaryColor.substring(1), radix: 16) + 0xFF000000);
  Color get backgroundColorValue => Color(int.parse(backgroundColor.substring(1), radix: 16) + 0xFF000000);
  Color get surfaceColorValue => Color(int.parse(surfaceColor.substring(1), radix: 16) + 0xFF000000);

  AppTheme copyWith({
    int? id,
    String? themeKey,
    String? name,
    String? description,
    int? unlockCost,
    bool? isUnlocked,
    DateTime? unlockedAt,
    bool? isActive,
    String? primaryColor,
    String? secondaryColor,
    String? backgroundColor,
    String? surfaceColor,
    String? themeStyle,
  }) {
    return AppTheme(
      id: id ?? this.id,
      themeKey: themeKey ?? this.themeKey,
      name: name ?? this.name,
      description: description ?? this.description,
      unlockCost: unlockCost ?? this.unlockCost,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      isActive: isActive ?? this.isActive,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      themeStyle: themeStyle ?? this.themeStyle,
    );
  }

  @override
  List<Object?> get props => [
        id,
        themeKey,
        name,
        description,
        unlockCost,
        isUnlocked,
        unlockedAt,
        isActive,
        primaryColor,
        secondaryColor,
        backgroundColor,
        surfaceColor,
        themeStyle,
      ];
}
