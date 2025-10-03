import '../entities/achievement.dart';
import '../repositories/achievements_repository.dart';

class WatchAchievements {
  final AchievementsRepository repository;

  WatchAchievements(this.repository);

  Stream<List<Achievement>> call() {
    return repository.watchAchievements();
  }
}
