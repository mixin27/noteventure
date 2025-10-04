import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:points/points.dart';
import 'package:ui/ui.dart' as ui;

import '../../domain/entities/app_theme.dart';
import '../bloc/themes_bloc.dart';
import '../bloc/themes_event.dart';

class ThemeCard extends StatelessWidget {
  final AppTheme theme;
  final bool isActive;

  const ThemeCard({super.key, required this.theme, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return ui.CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Color preview
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.primaryColorValue, theme.secondaryColorValue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(ui.AppSpacing.radiusMd),
            ),
            child: Stack(
              children: [
                if (isActive)
                  Positioned(
                    top: ui.AppSpacing.sm,
                    right: ui.AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: ui.AppSpacing.sm,
                        vertical: ui.AppSpacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          ui.AppSpacing.radiusSm,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            size: 16,
                            color: ui.AppColors.success,
                          ),
                          const SizedBox(width: ui.AppSpacing.xs),
                          Text(
                            'Active',
                            style: themeData.textTheme.bodySmall?.copyWith(
                              color: ui.AppColors.success,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (!theme.isUnlocked)
                  Positioned(
                    top: ui.AppSpacing.sm,
                    left: ui.AppSpacing.sm,
                    child: Container(
                      padding: const EdgeInsets.all(ui.AppSpacing.xs),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(
                          ui.AppSpacing.radiusSm,
                        ),
                      ),
                      child: const Icon(
                        Icons.lock,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                Center(
                  child: Icon(
                    Icons.palette,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: ui.AppSpacing.md),
          // Theme info
          Text(
            theme.name,
            style: themeData.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: ui.AppSpacing.xs),
          Text(
            theme.description,
            style: themeData.textTheme.bodyMedium?.copyWith(
              color: themeData.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: ui.AppSpacing.md),
          // Action button
          if (!theme.isUnlocked)
            BlocBuilder<PointsBloc, PointsState>(
              builder: (context, pointsState) {
                final hasEnoughPoints =
                    pointsState is PointsLoaded &&
                    pointsState.balance >= theme.unlockCost;

                return ui.CustomButton(
                  text: 'Unlock for ${theme.unlockCost} points',
                  onPressed: hasEnoughPoints
                      ? () {
                          context.read<ThemesBloc>().add(
                            UnlockThemeEvent(theme.themeKey),
                          );
                        }
                      : null,
                  fullWidth: true,
                  icon: const Icon(Icons.stars, size: ui.AppSpacing.iconSm),
                );
              },
            )
          else if (!isActive)
            ui.CustomButton(
              text: 'Apply Theme',
              onPressed: () {
                context.read<ThemesBloc>().add(
                  ActivateThemeEvent(theme.themeKey),
                );
              },
              fullWidth: true,
              icon: const Icon(Icons.brush, size: ui.AppSpacing.iconSm),
            )
          else
            ui.CustomButton(
              text: 'Currently Active',
              onPressed: null,
              fullWidth: true,
              variant: ui.ButtonVariant.outlined,
            ),
        ],
      ),
    );
  }
}
