import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

import '../../domain/entities/chaos_event_entity.dart';
import '../bloc/chaos_bloc.dart';
import '../bloc/chaos_event.dart';
import '../bloc/chaos_state.dart';

class ChaosHistoryPage extends StatelessWidget {
  const ChaosHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chaos History'),
        actions: [
          IconButton(
            icon: const Icon(Icons.casino),
            tooltip: 'Trigger Random Event',
            onPressed: () {
              context.read<ChaosBloc>().add(TriggerRandomEventAction());
            },
          ),
        ],
      ),
      body: BlocBuilder<ChaosBloc, ChaosState>(
        builder: (context, state) {
          if (state is ChaosLoading) {
            return const LoadingIndicator(message: 'Loading events...');
          }

          if (state is ChaosError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () => context.read<ChaosBloc>().add(
                const LoadRecentEvents(limit: 20),
              ),
            );
          }

          if (state is ChaosLoaded) {
            if (state.events.isEmpty) {
              return const EmptyState(
                icon: Icons.casino,
                title: 'No chaos events yet',
                message: 'Events will appear here when triggered',
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: state.events.length,
              itemBuilder: (context, index) {
                final event = state.events[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _ChaosEventCard(event: event),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ChaosEventCard extends StatelessWidget {
  final ChaosEventEntity event;

  const _ChaosEventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getColor();

    return CustomCard(
      color: color.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_getIcon(), color: color, size: 24),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  event.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              CustomBadge(
                text: event.eventType.displayName,
                variant: _getBadgeVariant(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(event.message, style: theme.textTheme.bodyMedium),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                _formatTime(event.triggeredAt),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (event.pointsAwarded > 0) ...[
                const Spacer(),
                Icon(Icons.stars, size: 16, color: AppColors.warning),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  '+${event.pointsAwarded}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.warning,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Color _getColor() {
    switch (event.eventType) {
      case ChaosEventType.positive:
        return AppColors.success;
      case ChaosEventType.negative:
        return AppColors.error;
      case ChaosEventType.neutral:
        return AppColors.info;
    }
  }

  IconData _getIcon() {
    switch (event.eventType) {
      case ChaosEventType.positive:
        return Icons.celebration;
      case ChaosEventType.negative:
        return Icons.warning_amber;
      case ChaosEventType.neutral:
        return Icons.info_outline;
    }
  }

  BadgeVariant _getBadgeVariant() {
    switch (event.eventType) {
      case ChaosEventType.positive:
        return BadgeVariant.success;
      case ChaosEventType.negative:
        return BadgeVariant.error;
      case ChaosEventType.neutral:
        return BadgeVariant.info;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
