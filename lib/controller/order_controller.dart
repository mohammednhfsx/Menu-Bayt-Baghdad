// في orders_controller.dart

import 'dart:async';
import 'package:get/get.dart';
import 'package:menubaghdad/model/order_model.dart';

class OrdersController extends GetxController {
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxBool isLoading = true.obs;

  // هنا نخزن Timer لكل طلب
  final Map<String, Timer> _timers = {};

  @override
  void onInit() {
    super.onInit();
    _initMockOrders(); // تحميل طلبات ديمو أولية
  }

  // ─── تحميل طلبات تجريبية للـ UI Kit Demo ──────────────────
  Future<void> _initMockOrders() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(milliseconds: 300));

      final sampleOrders = [
        OrderModel(
          id: 'ORD-2041',
          tableNumber: '١٢',
          status: OrderStatus.preparing,
          createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
          total: 28000.0,
          items: [
            OrderItemModel(name: 'كباب لحم بغدادي مشوي', quantity: 2, price: 14000.0),
            OrderItemModel(name: 'حمص بطحينة وزيت زيتون', quantity: 1, price: 5000.0),
          ],
          initialSeconds: 22 * 60,
        ),
        OrderModel(
          id: 'ORD-2040',
          tableNumber: '٠٥',
          status: OrderStatus.ready,
          createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
          total: 42000.0,
          items: [
            OrderItemModel(name: 'قوزي لحم غنم على تمن', quantity: 1, price: 24000.0),
            OrderItemModel(name: 'دولمة بغدادية مشكلة', quantity: 1, price: 18000.0),
          ],
          initialSeconds: 3 * 60,
        ),
        OrderModel(
          id: 'ORD-2039',
          tableNumber: '٠٨',
          status: OrderStatus.newOrder,
          createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
          total: 19500.0,
          items: [
            OrderItemModel(name: 'برياني دجاج ملكي', quantity: 1, price: 15000.0),
            OrderItemModel(name: 'شوربة عدس بغدادية', quantity: 1, price: 4000.0),
            OrderItemModel(name: 'شاي عراقي مهيل', quantity: 1, price: 1500.0),
          ],
          initialSeconds: 28 * 60,
        ),
      ];

      orders.assignAll(sampleOrders);

      // تشغيل العداد لكل طلب
      for (final o in orders) {
        _startTimer(o);
      }
    } catch (e) {
      Get.snackbar('خطأ', 'تعذر جلب الطلبات: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ─── إضافة طلب جديد تفاعلي من السلة ───────────────────
  void addOrder({
    required String tableNumber,
    required double total,
    required List<OrderItemModel> items,
    int seconds = 30 * 60,
  }) {
    final newOrder = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      tableNumber: tableNumber,
      status: OrderStatus.newOrder,
      createdAt: DateTime.now(),
      total: total,
      items: items,
      initialSeconds: seconds,
    );

    orders.insert(0, newOrder);
    _startTimer(newOrder); // ابدأ عداد خاص لهذا الطلب
  }

  void _startTimer(OrderModel order) {
    _timers[order.id]?.cancel();
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

  String waitingTime(DateTime createdAt) {
    final diff = DateTime.now().difference(createdAt).inMinutes;
    return '$diff د';
  }

  @override
  void onClose() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    super.onClose();
  }
}