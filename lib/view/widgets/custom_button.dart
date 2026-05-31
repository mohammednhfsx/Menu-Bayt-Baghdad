import 'package:flutter/material.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';

// Custom Button for the App
class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color? backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onTap;
  final List<Color>? gradiantColors;
  final BoxShape shape;

  const CustomButton({super.key,
    required this.width,
    required this.height,
    required this.child,
    this.backgroundColor,
    required this.foregroundColor,
    this.onTap,
    this.gradiantColors,
    required this.shape});

  @override
  Widget build(BuildContext context) {
    
    Widget centeredChild = child;

    // Centered The Child that Return

    if(child is Row){
      centeredChild = Row(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: (child as Row).children,
      );
    }
    if(child is Column){
      centeredChild = Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: (child as Column).children,
      );
    }


    // Custom Button Design

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: .zero,

        decoration: BoxDecoration(
          borderRadius: shape == BoxShape.rectangle ? BorderRadius.circular(25) : null,
          gradient: gradiantColors != null ? LinearGradient(
              colors: gradiantColors!,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.1, 0.5]
          ) : null,
          shape: shape,
          color: gradiantColors == null ? backgroundColor : null,
        ),

        child: IconTheme(
          data: IconThemeData(
            color: foregroundColor,
            size: 15
          ),

          child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 12,
                color: foregroundColor,
              ),
          child: centeredChild),
        ),
      ),
    );
  }
}
