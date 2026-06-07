import 'package:get/get.dart';
import 'package:menubaghdad/model/cart_model.dart';

class CartController extends GetxController {
  final RxList<CartItem> items = <CartItem>[].obs;
  // كوبون الخصم
  final RxString couponCode = ''.obs;
  final RxDouble discountAmount = 0.0.obs;

  // ───────────────────── حسابات ───────────────────────────────────────────────

  double get subtotal => items.fold(0, (sum, items) => sum + items.totalPrice);

  double get total => subtotal - discountAmount.value;

  int get itemCount => items.fold(0, (sum, items) => sum + items.quantity);

  // ─── العمليات ─────────────────────────────────────────────

  // إضافة صنف — لو موجود نزيد الكمية، لو ما موجود نضيفه
  void addItem(CartItem newItem) {
    final index = items.indexWhere((i) => i.id == newItem.id);
    if (index >= 0) {
      items[index].quantity++;
      items.refresh();
    } else {
      items.add(newItem);
    }
  }

  // زيادة كمية صنف معين
  void increment(String itemId) {
    final index = items.indexWhere((i) => i.id == itemId);
    if (index >= 0) {
      items[index].quantity++;
      items.refresh();
    }
  }

  // تقليل كمية — لو وصلت لـ 0 نحذف الصنف
  void decrement(String itemId) {
    final index = items.indexWhere((i) => i.id == itemId);
    if (index >= 0) {
      if (items[index].quantity > 1) {
        items[index].quantity--;
        items.refresh();
      } else {
        items.removeAt(index); // حذف تلقائي لو الكمية صارت صفر
      }
    }
  }

  // حذف  مباشرة
  void removeItem(String itemId) {
    items.removeWhere((i) => i.id == itemId);
  }


   // تطبيق كوبون
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















}
