import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

import '../../domain/entities/chaos_event_entity.dart';
import 'chaos_event_dialog.dart';

class ChaosEventSnackBar {
  static void show(BuildContext context, ChaosEventEntity event) {
    final color = _getColor(event.eventType);
    final icon = _getIcon(event.eventType);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    event.message,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (event.pointsAwarded > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  '+${event.pointsAwarded}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Details',
          textColor: Colors.white,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => ChaosEventDialog(event: event),
            );
          },
        ),
      ),
    );
  }

  static Color _getColor(ChaosEventType type) {
    switch (type) {
      case ChaosEventType.positive:
        return AppColors.success;
      case ChaosEventType.negative:
        return AppColors.error;
      case ChaosEventType.neutral:
        return AppColors.info;
    }
  }

  static IconData _getIcon(ChaosEventType type) {
    switch (type) {
      case ChaosEventType.positive:
        return Icons.celebration;
      case ChaosEventType.negative:
        return Icons.warning_amber;
      case ChaosEventType.neutral:
        return Icons.info_outline;
    }
  }
}
