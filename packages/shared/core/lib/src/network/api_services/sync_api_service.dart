import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../converters/date_time_converter.dart';

part 'sync_api_service.g.dart';

@RestApi()
abstract class SyncApiService {
  factory SyncApiService(Dio dio, {String baseUrl}) = _SyncApiService;

  @POST('/sync')
  Future<SyncResponse> sync(@Body() SyncRequest request);

  @GET('/sync/pull')
  Future<SyncResponse> pull(@Query('last_sync') String? lastSync);

  @POST('/sync/push')
  Future<SyncPushResponse> push(@Body() SyncRequest request);
}

// ============================================================================
// Request Models
// ============================================================================

@JsonSerializable(explicitToJson: true)
class SyncRequest {
  @JsonKey(name: 'device_id')
  final String deviceId;

  @NullableDateTimeConverter()
  @JsonKey(name: 'last_sync')
  final DateTime? lastSyncTimestamp;

  final List<NoteSyncDto>? notes;
  final ProgressSyncDto? progress;
  final List<TransactionSyncDto>? transactions;

  SyncRequest({
    required this.deviceId,
    this.lastSyncTimestamp,
    this.notes,
    this.progress,
    this.transactions,
  });

  factory SyncRequest.fromJson(Map<String, dynamic> json) =>
      _$SyncRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SyncRequestToJson(this);
}

// ============================================================================
// Response Models
// ============================================================================

@JsonSerializable(explicitToJson: true)
class SyncResponse {
  @JsonKey(name: 'notes', defaultValue: [])
  final List<NoteSyncDto> notes;
  final ProgressSyncDto? progress;
  @JsonKey(name: 'transactions', defaultValue: [])
  final List<TransactionSyncDto> transactions;
  @JsonKey(name: 'conflicts', defaultValue: [])
  final List<ConflictDto> conflicts;

  @DateTimeConverter()
  @JsonKey(name: 'synced_at')
  final DateTime syncedAt;

  SyncResponse({
    this.notes = const [],
    this.progress,
    this.transactions = const [],
    this.conflicts = const [],
    required this.syncedAt,
  });

  factory SyncResponse.fromJson(Map<String, dynamic> json) =>
      _$SyncResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SyncResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SyncPushResponse {
  final String message;

  @DateTimeConverter()
  @JsonKey(name: 'synced_at')
  final DateTime syncedAt;

  SyncPushResponse({required this.message, required this.syncedAt});

  factory SyncPushResponse.fromJson(Map<String, dynamic> json) =>
      _$SyncPushResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SyncPushResponseToJson(this);
}

// ============================================================================
// Data Transfer Objects
// ============================================================================

@JsonSerializable(explicitToJson: true)
class NoteSyncDto {
  final String id;
  final String title;
  final String content;

  @JsonKey(name: 'note_type')
  final String noteType;

  @JsonKey(name: 'is_locked')
  final bool isLocked;

  @NullableDateTimeConverter()
  @JsonKey(name: 'unlock_date')
  final DateTime? unlockDate;

  @JsonKey(name: 'category_id')
  final String? categoryId;

  @JsonKey(name: 'sort_order')
  final int sortOrder;

  final String? color;

  @JsonKey(name: 'is_pinned')
  final bool isPinned;

  @JsonKey(name: 'is_favorite')
  final bool isFavorite;

  @JsonKey(name: 'required_challenge_level')
  final int? requiredChallengeLevel;

  @JsonKey(name: 'is_deleted')
  final bool isDeleted;

  @NullableDateTimeConverter()
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;

  @JsonKey(name: 'edit_count')
  final int editCount;

  @DateTimeConverter()
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @DateTimeConverter()
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(name: 'device_id')
  final String deviceId;

  final int version;

  NoteSyncDto({
    required this.id,
    required this.title,
    required this.content,
    required this.noteType,
    required this.isLocked,
    this.unlockDate,
    this.categoryId,
    required this.sortOrder,
    this.color,
    required this.isPinned,
    required this.isFavorite,
    this.requiredChallengeLevel,
    required this.isDeleted,
    this.deletedAt,
    required this.editCount,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    required this.version,
  });

