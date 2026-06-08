import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/cart_controller.dart';
import 'package:menubaghdad/controller/order_controller.dart';
import 'package:menubaghdad/controller/order_success_controller.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/model/order_model.dart';
import 'package:menubaghdad/view/screens/order_success_screen.dart';

class OrderConfirmScreen extends StatefulWidget {
  const OrderConfirmScreen({super.key});

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  final CartController cart = Get.find<CartController>();
  final _nameController = TextEditingController();
  String _paymentMethod = 'cash'; // القيمة الافتراضية
  final _tableController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _tableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildOrderSummary(),
                    const SizedBox(height: 16),
                    _buildTableField(),
                    const SizedBox(height: 16),
                    _buildNameField(),
                    const SizedBox(height: 16),
                    _buildPaymentMethod(),
                    const SizedBox(height: 24),
                    _buildConfirmButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── Header ───────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // زر الرجوع
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.cardColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          const Text(
            'تأكيد الطلب',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          // فراغ لمحاذاة العنوان
          const SizedBox(width: 44),
        ],
      ),
    );
  }

  // ─── ملخص الطلب ───────────────────────────────────────────

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // العنوان
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'ملخص الطلب',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.receipt_long,
                color: AppColors.primaryOrange,
                size: 20,
              ),
            ],
          ),

          const Divider(color: AppColors.border, height: 20),

          // قائمة الأصناف
          Obx(
            () => Column(
              children: cart.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.totalPrice.toStringAsFixed(0)} د.ع',
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
          ),

          const Divider(color: AppColors.border, height: 20),

          // الإجمالي
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${cart.total.toStringAsFixed(0)} د.ع',
                  style: const TextStyle(
                    color: AppColors.primaryOrange,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'الإجمالي',
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── اسم الزبون ───────────────────────────────────────────

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'اسمك (اختياري)',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          textAlign: TextAlign.right,
          style: const TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            hintText: 'مثال: أحمد',
            hintStyle: const TextStyle(color: AppColors.greyText),
            prefixIcon: const Icon(
              Icons.person_outline,
              color: AppColors.greyText,
            ),
            filled: true,
            fillColor: AppColors.cardColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.primaryOrange),
            ),
          ),
        ),
      ],
    );
  }

  // ─── طريقة الدفع ──────────────────────────────────────────

  Widget _buildPaymentMethod() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'طريقة الدفع',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // ─ أونلاين ─
            Expanded(
              child: _paymentCard(
                method: 'online',
                icon: Icons.credit_card,
                label: 'أونلاين',
                subtitle: 'دفع إلكتروني',
              ),
            ),
            const SizedBox(width: 12),
            // ─ كاش ─
            Expanded(
              child: _paymentCard(
                method: 'cash',
                icon: Icons.payments_outlined,
                label: 'كاش',
                subtitle: 'عند الكاشير',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _paymentCard({
    required String method,
    required IconData icon,
    required String label,
    required String subtitle,
  }) {
    final isSelected = _paymentMethod == method;

    return GestureDetector(
      onTap: () => setState(() => _paymentMethod = method),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryOrange.withOpacity(0.15)
              : AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryOrange : AppColors.greyText,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primaryOrange : AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: AppColors.greyText, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ─── زر التأكيد ───────────────────────────────────────────

  Widget _buildConfirmButton(BuildContext context) {
    return GestureDetector(
  onTap: () {
  if (_tableController.text.trim().isEmpty) {
    Get.snackbar('تنبيه', 'الرجاء إدخال رقم الطاولة',
        backgroundColor: Colors.red, colorText: Colors.white);
    return;
  }

  final total = cart.total;
  final table = _tableController.text.trim();

  // ─ أضف الطلب لـ OrdersController ─
  Get.find<OrdersController>().addOrder(
    tableNumber: table,
    total: total,
    items: cart.items.map((item) => OrderItemModel(
      name: item.name,
      quantity: item.quantity,
      price: item.price,
    )).toList(),
  );
  final successController = Get.put(OrderSuccessController());

successController.setDuration(30 * 60);
  cart.clearCart();

  Get.off(
    () => OrderSuccessScreen(
      tableNumber: table,
      orderTotal: total.toStringAsFixed(0),
    ),
    transition: Transition.fadeIn,
  );
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
              Icon(Icons.check_circle_outline, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'تأكيد الطلب',
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
    );
  }

  Widget _buildTableField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'رقم الطاولة',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _tableController,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          style: const TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            hintText: 'مثال: ١٢',
            hintStyle: const TextStyle(color: AppColors.greyText),
            prefixIcon: const Icon(
              Icons.table_restaurant_outlined,
              color: AppColors.greyText,
            ),
            filled: true,
            fillColor: AppColors.cardColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: AppColors.primaryOrange),
            ),
          ),
        ),
      ],
    );
  }
}
