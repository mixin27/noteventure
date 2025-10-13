import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'background_sync_injection.config.dart';

final getItBackgroundSync = GetIt.instance;

@InjectableInit(
  initializerName: 'initBackgroundSync',
  preferRelativeImports: true,
  asExtension: true,
)
void configureBackgroundSyncDependencies() =>
    getItBackgroundSync.initBackgroundSync();