  factory NoteSyncDto.fromJson(Map<String, dynamic> json) =>
      _$NoteSyncDtoFromJson(json);

  Map<String, dynamic> toJson() => _$NoteSyncDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProgressSyncDto {
  @JsonKey(name: 'total_points')
  final int totalPoints;

  @JsonKey(name: 'lifetime_points_earned')
  final int lifetimePointsEarned;

  @JsonKey(name: 'lifetime_points_spent')
  final int lifetimePointsSpent;

  final int level;

  @JsonKey(name: 'current_xp')
  final int currentXp;

  @JsonKey(name: 'xp_to_next_level')
  final int xpToNextLevel;

  @JsonKey(name: 'current_streak')
  final int currentStreak;

  @JsonKey(name: 'longest_streak')
  final int longestStreak;

  @NullableDateTimeConverter()
  @JsonKey(name: 'last_challenge_date')
  final DateTime? lastChallengeDate;

  @JsonKey(name: 'total_challenges_solved')
  final int totalChallengesSolved;

  @JsonKey(name: 'total_challenges_failed')
  final int totalChallengesFailed;

  @JsonKey(name: 'total_notes_created')
  final int totalNotesCreated;

  @JsonKey(name: 'total_notes_deleted')
  final int totalNotesDeleted;

  @JsonKey(name: 'chaos_enabled')
  final bool chaosEnabled;

  @JsonKey(name: 'challenge_time_limit')
  final int challengeTimeLimit;

  @JsonKey(name: 'personality_tone')
  final String personalityTone;

  @JsonKey(name: 'sound_enabled')
  final bool soundEnabled;

  @JsonKey(name: 'notifications_enabled')
  final bool notificationsEnabled;

  @DateTimeConverter()
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  ProgressSyncDto({
    required this.totalPoints,
    required this.lifetimePointsEarned,
    required this.lifetimePointsSpent,
    required this.level,
    required this.currentXp,
    required this.xpToNextLevel,
    required this.currentStreak,
    required this.longestStreak,
    this.lastChallengeDate,
    required this.totalChallengesSolved,
    required this.totalChallengesFailed,
    required this.totalNotesCreated,
    required this.totalNotesDeleted,
    required this.chaosEnabled,
    required this.challengeTimeLimit,
    required this.personalityTone,
    required this.soundEnabled,
    required this.notificationsEnabled,
    required this.updatedAt,
  });

  factory ProgressSyncDto.fromJson(Map<String, dynamic> json) =>
      _$ProgressSyncDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressSyncDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TransactionSyncDto {
  final String id;
  final int amount;
  final String reason;
  final String? description;

  @JsonKey(name: 'related_note_id')
  final String? relatedNoteId;

  @JsonKey(name: 'related_challenge_id')
  final String? relatedChallengeId;

  @JsonKey(name: 'related_event_id')
  final String? relatedEventId;

  @JsonKey(name: 'balance_after')
  final int balanceAfter;

  @DateTimeConverter()
  final DateTime timestamp;

  TransactionSyncDto({
    required this.id,
    required this.amount,
    required this.reason,
    this.description,
    this.relatedNoteId,
    this.relatedChallengeId,
    this.relatedEventId,
    required this.balanceAfter,
    required this.timestamp,
  });

  factory TransactionSyncDto.fromJson(Map<String, dynamic> json) =>
      _$TransactionSyncDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionSyncDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ConflictDto {
  @JsonKey(name: 'entity_type')
  final String entityType;

  @JsonKey(name: 'entity_id')
  final String entityId;

  final String reason;

  @JsonKey(name: 'server_data')
  final Map<String, dynamic>? serverData;

  @JsonKey(name: 'client_data')
  final Map<String, dynamic>? clientData;

  ConflictDto({
    required this.entityType,
    required this.entityId,
    required this.reason,
    this.serverData,
    this.clientData,
  });

  factory ConflictDto.fromJson(Map<String, dynamic> json) =>
      _$ConflictDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConflictDtoToJson(this);
}
