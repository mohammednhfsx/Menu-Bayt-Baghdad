// lib/view/screens/cart_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/cart_controller.dart';
import 'package:menubaghdad/controller/home_controller.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/view/screens/order_confirm_screen.dart';
import 'package:menubaghdad/view/widgets/animated_container.dart';
import '../../core/size_extensions.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});

  // controller واحد مشترك — Get.find لأنه مسجّل مسبقاً
  final CartController cart = Get.find<CartController>();
  final _couponCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Obx(() {
                // لو السلة فارغة نعرض شاشة فارغة
                if (cart.items.isEmpty) return _buildEmptyState(context);
                return _buildCartContent(context);
              }),
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
          Obx(
            () => Text(
              '${cart.itemCount} أصناف',
              style: TextStyle(color: context.appSubText, fontSize: 14),
            ),
          ),
          Text(
            'سلة الطلبات',
            style: TextStyle(
              color: context.appText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () => Get.find<HomeController>().changePage(1),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: context.appCard,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: context.appText,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Empty State ──────────────────────────────────────────

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       
          const SizedBox(height: 16),
          Text(
            'سلتك فارغة',
            style: TextStyle(
              color: context.appText,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => Get.find<HomeController>().changePage(1),
            child: ShakingCard(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE65100), Color(0xFFFF9800)],
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  'تصفح المنيو',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── Cart Content ─────────────────────────────────────────

  Widget _buildCartContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // قائمة الأصناف
          Obx(
            () => Column(
              children: cart.items
                  .map((item) => _buildCartItem(item, context))
                  .toList(),
            ),
          ),

          const SizedBox(height: 16),
          _buildCouponField(context),
          const SizedBox(height: 16),
          _buildPriceSummary(context),
          const SizedBox(height: 16),
          _buildOrderButton(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // ─── Cart Item Card ───────────────────────────────────────

  Widget _buildCartItem(dynamic item, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: AppSize.screenHeight(context) * 0.12,
      decoration: BoxDecoration(
        color: context.appCard,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // ─ أزرار الكمية والحذف ─
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // زر الحذف
                GestureDetector(
                  onTap: () => cart.removeItem(item.id),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.delete_outlined,
                      color: Colors.red,
                      size: 18,
                    ),
                  ),
                ),
                // + / - buttons
                Container(
                  width: 95,
                  height: 37,
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: context.appBackground.withOpacity(0.5),
                    border: Border.all(color: context.appBorder),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       _qtyButton(Icons.add, () => cart.increment(item.id)),
                      Text(
                        '${item.quantity}',
                        style: TextStyle(color: context.appText),
                      ),
                      _qtyButton(Icons.remove, () => cart.decrement(item.id)),
                    ],
                  ),
                ),
              ],
            ),

            const Spacer(),

            // ─ معلومات الصنف ─
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                    color: context.appText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.description,
                  style: TextStyle(
                    color: context.appSubText,
                    fontSize: 10,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${item.totalPrice.toStringAsFixed(0)} د.ع',
                  style: const TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(width: 10),

            // ─ صورة الصنف ─
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: AppSize.screenWidth(context) * 0.20,
                height: double.infinity,
                child:
                    (item.imageUrl != null && item.imageUrl!.startsWith('http'))
                    ? Image.network(
                        item.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Image.asset(
                          'assets/image/download.jpg',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/image/download.jpg',
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFE65100), Color(0xFFFF9800)],
          ),
        ),
        child: Icon(icon, color: Colors.black, size: 18),
      ),
    );
  }

  // ─── Coupon Field ─────────────────────────────────────────

  Widget _buildCouponField(BuildContext context) {
    return TextFormField(
      controller: _couponCtrl,
      cursorColor: context.appSubText,
      textAlign: TextAlign.right,
      style: TextStyle(color: context.appText),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () => cart.applyCoupon(_couponCtrl.text.trim()),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryOrange,
              foregroundColor: Colors.black,
            ),
            child: const Text('تطبيق'),
          ),
        ),
        suffixIcon: const Icon(
          Icons.sell_outlined,
          color: AppColors.primaryOrange,
        ),
        hintText: 'ادخل كوبون الخصم',
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: context.appSubText,
        ),
        filled: true,
        // ignore: deprecated_member_use
        fillColor: context.appSearchFill.withOpacity(0.3),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: context.appBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(color: context.appBorder),
        ),
      ),
    );
  }

  // ─── Price Summary ────────────────────────────────────────

  Widget _buildPriceSummary(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.appCard,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            _priceRow(
              context,
              'المجموع الفرعي',
              '${cart.subtotal.toStringAsFixed(0)} د.ع',
            ),
            const SizedBox(height: 12),
            _priceRow(
              context,
              'الخصم',
              '- ${cart.discountAmount.value.toStringAsFixed(0)} د.ع',
              valueColor: Colors.green,
            ),
            Divider(color: context.appBorder, height: 24),
            _priceRow(
              context,
              'الإجمالي',
              '${cart.total.toStringAsFixed(0)} د.ع',
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(
    BuildContext context,
    String label,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? context.appText,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 18 : 14,
          ),
        ),
        Text(label, style: TextStyle(color: context.appSubText)),
      ],
    );
  }

  // ─── Order Button ─────────────────────────────────────────

  Widget _buildOrderButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cart.items.isEmpty) return;

        Get.to(const OrderConfirmScreen(), transition: Transition.downToUp);
      },
      child: Container(
        width: double.infinity,
        height: AppSize.screenHeight(context) * 0.065,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: const LinearGradient(
            colors: [Color(0xFFE65100), Color(0xFFFF9800)],
          ),
        ),
        child: const Center(
          child: Text(
            'إرسال الطلب',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
