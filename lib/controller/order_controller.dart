// في orders_controller.dart

import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:menubaghdad/core/supabase_client.dart';
import 'package:menubaghdad/model/order_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrdersController extends GetxController {
  final RxList<OrderModel> orders = <OrderModel>[].obs;
  final RxBool isLoading = true.obs;

  // هنا نخزن Timer لكل طلب    
  final Map<String, Timer> _timers = {};
  //اتصال Realtime مع Supabase
  RealtimeChannel?_channel;

  @override
  void onInit() {
    super.onInit();
    _fetchOrder();       // جلب الطلبات عند فتح الشاشة
    _subscribeRealtime(); // الاستماع للتغييرات اللحظية
  }



  // ─── جلب الطلبات من Supabase ──────────────────
  Future <void>_fetchOrder()async{


    try {  isLoading.value = true;
     final respons = await supabase.from('orders').select('''
            *,
            order_items(*, menu_items(name, price)),
            tables(table_number)
          ''').neq('status', 'delivered').order('created_at' , ascending: false);

//نضيف الطلبات الجديدة فقط 

 for(final raw in respons as List ){
  final exists = orders.any((o)=> o.id ==raw['id']);
  if(!exists){
    final order = _parseOrder(raw);
    orders.insert(0, order);
    _startTimer(order);






  }
 }


    }catch(e){ Get.snackbar('خطأ', 'تعذر جلب الطلبات: $e');}finally {
      isLoading.value = false;
    }
  }

   // ─── Realtime ──────────────────────────────────
  void _subscribeRealtime() {
    _channel = supabase
        .channel('orders_realtime')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert, // طلب جديد
          schema: 'public',
          table: 'orders',
          callback: (_) => _fetchOrder(),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update, // تغيير حالة
          schema: 'public',
          table: 'orders',
          callback: (payload) {
            // نحدّث حالة الطلب بدون إعادة جلب كاملة
            final updated = payload.newRecord;
            final index = orders.indexWhere((o) => o.id == updated['id']);
            if (index >= 0) {
              orders[index] = orders[index].copyWith(
                status: OrderModel.statusFromString(updated['status']),
              );
              orders.refresh();
            }
          },
        )
        .subscribe();
  }
   // ─── تحويل JSON إلى OrderModel ─────────────────
  OrderModel _parseOrder(Map<String, dynamic> raw) {
    final rawItems = raw['order_items'] as List<dynamic>? ?? [];

    final items = rawItems.map((i) => OrderItemModel(
      name: i['menu_items']['name'],
      quantity: i['quantity'],
      price: (i['menu_items']['price'] as num).toDouble(),
    )).toList();

    return OrderModel(
      id: raw['id'],
      tableNumber: raw['tables']?['table_number'] ?? '?',
      status: OrderModel.statusFromString(raw['status']),
      createdAt: DateTime.parse(raw['created_at']),
      total: (raw['total_amount'] as num).toDouble(),
      items: items,
      initialSeconds: 30 * 60,
    );
  }









  // void addOrder({
  //   required String tableNumber,
  //   required double total,
  //   required List<OrderItemModel> items,
  //   int seconds = 30 * 60,
  // }) {
  //   final newOrder = OrderModel(
  //     id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
  //     tableNumber: tableNumber,
  //     status: OrderStatus.newOrder,
  //     createdAt: DateTime.now(),
  //     total: total,
  //     items: items,
  //     initialSeconds: seconds,
  //   );

  //   orders.insert(0, newOrder);
  //   _startTimer(newOrder); // ← ابدأ عداد خاص لهذا الطلب
  // }

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

  String waitingTime(DateTime createdAt) {
    final diff = DateTime.now().difference(createdAt).inMinutes;
    return '$diff د';
  }
  @override
  void onClose() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _channel?.unsubscribe();
    super.onClose();
  }

}