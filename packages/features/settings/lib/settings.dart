library;

export 'src/data/datasources/settings_local_datasource.dart';
export 'src/data/repositories/settings_repository_impl.dart';

// Domain - Repositories
export 'src/domain/repositories/settings_repository.dart';

// Domain - Entities
export 'src/domain/entities/app_settings.dart';
export 'src/domain/usecases/watch_settings.dart';

// Presentation - BLoC
export 'src/presentation/bloc/settings_bloc.dart';
export 'src/presentation/bloc/settings_event.dart';
export 'src/presentation/bloc/settings_state.dart';

// Presentation - Pages
export 'src/presentation/pages/settings_page.dart';
export 'src/presentation/pages/sync_settings_page.dart';

// DI
export 'src/di/settings_injection.dart' hide getIt;
