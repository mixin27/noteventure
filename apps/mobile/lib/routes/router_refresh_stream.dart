import 'package:auth/auth.dart';
import 'package:flutter/material.dart';

class RouterRefreshStream extends ChangeNotifier {
  final AuthStateNotifier authStateNotifier;

  RouterRefreshStream(this.authStateNotifier) {
    authStateNotifier.addListener(notifyListeners);
  }

  @override
  void dispose() {
    authStateNotifier.removeListener(notifyListeners);
    super.dispose();
  }
}
