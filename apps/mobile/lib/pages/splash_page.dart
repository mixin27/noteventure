import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ui/ui.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Add a small delay for splash screen
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      context.go(RouteConstants.home);
    } else {
      context.go(RouteConstants.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.primaryGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInAnimation(
                child: ScaleAnimation(
                  child: Icon(
                    Icons.note_alt_outlined,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              FadeInAnimation(
                delay: const Duration(milliseconds: 300),
                child: Text(
                  'Noteventure',
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              FadeInAnimation(
                delay: const Duration(milliseconds: 500),
                child: Text(
                  'Your gamified notes app',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              // Loading Indicator
              LoadingIndicator(color: Theme.of(context).colorScheme.onPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
