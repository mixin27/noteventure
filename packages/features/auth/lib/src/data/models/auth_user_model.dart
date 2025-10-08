import 'package:core/core.dart';

import '../../domain/entities/auth_user.dart';

class AuthUserModel extends AuthUser {
  const AuthUserModel({
    required super.id,
    required super.email,
    required super.accessToken,
    required super.refreshToken,
    required super.createdAt,
    super.username,
    required super.updatedAt,
    required super.isActive,
  });

  factory AuthUserModel.fromApi(AuthResponse response) {
    return AuthUserModel(
      id: response.user.id,
      email: response.user.email,
      username: response.user.username,
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
      createdAt: response.user.createdAt,
      updatedAt: response.user.updatedAt,
      isActive: response.user.isActive,
    );
  }

  // For creating from stored data
  factory AuthUserModel.fromStorage({
    required String id,
    required String email,
    String? username,
    required String accessToken,
    required String refreshToken,
    required DateTime createdAt,
    required DateTime updatedAt,
    required bool isActive,
  }) {
    return AuthUserModel(
      id: id,
      email: email,
      username: username,
      accessToken: accessToken,
      refreshToken: refreshToken,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isActive: isActive,
    );
  }

  AuthUser toEntity() {
    return AuthUser(
      id: id,
      email: email,
      username: username,
      accessToken: accessToken,
      refreshToken: refreshToken,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isActive: isActive,
    );
  }
}
