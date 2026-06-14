import 'package:flutter/material.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';

class ShimmerHomeLoading extends StatefulWidget {
  const ShimmerHomeLoading({super.key});

  @override
  State<ShimmerHomeLoading> createState() => _ShimmerHomeLoadingState();
}

class _ShimmerHomeLoadingState extends State<ShimmerHomeLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
    _anim = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, _) => SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              _ShimmerHeader(_anim),
              const SizedBox(height: 15),
              _ShimmerSearchBar(_anim),
              const SizedBox(height: 25),
              _ShimmerBanner(_anim),
              const SizedBox(height: 15),
              _ShimmerCategories(_anim),
              const SizedBox(height: 15),
              _ShimmerFeaturedSection(_anim),
              const SizedBox(height: 24),
              _ShimmerMostRequestedSection(_anim),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Shared helpers
// ─────────────────────────────────────────────────────────────────────────────

/// Wraps any child with the animated shimmer gradient.
class _Shimmer extends StatelessWidget {
  final Animation<double> anim;
  final double width;
  final double height;
  final double radius;

  const _Shimmer({
    required this.anim,
    this.width = double.infinity,
    required this.height,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: AnimatedBuilder(
          animation: anim,
          builder: (_, _) => DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(anim.value - 1, 0),
                end: Alignment(anim.value + 1, 0),
                colors: const [
                  Color(0xFF2A2A2A),
                  Color(0xFF3A3A3A),
                  Color(0xFF454545),
                  Color(0xFF3A3A3A),
                  Color(0xFF2A2A2A),
                ],
                stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Header
// ─────────────────────────────────────────────────────────────────────────────
class _ShimmerHeader extends StatelessWidget {
  final Animation<double> anim;
  const _ShimmerHeader(this.anim);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // notification icon placeholder
          _Shimmer(anim: anim, width: 42, height: 42, radius: 21),
          // greeting text placeholder
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _Shimmer(anim: anim, width: 180, height: 14, radius: 7),
              const SizedBox(height: 8),
              _Shimmer(anim: anim, width: 220, height: 22, radius: 7),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Search bar
// ─────────────────────────────────────────────────────────────────────────────
class _ShimmerSearchBar extends StatelessWidget {
  final Animation<double> anim;
  const _ShimmerSearchBar(this.anim);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _Shimmer(anim: anim, height: 50, radius: 16),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Banner
// ─────────────────────────────────────────────────────────────────────────────
class _ShimmerBanner extends StatelessWidget {
  final Animation<double> anim;
  const _ShimmerBanner(this.anim);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _Shimmer(anim: anim, height: 200, radius: 25),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Category chips
// ─────────────────────────────────────────────────────────────────────────────
class _ShimmerCategories extends StatelessWidget {
  final Animation<double> anim;
  const _ShimmerCategories(this.anim);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // section title row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Shimmer(anim: anim, width: 60, height: 16, radius: 8),
              _Shimmer(anim: anim, width: 80, height: 20, radius: 8),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (_, i) => _Shimmer(
              anim: anim,
              width: i == 0 ? 90 : 70, // first one "selected" wider
              height: 60,
              radius: 15,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Featured Today – horizontal cards
// ─────────────────────────────────────────────────────────────────────────────
class _ShimmerFeaturedSection extends StatelessWidget {
  final Animation<double> anim;
  const _ShimmerFeaturedSection(this.anim);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Shimmer(anim: anim, width: 60, height: 16, radius: 8),
              _Shimmer(anim: anim, width: 120, height: 22, radius: 8),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 320,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 4,
            separatorBuilder: (_, _) => const SizedBox(width: 15),
            itemBuilder: (_, _) => _ShimmerFeaturedCard(anim),
          ),
        ),
      ],
    );
  }
}

class _ShimmerFeaturedCard extends StatelessWidget {
  final Animation<double> anim;
  const _ShimmerFeaturedCard(this.anim);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: AppColors.bottomNav,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // image area
          _Shimmer(anim: anim, height: 170, radius: 25),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _Shimmer(anim: anim, width: 160, height: 22, radius: 6),
                const SizedBox(height: 8),
                _Shimmer(anim: anim, height: 14, radius: 6),
                const SizedBox(height: 6),
                _Shimmer(anim: anim, width: 120, height: 14, radius: 6),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _Shimmer(anim: anim, width: 60, height: 16, radius: 6),
                    const Spacer(),
                    _Shimmer(anim: anim, width: 80, height: 20, radius: 6),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Most Requested – vertical list
// ─────────────────────────────────────────────────────────────────────────────
class _ShimmerMostRequestedSection extends StatelessWidget {
  final Animation<double> anim;
  const _ShimmerMostRequestedSection(this.anim);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Shimmer(anim: anim, width: 60, height: 16, radius: 8),
              _Shimmer(anim: anim, width: 100, height: 22, radius: 8),
            ],
          ),
        ),
        const SizedBox(height: 15),
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (_, _) => _ShimmerMostRequestedItem(anim),
        ),
      ],
    );
  }
}

class _ShimmerMostRequestedItem extends StatelessWidget {
  final Animation<double> anim;
  const _ShimmerMostRequestedItem(this.anim);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bottomNav,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // add button
          _Shimmer(anim: anim, width: 36, height: 36, radius: 18),
          const SizedBox(width: 12),

          // text info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _Shimmer(anim: anim, width: 140, height: 17, radius: 6),
                const SizedBox(height: 6),
                _Shimmer(anim: anim, height: 12, radius: 5),
                const SizedBox(height: 4),
                _Shimmer(anim: anim, width: 100, height: 12, radius: 5),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _Shimmer(anim: anim, width: 80, height: 18, radius: 6),
                    _Shimmer(anim: anim, width: 44, height: 14, radius: 6),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // thumbnail
          _Shimmer(anim: anim, width: 90, height: 90, radius: 15),
        ],
      ),
    );
  }
}