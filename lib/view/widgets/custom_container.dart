import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;

  const CustomContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration( color: color,borderRadius: const BorderRadius.all(Radius.circular(25))),
      width: width,
      height: height,
     
      child: child,
    );
  }
}