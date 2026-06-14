import 'package:flutter/material.dart';

class ShakingCard extends StatefulWidget {
  final Widget child;

  const ShakingCard({
    super.key,
    required this.child,
  });

  @override
  State<ShakingCard> createState() => _ShakingCardState();
}

class _ShakingCardState extends State<ShakingCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            -2 + (_controller.value * 10), // حركة خفيفة فوق وجوه
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}