library;

// Constants
export 'src/constants/app_constants.dart';
export 'src/constants/point_costs.dart';
export 'src/constants/challenge_config.dart';

// Errors
export 'src/errors/failures.dart';
export 'src/errors/exceptions.dart';

// Extensions
export 'src/extensions/date_time_extensions.dart';
export 'src/extensions/string_extensions.dart';
export 'src/extensions/int_extensions.dart';

// Utils
export 'src/utils/event_bus.dart';
export 'src/utils/difficulty_calculator.dart';
export 'src/utils/xp_calculator.dart';
export 'src/utils/message_generator.dart';
export 'src/utils/audio_manager.dart';
export 'src/utils/device_info_helper.dart';

// Network exports
export 'src/network/api_config.dart';
export 'src/network/dio_client.dart';
export 'src/network/api_response.dart';
export 'src/network/api_exception.dart';
export 'src/network/api_services/auth_api_service.dart';
export 'src/network/api_services/sync_api_service.dart';

// Storage exports
export 'src/storage/token_storage.dart';
export 'src/storage/user_storage.dart';

export 'src/di/core_injection.dart' hide getIt;
