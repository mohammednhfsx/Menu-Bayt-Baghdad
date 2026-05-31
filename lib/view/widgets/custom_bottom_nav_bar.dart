import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/home_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController navController = Get.find();

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 35,
          sigmaY: 35,
        ),
        child: Container(
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.08),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            border: Border.all(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.15),
              width: 1,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
            child: Obx(
  () => Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      NavItem(
        index: 0,
        icon: Icons.shopping_bag_outlined,
        iconActive: Icons.shopping_bag_rounded,
        label: 'السلة',
        selectedIndex: navController.selectedIndex.value,
        onTap: navController.changePage,
      ),

     
        NavItem(
        index: 2,
        icon: Icons.shopping_bag_outlined,
        iconActive: Icons.shopping_bag_rounded,
        label: 'طلباتي',
        selectedIndex: navController.selectedIndex.value,
        onTap: navController.changePage,
      ),
       NavItem(
        index: 1,
        icon: Icons.home_outlined,
        iconActive: Icons.home_rounded,
        label: 'الرئيسية',
        selectedIndex: navController.selectedIndex.value,
        onTap: navController.changePage,
      ),
    ],
  ),
),
            ),
          ),
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final int index;
  final IconData icon;
  final IconData iconActive;
  final String label;
  final int selectedIndex;
  final void Function(int) onTap;

  const NavItem({
    super.key,
    required this.index,
    required this.icon,
    required this.iconActive,
    required this.label,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: isSelected
            ? BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF9A5C),
                    Color(0xFFE8521A),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: const Color(0xFFE8521A).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              )
            : const BoxDecoration(
                shape: BoxShape.circle,
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? iconActive : icon,
              color: isSelected
                  ? Colors.white
                  : const Color(0xFF8B7355),
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight:
                    isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Colors.white
                    : const Color(0xFF8B7355),
              ),
            ),
          ],
        ),
      ),
    );
  }
}