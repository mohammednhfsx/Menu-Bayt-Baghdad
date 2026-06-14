import 'package:flutter/material.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final  Function()? onTap;

  const  CustomIcon({
    super.key,
    required this.icon,
    this.iconColor = Colors.orange,
    this.backgroundColor = AppColors.cardColor,
    this.size = 22,  this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: 
      onTap,
      
    
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
            border: Border.all(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.15),
                width: 1,
              ),
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
      ),
    );
  }
}