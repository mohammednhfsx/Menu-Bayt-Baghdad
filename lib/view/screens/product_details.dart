import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/cart_controller.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/model/cart_model.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> item; // ← أضفنا
  const DetailScreen({super.key, required this.item}); // ← أضفنا
  
  @override
  State<DetailScreen> createState() => _ItemDetailScreenState();
}

class _Extra {
  final String name;
  final String price;
  final double extraPrice;
  bool selected;
  _Extra({
    required this.name,
    required this.price,
    required this.extraPrice,
    this.selected = false,
  });
}

class _ItemDetailScreenState extends State<DetailScreen> {
  int _qty = 1;

  // ← السعر من الـ item الحقيقي
  double get _basePrice =>
      (widget.item['price'] as num).toDouble();

  final List<_Extra> _extras = [
    _Extra(name: 'رز إضافي', price: '+٢,٠٠٠ د.ع', extraPrice: 2000),
    _Extra(name: 'صلصة طحينة', price: '+١,٥٠٠ د.ع', extraPrice: 1500),
  ];

  double get _total {
    double extra = 0;
    for (final e in _extras) {
      if (e.selected) extra += e.extraPrice;
    }
    return (_basePrice + extra) * _qty;
  }

  String _formatPrice(double v) {
    final s = v.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return '$s د.ع';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildImageSliver(),
              SliverToBoxAdapter(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildBadgeRow(),
                        const SizedBox(height: 14),
                        _buildTitleSection(),
                        const SizedBox(height: 20),
                        _buildInfoRow(),
                        const SizedBox(height: 24),
                        _buildExtrasSection(),
                        const SizedBox(height: 24),
                        _buildQtyRow(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(bottom: 0, left: 0, right: 0, child: _buildBottomBar()),
        ],
      ),
    );
  }

  // ── Image ───────────────────────────────────────────────────
  Widget _buildImageSliver() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: false,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // ← صورة حقيقية أو افتراضية
            (widget.item['image_url'] != null &&
                    widget.item['image_url'].toString().startsWith('http'))
                ? Image.network(
                    widget.item['image_url'],
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

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.background],
                  stops: [0.55, 1.0],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _circleBtn(Icons.arrow_back_ios,
                      onTap: () => Navigator.maybePop(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleBtn(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
            color: Colors.black45, shape: BoxShape.circle),
        child: Icon(icon, color: AppColors.white, size: 20),
      ),
    );
  }

  // ── Badges ──────────────────────────────────────────────────
  Widget _buildBadgeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _badge(Icons.local_fire_department, '720 سعرة', AppColors.darkOrange),
        const SizedBox(width: 8),
        // ← وقت حقيقي
        _badge(Icons.access_time,
            '${widget.item['preparation_time']} دقيقة', AppColors.greyText),
        const SizedBox(width: 8),
        _badge(Icons.star, '4.8', AppColors.primaryOrange),
      ],
    );
  }

  Widget _badge(IconData icon, String label, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(children: [
        Icon(icon, color: iconColor, size: 14),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(color: AppColors.white, fontSize: 12)),
      ]),
    );
  }

  // ── Title ───────────────────────────────────────────────────
  Widget _buildTitleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
        Text(
          widget.item['name'] ?? '',
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        const Text('السعر',
            style: TextStyle(color: AppColors.greyText, fontSize: 12)),
        const SizedBox(height: 2),
        Text(
          _formatPrice(_basePrice),
          style: const TextStyle(
            color: AppColors.Orange,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        // ← وصف حقيقي
        Text(
          widget.item['description'] ?? '',
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: AppColors.greyText,
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ── Info Row ────────────────────────────────────────────────
  Widget _buildInfoRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.07)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ← وقت حقيقي
          _infoCell('الوقت', '${widget.item['preparation_time']} د'),
          _divider(),
          _infoCell('السعرات', 'kcal 720'),
          _divider(),
          _infoHeatCell(),
        ],
      ),
    );
  }

  Widget _infoCell(String label, String value) {
    return Column(children: [
      Text(label,
          style: const TextStyle(color: AppColors.greyText, fontSize: 12)),
      const SizedBox(height: 4),
      Text(value,
          style: const TextStyle(
              color: AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600)),
    ]);
  }

  Widget _infoHeatCell() {
    return Column(children: [
      const Text('درجة الحرارة',
          style: TextStyle(color: AppColors.greyText, fontSize: 12)),
      const SizedBox(height: 4),
      const Row(children: [
        Icon(Icons.local_fire_department, color: AppColors.Orange, size: 18),
        Icon(Icons.local_fire_department, color: AppColors.Orange, size: 18),
      ]),
    ]);
  }

  Widget _divider() => Container(
      width: 1, height: 36, color: const Color.fromARGB(31, 248, 229, 229));

  // ── Extras ──────────────────────────────────────────────────
  Widget _buildExtrasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('إضافات',
            style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ..._extras.map((e) => _extraTile(e)),
      ],
    );
  }

  Widget _extraTile(_Extra extra) {
    return GestureDetector(
      onTap: () => setState(() => extra.selected = !extra.selected),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: extra.selected
                ? AppColors.Orange
                : Colors.white.withOpacity(0.08),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: extra.selected
                        ? AppColors.Orange
                        : AppColors.greyText,
                    width: 2),
                color:
                    extra.selected ? AppColors.Orange : Colors.transparent,
              ),
              child: extra.selected
                  ? const Icon(Icons.check, color: AppColors.white, size: 14)
                  : null,
            ),
            Row(children: [
              Text(extra.price,
                  style: const TextStyle(
                      color: AppColors.greyText, fontSize: 14)),
              const SizedBox(width: 12),
              Text(extra.name,
                  style: const TextStyle(
                      color: AppColors.white, fontSize: 15)),
            ]),
          ],
        ),
      ),
    );
  }

  // ── Quantity ────────────────────────────────────────────────
  Widget _buildQtyRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          _qtyBtn(Icons.add, () => setState(() => _qty++)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('$_qty',
                style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          _qtyBtn(Icons.remove,
              _qty > 1 ? () => setState(() => _qty--) : null),
        ]),
        const Text('الكمية',
            style: TextStyle(
                color: AppColors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.Orange,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: AppColors.white, size: 20),
      ),
    );
  }

  // ── Bottom Bar ──────────────────────────────────────────────
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
      decoration: BoxDecoration(
        color: AppColors.bottomNav,
        border:
            Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('المجموع',
                    style: TextStyle(
                        color: AppColors.greyText, fontSize: 12)),
                Text(
                  _formatPrice(_total),
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  final cart = Get.find<CartController>();

                  // ← بيانات حقيقية من widget.item
                  cart.addItem(CartItem(
                    id: widget.item['id'],
                    name: widget.item['name'],
                    description: widget.item['description'] ?? '',
                    price: _basePrice,
                    imageAsset: widget.item['image_url'] ?? 
                                'assets/image/download.jpg',
                    quantity: _qty,
                  ));

                  Get.back();
                  Get.snackbar(
                    'تمت الإضافة',
                    '${widget.item['name']} أُضيف للسلة',
                    backgroundColor: AppColors.darkOrange,
                    colorText: AppColors.white,
                  );
                },
                child: Container(
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xFFE65100), Color(0xFFFF9800)]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chevron_left, color: AppColors.white),
                      SizedBox(width: 6),
                      Text('أضف للسلة',
                          style: TextStyle(
                              color: AppColors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}