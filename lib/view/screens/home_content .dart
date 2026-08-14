import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import 'package:menubaghdad/controller/home_controller.dart';
import 'package:menubaghdad/controller/menu_controller.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/view/screens/product_details.dart';
import 'package:menubaghdad/view/widgets/animated_container.dart';
import 'package:menubaghdad/view/widgets/custom_icons.dart';
import 'package:menubaghdad/view/widgets/custom_text_field.dart';
import 'package:menubaghdad/view/widgets/shimmer.dart';

class HomeContent extends StatelessWidget {
  final searchController = TextEditingController();
  final controller = Get.find<HomeController>();
  final AppMenuController menuCtrl = Get.put(AppMenuController());
  HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
    
        if (menuCtrl.isLoading.value) {
          return   const ShimmerHomeLoading();
        }


        return RefreshIndicator(
          color: AppColors.white,
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async => await menuCtrl.fetchMenu(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 15),
                CustomTextField(controller: searchController),
                const SizedBox(height: 25),
                _banner(context),
                const SizedBox(height: 15),
                _allCategory(context),
                const SizedBox(height: 15),
                _featuredToday(context),
                const SizedBox(height: 24),
                   _Mostrequested(context),
              ],
            ),
          ),
        );
      }),
    );
  }

  //──────────────────────────── Header ────────────────────────────────────────

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //  icon
          Row(
            children: [
              CustomIcon(icon: Icons.notifications_outlined ,
              backgroundColor:Theme.of(context).cardColor ,
              iconColor: Theme.of(context).primaryColor,),
              const SizedBox(width: 10),
            ],
          ),

          //────────── Address + greeting ─────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                   Text(
                    'طاولة رقم ١٢ • فرع الكرادة',
                    style: TextStyle(color:Theme.of(context).textTheme.bodyLarge?.color, fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.location_on,
                    color: AppColors.primaryOrange,
                    size: 14,
                  ),
                ],
              ),
              RichText(
                text:  TextSpan(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: 'أهلاً بك في ',

                      style: TextStyle(color:Theme.of(context).textTheme.bodyLarge?.color,),
                    ),
                    TextSpan(
                      text: 'منيو بغداد',
                      style: TextStyle(color: AppColors.primaryOrange),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //──────────────────────────── Banner  ────────────────────────────────────────

  // ignore: non_constant_identifier_names
 Widget _banner(BuildContext context) {
  final screenWidth = MediaQuery.sizeOf(context).width;

  final double bannerHeight = switch (screenWidth) {
    < 600 => 180,  // Mobile
    < 1024 => 280, // Tablet
    _ => 400,      // Laptop & Web
  };

  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: screenWidth < 600 ? 8 : 16,
      vertical: 8,
    ),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Container(
          width: double.infinity,
          height: bannerHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.greyText.withValues(alpha: 0.35),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'assets/image/banner.jpeg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

  //──────────────────────────── Category  ────────────────────────────────────────

  Widget _allCategory(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'عرض الكل',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.primaryOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'الأقسام',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 48,
          child: Obx(() {
            final allCategories = menuCtrl.categories;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: allCategories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final cat = allCategories[index];

                  return Obx(() {
                    final isSelected =
                        controller.selectedCategory.value == index;

                    return GestureDetector(
                      onTap: () => controller.changeCategory(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.15),
                            width: 1,
                          ),
                          gradient: isSelected
                              ? LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Theme.of(context).primaryColor,
                                    const Color(0xFFFF9800),
                                  ],
                                )
                              : null,
                          color: isSelected ? null : Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    blurRadius: 10,
                                    // ignore: deprecated_member_use
                                    color: AppColors.primaryOrange.withOpacity(
                                      0.3,
                                    ),
                                  ),
                                ]
                              : [],
                        ),
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: isSelected ? 16 : 15,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          child: Text(
                            cat['name'],
                            textAlign: TextAlign.center,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    );
                  });
                },
              ),
            );
          }),
        ),
      ],
    );
  }
  //──────────────────────────── featuredToday  ────────────────────────────────────────

  Widget _featuredToday(BuildContext context) {
    return Obx(() {


final selectedIndex = controller.selectedCategory.value;
final selectedCatId = menuCtrl.categories.isNotEmpty
    ? menuCtrl.categories[selectedIndex]['id']
    : null;

final filtered = menuCtrl.menuItems.where((item) {
  // "الكل" = ID الصفري → ما نفلتر
  final isAll = selectedCatId == '00000000-0000-0000-0000-000000000000';
  final matchesCategory = isAll || item['category_id'] == selectedCatId;

  final query = menuCtrl.searchQuery.value.toLowerCase();
  final matchesSearch = query.isEmpty ||
      item['name'].toString().toLowerCase().contains(query) ||
      (item['description'] ?? '').toString().toLowerCase().contains(query);

  return matchesCategory && matchesSearch;
}).toList();

      // ─── لو ما في وجبات في هذا القسم ───────
      if (filtered.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(40),
          child: Center(
            child: Column(
              children: [
                const Icon(
                  Icons.search_off,
                  color: AppColors.greyText,
                  size: 50,
                ),
                const SizedBox(height: 12),
                // ─ رسالة مختلفة حسب السبب ─
                Text(
                  menuCtrl.searchQuery.value.isNotEmpty
                      ? 'لا نتائج لـ "${menuCtrl.searchQuery.value}"'
                      : 'لا توجد وجبات في هذا القسم',
                  style: const TextStyle(
                    color: AppColors.greyText,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }

      // ─── عرض الوجبات المفلترة ───────────────
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'عرض الكل',
                  style: TextStyle(
                    color: AppColors.primaryOrange,
                    fontSize: 15,
                  ),
                ),
                Text(
                  ' المميز اليوم',
                  style: TextStyle(
                    color: context.appText,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 360,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemCount: filtered.length, // ← عدد الوجبات المفلترة
              separatorBuilder: (_, _) => const SizedBox(width: 15),
              itemBuilder: (context, index) {
                final item = filtered[index]; // ← كل وجبة من Supabase

                return InkWell(
                  onTap: () => Get.to(DetailScreen(item: item)),
                  child: Container(
                    width: 280,
                    decoration: BoxDecoration(
                      color: context.appCard,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // ─ الصورة ─
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),

                              child:
                                  (item['image_url'] != null &&
                                      item['image_url'].toString().startsWith(
                                        'http',
                                      ))
                                  ? Image.network(
                                      item['image_url'],
                                      height: 170,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, _, _) => Image.asset(
                                        'assets/image/download.jpg',
                                        height: 170,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      'assets/image/download.jpg',
                                      height: 170,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      '4.9',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        // ─ المعلومات من Supabase ─
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                item['name'], // ← الاسم الحقيقي
                                style: TextStyle(
                                  color: context.appText,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['description'] ?? '',
                                style: TextStyle(
                                  color: context.appSubText,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: context.appSubText,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${item['preparation_time']} د', // ← وقت حقيقي
                                    style: TextStyle(
                                      color: context.appSubText,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${item['price']} د.ع', // ← سعر حقيقي
                                    style: const TextStyle(
                                      color: AppColors.primaryOrange,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }



// ignore: non_constant_identifier_names
Widget _Mostrequested(BuildContext context) {
  return Obx(() {
    final selectedIndex = controller.selectedCategory.value;
    final selectedCatId = menuCtrl.categories.isNotEmpty
        ? menuCtrl.categories[selectedIndex]['id']
        : null;

    final filtered = menuCtrl.menuItems.where((item) {
      final isAll = selectedCatId == '00000000-0000-0000-0000-000000000000';
      final matchesCategory = isAll || item['category_id'] == selectedCatId;
      final query = menuCtrl.searchQuery.value.toLowerCase();
      final matchesSearch = query.isEmpty ||
          item['name'].toString().toLowerCase().contains(query) ||
          (item['description'] ?? '').toString().toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();

    if (filtered.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              const Icon(Icons.search_off, color: AppColors.greyText, size: 50),
              const SizedBox(height: 12),
              Text(
                menuCtrl.searchQuery.value.isNotEmpty
                    ? 'لا نتائج لـ "${menuCtrl.searchQuery.value}"'
                    : 'لا توجد وجبات في هذا القسم',
                style: const TextStyle(color: AppColors.greyText, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // ─── الهيدر ───────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'عرض الكل',
                style: TextStyle(color: AppColors.primaryOrange, fontSize: 15),
              ),
              Text(
                'الأكثر طلباً',
                style: TextStyle(
                  color: context.appText,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),

        // ─── القائمة العمودية ──────────────────────
        ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filtered.length,
          separatorBuilder: (_, _) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final item = filtered[index];

            return InkWell(
              // onTap: () => Get.to(DetailScreen(item: item)),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                decoration: BoxDecoration(
                  color: context.appCard,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // ─ زر الإضافة ─
                    ShakingCard(
                      child: InkWell( onTap: () => Get.to(DetailScreen(item: item)),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color:  Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // ─ المعلومات ─
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item['name'],
                            style: TextStyle(
                              color: context.appText,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['description'] ?? '',
                            style: TextStyle(
                              color: context.appSubText,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item['price']} د.ع',
                                style: const TextStyle(
                                  color: AppColors.primaryOrange,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // ─ التقييم ─
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      color: Colors.amber, size: 14),
                                  const SizedBox(width: 3),
                                  Text(
                                    '4.9',
                                    style: TextStyle(
                                        color: context.appSubText, fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),

                    // ─ الصورة ─
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: (item['image_url'] != null &&
                              item['image_url'].toString().startsWith('http'))
                          ? Image.network(
                              item['image_url'],
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Image.asset(
                                'assets/image/download.jpg',
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              'assets/image/download.jpg',
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  });
}

  //──────────────────────────── setting  ────────────────────────────────────────

//   Widget _settingItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.orange),
//       title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
//       trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//       onTap: onTap,
//     );
//   }
 }
