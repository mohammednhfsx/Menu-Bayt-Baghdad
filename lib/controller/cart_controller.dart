import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/core/supabase_client.dart';
import 'package:menubaghdad/model/cart_model.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;
  final RxString couponCode = ''.obs;
  final RxDouble discountAmount = 0.0.obs;
  final RxBool isSubmitting = false.obs; // ← أضف هذا

  // ───────────────────── حسابات ───────────────────────────────────────────

  double get subtotal => items.fold(0, (sum, items) => sum + items.totalPrice);
  double get total => subtotal - discountAmount.value;
  int get itemCount => items.fold(0, (sum, items) => sum + items.quantity);

  // ─── العمليات ─────────────────────────────────────────────

  void addItem(CartItem newItem) {
    final index = items.indexWhere((i) => i.id == newItem.id);
    if (index >= 0) {
      items[index].quantity++;
      items.refresh();
    } else {
      items.add(newItem);
    }
  }

  void increment(String itemId) {
    final index = items.indexWhere((i) => i.id == itemId);
    if (index >= 0) {
      items[index].quantity++;
      items.refresh();
    }
  }

  void decrement(String itemId) {
    final index = items.indexWhere((i) => i.id == itemId);
    if (index >= 0) {
      if (items[index].quantity > 1) {
        items[index].quantity--;
        items.refresh();
      } else {
        items.removeAt(index);
      }
    }
  }

  void removeItem(String itemId) {
    items.removeWhere((i) => i.id == itemId);
  }

  void applyCoupon(String code) {
    if (code == 'BAGHDAD20') {
      discountAmount.value = subtotal * 0.20;
      Get.snackbar('تم!', 'خصم 20% مطبق');
    } else {
      discountAmount.value = 0;
      Get.snackbar('خطأ', 'الكوبون غير صحيح');
    }
  }

  void clearCart() => items.clear();

  // ─── إرسال الطلب لـ Supabase ──────────────────────────────

  Future<Map<String, dynamic>?> submitOrder({
    required String tableNumber,
    required String paymentMethod,
  }) async {
    if (items.isEmpty) return null;

    try {
      isSubmitting.value = true;

      // ١. نجد أو ننشئ الطاولة
      final tableResponse = await supabase
          .from('tables')
          .select('id')
          .eq('table_number', tableNumber)
          .eq('restaurant_id', '11111111-1111-1111-1111-111111111111')
          .maybeSingle();

      String tableId;
      if (tableResponse == null) {
        final newTable = await supabase
            .from('tables')
            .insert({
              'restaurant_id': '11111111-1111-1111-1111-111111111111',
              'table_number': tableNumber,
              'status': 'open',
            })
            .select('id')
            .single();
        tableId = newTable['id'];
      } else {
        tableId = tableResponse['id'];
      }

        // ───    sessions   ──────────────────────────────
      final session = await supabase
          .from('sessions')
          .insert({
            'table_id': tableId,
            'status': 'open',
          })
          .select('id')
          .single();

      final sessionId = session['id'];

       // ───    Created order   ──────────────────────────────
      final order = await supabase
          .from('orders')
          .insert({
            'session_id': sessionId,
            'table_id': tableId,
            'total_amount': total,
            'status': 'new',
            'payment_method': paymentMethod,
          })
          .select()
          .single();

      final orderId = order['id'];

         // ───    details order   ──────────────────────────────
      final orderItems = items.map((item) => {
        'order_id': orderId,
        'menu_item_id': item.id,
        'quantity': item.quantity,
      }).toList();

      await supabase.from('order_items').insert(orderItems);

      // ٥. تنظيف السلة
      clearCart();

      return order;

    } catch (e) {
      Get.snackbar('خطأ', 'تعذر إرسال الطلب: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
      return null;
    } finally {
      isSubmitting.value = false;
    }
  }
}