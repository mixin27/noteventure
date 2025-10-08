import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthCheckStatusRequested extends AuthEvent {}

final class AuthRegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String? username;

  const AuthRegisterRequested({
    required this.email,
    required this.password,
    this.username,
  });

  @override
  List<Object?> get props => [email, password, username];
}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

final class AuthLogoutRequested extends AuthEvent {}
