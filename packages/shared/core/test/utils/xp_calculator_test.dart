import 'package:flutter_test/flutter_test.dart';
import 'package:core/core.dart';

void main() {
  group('XpCalculator', () {
    test('calculates XP required for level correctly', () {
      expect(XpCalculator.xpRequiredForLevel(1), 0);
      expect(XpCalculator.xpRequiredForLevel(2), 100);
      expect(XpCalculator.xpRequiredForLevel(3), greaterThan(100));
    });

    test('calculates level from total XP correctly', () {
      expect(XpCalculator.calculateLevel(0), 1);
      expect(XpCalculator.calculateLevel(50), 1);
      expect(XpCalculator.calculateLevel(100), 2);
    });

    test('detects level up correctly', () {
      expect(XpCalculator.willLevelUp(90, 20), true);
      expect(XpCalculator.willLevelUp(50, 20), false);
    });

    test('calculates progress correctly', () {
      final progress = XpCalculator.calculateProgress(50);
      expect(progress['currentLevel'], 1);
      expect(progress['currentXp'], 50);
      expect(progress['progressPercentage'], greaterThan(0));
    });
  });
}
