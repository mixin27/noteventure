library;

// Domain
export 'src/domain/repositories/background_sync_repository.dart';
export 'src/domain/usecases/initialize_background_sync.dart';
export 'src/domain/usecases/trigger_immediate_sync.dart';
export 'src/domain/usecases/cancel_background_sync.dart';
export 'src/domain/usecases/update_sync_frequency.dart';

// Presentation - BLoC
export 'src/presentation/bloc/background_sync_bloc.dart';
export 'src/presentation/bloc/background_sync_event.dart';
export 'src/presentation/bloc/background_sync_state.dart';

// Presentation - Widgets
export 'src/presentation/widgets/sync_status_widget.dart';
export 'src/presentation/widgets/sync_settings_widget.dart';

// Callback (must be top-level, exported for main.dart)
export 'src/callback/sync_callback_dispatcher.dart';

// DI
export 'src/di/background_sync_injection.dart';
