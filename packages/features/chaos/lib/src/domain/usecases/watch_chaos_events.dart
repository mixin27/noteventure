import '../entities/chaos_event_entity.dart';
import '../repositories/chaos_repository.dart';

class WatchChaosEvents {
  final ChaosRepository repository;
  WatchChaosEvents(this.repository);

  Stream<List<ChaosEventEntity>> call() {
    return repository.watchEvents();
  }
}
