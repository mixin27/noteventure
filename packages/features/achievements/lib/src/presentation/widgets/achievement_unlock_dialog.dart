import 'package:flutter/material.dart';

import '../../domain/entities/achievement.dart';

class AchievementUnlockDialog extends StatelessWidget {
  final Achievement achievement;

  const AchievementUnlockDialog({super.key, required this.achievement});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Achievement Unlock!"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text("Place holder dialog")],
      ),
    );
  }
}
