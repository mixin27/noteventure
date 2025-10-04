import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart' as ui;

import '../../domain/entities/app_theme.dart';
import '../bloc/themes_bloc.dart';
import '../bloc/themes_event.dart';
import '../bloc/themes_state.dart';
import '../widgets/themes_view.dart';

class ThemesPage extends StatelessWidget {
  const ThemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ThemesBloc, ThemesState>(
      listener: (context, state) {
        if (state is ThemeUnlocked) {
          _showUnlockSuccessDialog(context, state.theme);
        } else if (state is ThemesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: ui.AppColors.error,
            ),
          );
        }
      },
      child: const ThemesView(),
    );
  }

  void _showUnlockSuccessDialog(BuildContext context, AppTheme theme) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ui.BounceAnimation(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.primaryColorValue,
                ),
                child: const Icon(Icons.palette, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: ui.AppSpacing.lg),
            Text(
              'Theme Unlocked!',
              style: Theme.of(
                dialogContext,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Text(
              theme.name,
              style: Theme.of(dialogContext).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColorValue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ui.AppSpacing.sm),
            Text(
              theme.description,
              style: Theme.of(dialogContext).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ui.CustomButton(
                  text: 'Apply Now',
                  onPressed: () {
                    context.read<ThemesBloc>().add(
                      ActivateThemeEvent(theme.themeKey),
                    );
                    Navigator.of(dialogContext).pop();
                  },
                ),
              ),
              const SizedBox(width: ui.AppSpacing.md),
              Expanded(
                child: ui.CustomButton(
                  text: 'Later',
                  variant: ui.ButtonVariant.outlined,
                  onPressed: () => Navigator.of(dialogContext).pop(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
