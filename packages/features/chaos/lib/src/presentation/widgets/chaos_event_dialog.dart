import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../domain/entities/chaos_event_entity.dart';

class ChaosEventDialog extends StatelessWidget {
  final ChaosEventEntity event;

  const ChaosEventDialog({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _getGradientColors(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with animation
            BounceAnimation(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: Icon(_getEventIcon(), size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Event type badge
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Text(
                event.eventType.displayName.toUpperCase(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),

            // Title
            Text(
              event.title,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),

            // Message
            Text(
              event.message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.white.withValues(alpha: 0.9),
              ),
              textAlign: TextAlign.center,
            ),

            // Points awarded (if any)
            if (event.pointsAwarded > 0) ...[
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.stars, color: Colors.white, size: 24),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      '+${event.pointsAwarded} Points',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: AppSpacing.lg),

            // Close button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: _getPrimaryColor(),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                ),
                child: Text(
                  _getButtonText(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _getGradientColors() {
    switch (event.eventType) {
      case ChaosEventType.positive:
        return AppColors.successGradient;
      case ChaosEventType.negative:
        return [AppColors.error, AppColors.errorDark];
      case ChaosEventType.neutral:
        return [AppColors.info, AppColors.secondary];
    }
  }

  IconData _getEventIcon() {
    switch (event.eventType) {
      case ChaosEventType.positive:
        return Icons.celebration;
      case ChaosEventType.negative:
        return Icons.warning_amber;
      case ChaosEventType.neutral:
        return Icons.info_outline;
    }
  }

  Color _getPrimaryColor() {
    switch (event.eventType) {
      case ChaosEventType.positive:
        return AppColors.success;
      case ChaosEventType.negative:
        return AppColors.error;
      case ChaosEventType.neutral:
        return AppColors.info;
    }
  }

  String _getButtonText() {
    switch (event.eventType) {
      case ChaosEventType.positive:
        return 'Awesome!';
      case ChaosEventType.negative:
        return 'Oh No!';
      case ChaosEventType.neutral:
        return 'Got It';
    }
  }
}
