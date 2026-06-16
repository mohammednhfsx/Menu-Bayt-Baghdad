// lib/view/screens/order_success_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/home_controller.dart';
import 'package:menubaghdad/controller/order_success_controller.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String tableNumber;
  final String orderTotal;

   OrderSuccessScreen({
    super.key,
    required this.tableNumber,
    required this.orderTotal,
  });
  final OrderSuccessController ctrl =
      Get.put(OrderSuccessController());

  @override
  Widget build(BuildContext context) {
    


    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              _buildSuccessIcon(),
              const SizedBox(height: 32),
              _buildOrderInfo(context),
              const Spacer(),
              _buildTimer(ctrl, context),
              const SizedBox(height: 20),
              _buildButtons(),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  // ─── أيقونة النجاح ────────────────────────

  Widget _buildSuccessIcon() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      builder: (_, value, child) => Transform.scale(
        scale: value,
        child: child,
      ),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // ignore: deprecated_member_use
          color: Colors.green.withOpacity(0.15),
          border: Border.all(color: Colors.green, width: 3),
        ),
        child: const Icon(Icons.check_rounded,
            color: Colors.green, size: 70),
      ),
    );
  }

  // ─── معلومات الطلب ────────────────────────

  Widget _buildOrderInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          'تم إرسال طلبك! 🎉',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'طاولة رقم $tableNumber',
          style: const TextStyle(
              color: AppColors.greyText, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: AppColors.primaryOrange.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
                // ignore: deprecated_member_use
                color: AppColors.primaryOrange.withOpacity(0.3)),
          ),
          child: Text(
            'الإجمالي: $orderTotal د.ع',
            style: const TextStyle(
              color: AppColors.primaryOrange,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ─── العداد التنازلي ──────────────────────

  Widget _buildTimer(OrderSuccessController ctrl, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
        boxShadow: Theme.of(context).brightness == Brightness.light ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          )
        ] : [],
      ),
      child: Column(
        children: [
          const Text(
            'الوقت المتوقع للتحضير',
            style: TextStyle(color: AppColors.primaryOrange, fontSize: 13),
          ),
          const SizedBox(height: 16),

          // ─ الدائرة + الوقت ─
          Obx(() => Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: CircularProgressIndicator(
                  value: ctrl.progress,
                  strokeWidth: 7,
                  backgroundColor: Theme.of(context).dividerColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ctrl.isAlmostDone
                        ? Colors.green
                        : AppColors.primaryOrange,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    ctrl.timeFormatted,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                  const Text(
                    'دقيقة',
                    style: TextStyle(
                        color: AppColors.greyText, fontSize: 11),
                  ),
                ],
              ),
            ],
          )),

          const SizedBox(height: 12),

          // ─ رسالة الحالة ─
          Obx(() => Text(
            ctrl.statusMessage,
            style: TextStyle(
              color: ctrl.isAlmostDone
                  ? Colors.green
                  : AppColors.greyText,
              fontSize: 13,
            ),
          )),
        ],
      ),
    );
  }

  // ─── الأزرار ──────────────────────────────

  Widget _buildButtons() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
           Get.until((route) => route.isFirst);
  Get.find<HomeController>().changePage(1);
          },
          child: Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE65100), Color(0xFFFF9800)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: AppColors.primaryOrange.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  SizedBox(width: 8),
                  Text(
                  'العودة للمنيو',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      
      ],
    );
  }
}