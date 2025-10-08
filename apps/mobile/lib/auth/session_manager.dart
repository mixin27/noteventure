import 'dart:async';

import 'package:auth/auth.dart';

class SessionManager {
  static const Duration _sessionTimeout = Duration(minutes: 30);

  Timer? _sessionTimer;
  final AuthBloc authBloc;

  SessionManager(this.authBloc);

  void startSession() {
    _resetTimer();
  }

  void resetSession() {
    _resetTimer();
  }

  void endSession() {
    _sessionTimer?.cancel();
    authBloc.add(AuthLogoutRequested());
  }

  void _resetTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = Timer(_sessionTimeout, () {
      endSession();
    });
  }

  void dispose() {
    _sessionTimer?.cancel();
  }
}
