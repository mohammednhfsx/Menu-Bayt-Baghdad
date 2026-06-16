import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/home_controller.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController navController = Get.find();

    return Positioned(left: 25,right: 25,bottom: 50,
      child: ClipRRect(
        borderRadius:  BorderRadius.circular(50
 
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(height: 100,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.75),
              borderRadius:  BorderRadius.circular(50),
              border: Border.all(
                // ignore: deprecated_member_use
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.15)
                    : Colors.black.withOpacity(0.06),
                width: 1,
              ),
            ),
            
              child: Padding(
                padding: const EdgeInsets.all(
                10
                ),
              child: Obx(
        () => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
           NavItem(
          index: 3,
          icon: Icons.settings,
          iconActive: Icons.settings,
          label: 'الاعدادات',
          selectedIndex: navController.selectedIndex.value,
          onTap: navController.changePage,
        ),
       
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

    return  GestureDetector(
  onTap: () => onTap(index),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  curve: Curves.linear,
  width: isSelected ? 115 : 50,
  height: 50,
  padding: EdgeInsets.symmetric(
    horizontal: isSelected ? 16 : 0,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    gradient: isSelected
        ? const LinearGradient(
            colors: [
              Color(0xFFFF9A5C),
              Color(0xFFE8521A),
            ],
          )
        : null,
    color: isSelected ? null : Colors.transparent,
  boxShadow: isSelected
    ? [
        BoxShadow(
          color: const Color(0xFFE8521A).withValues(alpha: 0.20,),
          blurRadius: 20,  
          offset: const Offset(0, 2),
        ),
      ]
    : const [], // ← أضف const هنا
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TweenAnimationBuilder<double>(
        tween: Tween(
          begin: 0,
          end: isSelected ? 1 : 0,
        ),
        duration: const Duration(milliseconds: 500),
        builder: (context, value, child) {
          return Transform.rotate(
            angle: value * 6.28, // 360°
            child: child,
          );
        },
        child: Icon(
          isSelected ? iconActive : icon,
          color: isSelected
              ? Colors.white
              : const Color(0xFF8B7355),
          size: 24,
        ),
      ),

      AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        child: isSelected
            ? Row(
                children: [
                  const SizedBox(width: 8),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: 1,
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
      ),
    ],
  ),
),
    

     
    ],
  ),
);
  }
}