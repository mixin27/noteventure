import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/achievement.dart';
import '../bloc/achievements_bloc.dart';
import '../bloc/achievements_state.dart';
import '../widgets/achievement_unlock_dialog.dart';
import '../widgets/achievements_view.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AchievementsBloc, AchievementsState>(
      listener: (context, state) {
        if (state is AchievementUnlocked) {
          _showUnlockDialog(context, state.achievement);
        }
      },
      child: const AchievementsView(),
    );
  }

  void _showUnlockDialog(BuildContext context, Achievement achievement) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) =>
          AchievementUnlockDialog(achievement: achievement),
    );
  }
}
