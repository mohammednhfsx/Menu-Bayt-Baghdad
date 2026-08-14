import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/cart_controller.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
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
      backgroundColor: context.appBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildOrderSummary(context),
                    const SizedBox(height: 16),
                    _buildTableField(context),
                    const SizedBox(height: 16),
                    _buildNameField(context),
                    const SizedBox(height: 16),
                    _buildPaymentMethod(context),
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

  Widget _buildHeader(BuildContext context) {
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
                color: context.appCard,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: context.appText,
                size: 20,
              ),
            ),
          ),
          Text(
            'تأكيد الطلب',
            style: TextStyle(
              color: context.appText,
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

  Widget _buildOrderSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // العنوان
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'ملخص الطلب',
                style: TextStyle(
                  color: context.appText,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.receipt_long,
                color: AppColors.primaryOrange,
                size: 20,
              ),
            ],
          ),

          Divider(color: context.appBorder, height: 20),

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
                        style: TextStyle(color: context.appSubText),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                item.name,
                                style: TextStyle(color: context.appText),
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
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          Divider(color: context.appBorder, height: 20),

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
                Text(
                  'الإجمالي',
                  style: TextStyle(
                    color: context.appText,
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

  Widget _buildNameField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'اسمك (اختياري)',
          style: TextStyle(color: context.appText, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _nameController,
          textAlign: TextAlign.right,
          style: TextStyle(color: context.appText),
          decoration: InputDecoration(
            hintText: 'مثال: أحمد',
            hintStyle: TextStyle(color: context.appSubText),
            prefixIcon: Icon(
              Icons.person_outline,
              color: context.appSubText,
            ),
            filled: true,
            fillColor: context.appCard,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: context.appBorder),
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

  Widget _buildPaymentMethod(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'طريقة الدفع',
          style: TextStyle(color: context.appText, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            // ─ أونلاين ─
            Expanded(
              child: _paymentCard(
                context,
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
                context,
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

  Widget _paymentCard(
    BuildContext context, {
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
              // ignore: deprecated_member_use
              ? AppColors.primaryOrange.withOpacity(0.15)
              : context.appCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : context.appBorder,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryOrange : context.appSubText,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primaryOrange : context.appText,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(color: context.appSubText, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // ─── زر التأكيد ───────────────────────────────────────────

  Widget _buildConfirmButton(BuildContext context) {
    return Obx(() {
      final isLoading = cart.isSubmitting.value;

      return GestureDetector(
        onTap: isLoading
            ? null
            : () async {
                if (_tableController.text.trim().isEmpty) {
                  Get.snackbar(
                    'تنبيه',
                    'الرجاء إدخال رقم الطاولة',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                  return;
                }

                final table = _tableController.text.trim();
                final total = cart.total;

                final order = await cart.submitOrder(
                  tableNumber: table,
                  paymentMethod: _paymentMethod,
                );

                if (order == null) return;

                // if (!Get.isRegistered<OrderSuccessController>()) {
                //   Get.put(OrderSuccessController());
                // }

                Get.off(
                  () => OrderSuccessScreen(
                    tableNumber: table,
                    orderTotal: total.toStringAsFixed(0),
                  ),
                  transition: Transition.fadeIn,
                );
              },
        child: Container(
          height: 55,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 25,
                  height: 25,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  'تأكيد الطلب',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
        ),
      );
    });
  }

  Widget _buildTableField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'رقم الطاولة',
          style: TextStyle(color: context.appText, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _tableController,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          style: TextStyle(color: context.appText),
          decoration: InputDecoration(
            hintText: 'مثال: ١٢',
            hintStyle: TextStyle(color: context.appSubText),
            prefixIcon: Icon(
              Icons.table_restaurant_outlined,
              color: context.appSubText,
            ),
            filled: true,
            fillColor: context.appCard,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: context.appBorder),
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
