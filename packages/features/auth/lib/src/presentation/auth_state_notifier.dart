import 'package:flutter/material.dart';

import 'bloc/auth_state.dart';

class AuthStateNotifier extends ChangeNotifier {
  AuthState? _authState;

  AuthState? get authState => _authState;

  bool get isAuthenticated => _authState is AuthAuthenticated;
  bool get isInitialLoading =>
      _authState is AuthLoading && (_authState as AuthLoading).isInitialCheck;
  bool get isActionInProgress => _authState is AuthActionInProgress;
  bool get isUnauthenticated => _authState is AuthUnauthenticated;

  void updateAuthState(AuthState state) {
    _authState = state;
    notifyListeners();
  }
}
