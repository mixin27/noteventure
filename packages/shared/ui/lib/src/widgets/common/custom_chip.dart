import 'package:flutter/material.dart';
import '../../themes/app_spacing.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  // final VoidCallback? onDeleted;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomChip({
    super.key,
    required this.label,
    this.icon,
    // this.onDeleted,
    this.onTap,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      avatar: icon != null ? Icon(icon, size: AppSpacing.iconSm) : null,
      onPressed: onTap,
      // deleteIcon: onDeleted != null
      //     ? const Icon(Icons.close, size: AppSpacing.iconSm)
      //     : null,
      // onDeleted: onDeleted,
      backgroundColor: backgroundColor,
      labelStyle: TextStyle(color: foregroundColor),
    );
  }
}
