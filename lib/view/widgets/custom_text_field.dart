import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/menu_controller.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const CustomTextField({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final menuCtrl = Get.find<AppMenuController >();

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
          // ─ أيقونة النار ─
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

          // ─ حقل البحث ─
          Expanded(
            child: TextField(
              controller: controller,
              textAlign: TextAlign.right,
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                menuCtrl.search(value); // ← يحدّث searchQuery لحظياً
              },
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

          // ─ أيقونة X للمسح أو Search ─
          Obx(() => menuCtrl.searchQuery.value.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    controller.clear();      // يمسح الـ TextField
                    menuCtrl.search('');     // يمسح البحث
                  },
                  child: Icon(Icons.close,
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.7)),
                )
              : Icon(Icons.search,
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.7))),
        ],
      ),
    );
  }
}