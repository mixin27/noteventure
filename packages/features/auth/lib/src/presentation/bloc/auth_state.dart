import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_user.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {
  final bool isInitialCheck;

  const AuthLoading({this.isInitialCheck = false});

  @override
  List<Object?> get props => [isInitialCheck];
}

final class AuthAuthenticated extends AuthState {
  final AuthUser user;

  const AuthAuthenticated(this.user);

  @override
  List<Object?> get props => [user];
}

final class AuthUnauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

final class AuthActionInProgress extends AuthState {}
