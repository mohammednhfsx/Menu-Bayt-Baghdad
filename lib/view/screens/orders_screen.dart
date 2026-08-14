import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/order_controller.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/model/order_model.dart';

class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});

  final OrdersController ctrl = Get.find<OrdersController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).cardColor,
          onRefresh: () async {},
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Obx(() {
                  if (ctrl.isLoading.value) return _buildLoading(context);
                  if (ctrl.orders.isEmpty) return _buildEmptyState(context);
                  return _buildOrdersList(context);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            final active = ctrl.orders
                .where((o) => o.status != OrderStatus.delivered)
                .length;
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: active > 0
                    ? AppColors.primaryOrange.withOpacity(0.15)
                    : Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: active > 0
                      ? AppColors.primaryOrange
                      : Theme.of(context).dividerColor,
                ),
              ),
              child: Text(
                active > 0 ? '$active نشط' : 'لا يوجد',
                style: TextStyle(
                  color: active > 0
                      ? AppColors.primaryOrange
                      : Theme.of(context).hintColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
          Text(
            'طلباتي',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primaryOrange),
          const SizedBox(height: 16),
          Text(
            'جاري تحميل طلباتك...',
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined,
              size: 80, color: Theme.of(context).hintColor),
          const SizedBox(height: 16),
          Text(
            'لا توجد طلبات',
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge?.color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'طلباتك ستظهر هنا بعد الإرسال',
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: ctrl.orders.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (_, index) =>
          _buildOrderCard(ctrl.orders[index], context),
    );
  }

  Widget _buildOrderCard(OrderModel order, BuildContext context) {
    final info = OrderModel.statusInfo(order.status);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: info.color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCardHeader(order, info, context),
          Divider(color: Theme.of(context).dividerColor, height: 1),
          _buildItemsList(order, context),
          Divider(color: Theme.of(context).dividerColor, height: 1),
          _buildCardFooter(order, context),
        ],
      ),
    );
  }

  Widget _buildCardHeader(
    OrderModel order,
    ({String label, Color color, IconData icon}) info,
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                order.id.length > 15
                    ? order.id.substring(0, 15)
                    : order.id,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                'طاولة ${order.tableNumber}',
                style: TextStyle(
                    color: Theme.of(context).hintColor, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList(OrderModel order, BuildContext context) {
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
                  style: TextStyle(color: Theme.of(context).hintColor),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          item.name,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
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
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCardFooter(OrderModel order, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${order.total.toStringAsFixed(0)} د.ع',
            style: const TextStyle(
              color: AppColors.primaryOrange,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Obx(() {
            if (order.secondsLeft.value <= 0) {
              return const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 20),
                  SizedBox(width: 6),
                  Text(
                    'جاهز للاستلام',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ],
              );
            }
            if (order.status == OrderStatus.delivered) {
              return const Text('تم التسليم ✅',
                  style: TextStyle(color: Colors.green, fontSize: 13));
            }
            return Row(
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    value: order.progress,
                    strokeWidth: 3,
                    backgroundColor: Theme.of(context).dividerColor,
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
                        : Theme.of(context).textTheme.bodyLarge?.color,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}