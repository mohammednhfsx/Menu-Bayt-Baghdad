// lib/view/screens/orders_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/order_controller.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/model/order_model.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final OrdersController ctrl = Get.put(OrdersController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
        color: AppColors.white,
        backgroundColor: AppColors.border,
        onRefresh: () async {
      
        },
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Obx(() {
                  if (ctrl.isLoading.value) return _buildLoading();
                  if (ctrl.orders.isEmpty) return _buildEmptyState();
                  return _buildOrdersList();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // عدد الطلبات النشطة
          Obx(() {
            final active = ctrl.orders
                .where((o) => o.status != OrderStatus.delivered)
                .length;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: active > 0
                    // ignore: deprecated_member_use
                    ? AppColors.primaryOrange.withOpacity(0.15)
                    : AppColors.cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: active > 0
                      ? AppColors.primaryOrange
                      : AppColors.border,
                ),
              ),
              child: Text(
                active > 0 ? '$active نشط' : 'لا يوجد',
                style: TextStyle(
                  color: active > 0
                      ? AppColors.primaryOrange
                      : AppColors.greyText,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),

          const Text(
            'طلباتي',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Loading ──────────────────────────────────────────────

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primaryOrange),
          const SizedBox(height: 16),
          const Text(
            'جاري تحميل طلباتك...',
            style: TextStyle(color: AppColors.greyText),
          ),
        ],
      ),
    );
  }

  // ─── Empty State ──────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 80,
            color: AppColors.greyText,
          ),
          const SizedBox(height: 16),
          const Text(
            'لا توجد طلبات',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'طلباتك ستظهر هنا بعد الإرسال',
            style: TextStyle(color: AppColors.greyText),
          ),
        ],
      ),
    );
  }

  // ─── Orders List ──────────────────────────────────────────

  Widget _buildOrdersList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: ctrl.orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) => _buildOrderCard(ctrl.orders[index]),
    );
  }

  // ─── Order Card ───────────────────────────────────────────

  Widget _buildOrderCard(OrderModel order) {
    final info = OrderModel.statusInfo(order.status);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
        // ignore: deprecated_member_use
        border: Border.all(color: info.color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          // ── رأس الكارد: رقم الطلب + الحالة ──
          _buildCardHeader(order, info),

          const Divider(color: AppColors.border, height: 1),

          // ── تفاصيل الأصناف ──
          _buildItemsList(order),

          const Divider(color: AppColors.border, height: 1),

          // ── أسفل الكارد: الإجمالي + وقت الانتظار ──
          _buildCardFooter(order),
        ],
      ),
    );
  }

  Widget _buildCardHeader(
    OrderModel order,
    ({String label, Color color, IconData icon}) info,
  ) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ─ حالة الطلب ─
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: info.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(info.icon, color: info.color, size: 16),
                const SizedBox(width: 6),
                Text(
                  info.label,
                  style: TextStyle(
                    color: info.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          // ─ رقم الطلب والطاولة ─
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                order.id.substring(0,15),
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                'طاولة ${order.tableNumber}',
                style: const TextStyle(color: AppColors.greyText, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(OrderModel order) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        children: order.items.map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(item.price * item.quantity).toStringAsFixed(0)} د.ع',
                  style: const TextStyle(color: AppColors.greyText),
                ),
                Row(
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(color: AppColors.white),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: AppColors.primaryOrange.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '×${item.quantity}',
                        style: const TextStyle(
                          color: AppColors.primaryOrange,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

 Widget _buildCardFooter(OrderModel order) {
  return Padding(
    padding: const EdgeInsets.all(14),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // ─ الإجمالي ─
        Text(
          '${order.total.toStringAsFixed(0)} د.ع',
          style: const TextStyle(
            color: AppColors.primaryOrange,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        // ─ العداد التنازلي ─
        Obx(() {
       // ─ لو العداد وصل للصفر ─
  if (order.secondsLeft.value <= 0) {
    return Row(
      children: const [
        Icon(Icons.check_circle, color: Colors.green, size: 20),
        SizedBox(width: 6),
        Text(
          'جاهز للاستلام',
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  // ─ لو تم التسليم ─
  if (order.status == OrderStatus.delivered) {
    return const Text(
      'تم التسليم ✅',
      style: TextStyle(color: Colors.green, fontSize: 13),
    );
  }

  // ─ العداد شغال ─
  return Column(
    children: [
    
      
      Row(
        children: [
          SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              value: order.progress,
              strokeWidth: 3,
              backgroundColor: AppColors.border,
              valueColor: AlwaysStoppedAnimation<Color>(
                order.isAlmostDone
                    ? Colors.green
                    : AppColors.primaryOrange,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            order.timeFormatted,
            style: TextStyle(
              color: order.isAlmostDone
                  ? Colors.green
                  : AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ],
  );

        }),
      ],
    ),
  );
}
}
