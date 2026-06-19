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

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(boxShadow: Theme.of(context).brightness == Brightness.light
    ? [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ]
    : [],
          color: Theme.of(context).cardColor,
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
              decoration: BoxDecoration(
                color:  Theme.of(context).primaryColor,
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
                style: TextStyle(color: context.appText),
                onChanged: (value) {
                  menuCtrl.search(value); // ← يحدّث searchQuery لحظياً
                },
                decoration: InputDecoration(
                  hintText: 'ابحث عن طبقك المفضل',
                  // use theme text style for hint
                  hintStyle: Theme.of(context).textTheme.titleSmall,
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
                      controller.clear();      
                      menuCtrl.search('');     
                    },
                    child: Icon(Icons.close,
                        
                        // ignore: deprecated_member_use
                        color: context.appText.withOpacity(0.7)),
                  )
                : Icon(Icons.search,
            
                  color: Theme.of(context).iconTheme.color)),
          ],
        ),
      ),
    );
  }
}