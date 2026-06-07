// في orders_controller.dart

import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:menubaghdad/model/order_model.dart';

class OrdersController extends GetxController {
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxBool isLoading = false.obs;

  // نحفظ الـ Timers لنوقفها لاحقاً
  final Map<String, Timer> _timers = {};

  void addOrder({
    required String tableNumber,
    required double total,
    required List<OrderItemModel> items,
    int seconds = 30 * 60,
  }) {
    final newOrder = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      tableNumber: tableNumber,
      status: OrderStatus.newOrder,
      createdAt: DateTime.now(),
      total: total,
      items: items,
      initialSeconds: seconds,
    );

    orders.insert(0, newOrder);
    _startTimer(newOrder); // ← ابدأ عداد خاص لهذا الطلب
  }

  void _startTimer(OrderModel order) {
    _timers[order.id] = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (order.secondsLeft.value <= 0) {
          _timers[order.id]?.cancel();
        } else {
          order.secondsLeft.value--;
        }
      },
    );
  }

  @override
  void onClose() {
    // أوقف كل الـ Timers عند الخروج
    for (final timer in _timers.values) {
      timer.cancel();
    }
    super.onClose();
  }

  String waitingTime(DateTime createdAt) {
    final diff = DateTime.now().difference(createdAt).inMinutes;
    return '$diff د';
  }
}