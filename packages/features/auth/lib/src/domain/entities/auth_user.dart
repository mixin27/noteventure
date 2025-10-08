import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String email;
  final String? username;
  final String accessToken;
  final String refreshToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  const AuthUser({
    required this.id,
    required this.email,
    this.username,
    required this.accessToken,
    required this.refreshToken,
    required this.createdAt,
    required this.updatedAt,
    required this.isActive,
  });

  @override
  List<Object?> get props => [
    id,
    email,
    username,
    accessToken,
    refreshToken,
    createdAt,
    updatedAt,
    isActive,
  ];
}
