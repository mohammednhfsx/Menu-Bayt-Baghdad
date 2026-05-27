import 'package:flutter/material.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';

class CustomIconContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;

  const CustomIconContainer({
    super.key,
    required this.icon,
    this.iconColor = Colors.orange,
    this.backgroundColor = AppColors.cardColor,
    this.size = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: size,
        ),
      ),
    );
  }
}