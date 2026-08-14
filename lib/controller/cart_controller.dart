import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/order_controller.dart';
import 'package:menubaghdad/model/cart_model.dart';
import 'package:menubaghdad/model/order_model.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;
  final RxString couponCode = ''.obs;
  final RxDouble discountAmount = 0.0.obs;
  final RxBool isSubmitting = false.obs;

  // ───────────────────── حسابات ───────────────────────────────────────────

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get total => subtotal - discountAmount.value;
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  // ─── العمليات ─────────────────────────────────────────────

  void addItem(CartItem newItem) {
    final index = items.indexWhere((i) => i.id == newItem.id);
    if (index >= 0) {
      items[index].quantity += newItem.quantity;
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

  // ─── محاكاة إرسال الطلب للـ UI Kit Demo ──────────────────────

  Future<Map<String, dynamic>?> submitOrder({
    required String tableNumber,
    required String paymentMethod,
  }) async {
    if (items.isEmpty) return null;

    try {
      isSubmitting.value = true;

      // محاكاة استجابة شبكية سريعة
      await Future.delayed(const Duration(milliseconds: 600));

      final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

      // تحويل عناصر السلة إلى OrderItemModel وإضافتها إلى قائمة الطلبات الحية
      final orderItems = items
          .map((item) => OrderItemModel(
                name: item.name,
                quantity: item.quantity,
                price: item.price,
              ))
          .toList();

      if (Get.isRegistered<OrdersController>()) {
        Get.find<OrdersController>().addOrder(
          tableNumber: tableNumber,
          total: total,
          items: orderItems,
        );
      }

      final mockOrder = {
        'id': orderId,
        'table_number': tableNumber,
        'total_amount': total,
        'status': 'new',
        'payment_method': paymentMethod,
        'created_at': DateTime.now().toIso8601String(),
      };

      // تنظيف السلة
      clearCart();

      return mockOrder;
    } catch (e) {
      Get.snackbar('خطأ', 'تعذر إرسال الطلب: $e',
          backgroundColor: Colors.red, colorText: Colors.white);
      return null;
    } finally {
      isSubmitting.value = false;
    }
  }
}