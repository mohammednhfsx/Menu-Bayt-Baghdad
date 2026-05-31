import 'package:flutter/material.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const CustomTextField({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.searchFill,
        borderRadius: BorderRadius.circular(30),
        // ignore: deprecated_member_use
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFFF8A3D),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_fire_department,
              color: Colors.black,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: TextField(
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'ابحث عن طبقك المفضل',
                // ignore: deprecated_member_use
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                border: InputBorder.none,
              ),
            ),
          ),

          // ignore: deprecated_member_use
          Icon(Icons.search, color: Colors.white.withOpacity(0.7)),
        ],
      ),
    );
  }
}
