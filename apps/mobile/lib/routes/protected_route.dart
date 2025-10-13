import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget child;

  const ProtectedRoute({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is AuthUnauthenticated) {
          // Redirect to login
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(RouteConstants.login);
          });
          return const SizedBox.shrink();
        }

        if (state is AuthAuthenticated) {
          return child;
        }

        return const Scaffold(
          body: Center(child: Text('Something went wrong')),
        );
      },
    );
  }
}
