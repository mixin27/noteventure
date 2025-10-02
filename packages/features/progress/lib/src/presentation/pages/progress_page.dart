import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../bloc/progress_bloc.dart';
import '../bloc/progress_state.dart';
import '../widgets/progress_view.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProgressBloc, ProgressState>(
      listener: (context, state) {
        if (state is ProgressLeveledUp) {
          _showLevelUpDialog(context, state.oldLevel, state.newLevel);
        }
      },
      child: const ProgressView(),
    );
  }

  void _showLevelUpDialog(BuildContext context, int oldLevel, int newLevel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BounceAnimation(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: AppColors.primaryGradient,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$newLevel',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Level Up!',
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              MessageGenerator.getLevelUpMessage(newLevel),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          CustomButton(
            text: 'Awesome!',
            onPressed: () => Navigator.of(dialogContext).pop(),
            fullWidth: true,
          ),
        ],
      ),
    );
  }
}
