import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;
  final VoidCallback? onTap;

  const CustomButton({super.key,
    required this.width,
    required this.height,
    required this.child,
    required this.backgroundColor,
    required this.foregroundColor,
    this.onTap});

  @override
  Widget build(BuildContext context) {
    
    Widget centeredChild = child;

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

    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: .zero,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
        ),
        child: IconTheme(
          data: IconThemeData(
            color: foregroundColor,
          ),
          child: DefaultTextStyle(
              style: TextStyle(
                fontSize: 16,
                color: foregroundColor,
              ),
          child: centeredChild),
        ),
      ),
    );
  }
}
