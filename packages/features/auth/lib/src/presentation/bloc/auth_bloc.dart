import 'package:bloc/bloc.dart';
import 'package:core/core.dart';

import '../../domain/usecases/check_auth_status.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/register.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Register register;
  final Login login;
  final Logout logout;
  final CheckAuthStatus checkAuthStatus;
  final GetCurrentUser getCurrentUser;

  AuthBloc({
    required this.register,
    required this.login,
    required this.logout,
    required this.checkAuthStatus,
    required this.getCurrentUser,
  }) : super(AuthInitial()) {
    on<AuthCheckStatusRequested>(_onCheckStatusRequested);
    on<AuthRegisterRequested>(_onRegisterRequested);
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onCheckStatusRequested(
    AuthCheckStatusRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading(isInitialCheck: true));

    final statusResult = await checkAuthStatus();

    // Handle the result properly without async in fold
    final isAuthenticated = statusResult.fold(
      (failure) => false,
      (authenticated) => authenticated,
    );

    if (!isAuthenticated) {
      emit(AuthUnauthenticated());
      return;
    }

    // Get user data if authenticated
    final userResult = await getCurrentUser();

    userResult.fold((failure) => emit(AuthUnauthenticated()), (user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> _onRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthActionInProgress());

    final params = RegisterParams(
      email: event.email,
      password: event.password,
      username: event.username,
    );

    final result = await register(params);

    result.fold((failure) => emit(AuthError(failure.message)), (user) {
      AudioManager().playSuccess();

      // Emit event to EventBus
      AppEventBus().emit(
        PointsChangedEvent(
          newBalance: 100, // Starting points
          change: 100,
          reason: 'user_registration',
        ),
      );

      emit(AuthAuthenticated(user));
    });
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthActionInProgress());

    final params = LoginParams(email: event.email, password: event.password);

    final result = await login(params);

    result.fold((failure) => emit(AuthError(failure.message)), (user) {
      AudioManager().playSuccess();
      emit(AuthAuthenticated(user));
    });
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthActionInProgress());

    final result = await logout();

    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthUnauthenticated()),
    );
  }
}
