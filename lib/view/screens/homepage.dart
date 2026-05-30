import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/view/widgets/custom_container.dart';
import 'package:menubaghdad/view/widgets/custom_icons.dart';
import 'package:menubaghdad/view/widgets/custom_bottom_nav_bar.dart';
import 'package:menubaghdad/view/widgets/custom_text_field.dart';

import '../../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final searchController = TextEditingController();
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return Scaffold( bottomNavigationBar: CustomBottomNavBar(
         
        ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              SizedBox(height: 15),
              CustomTextField(controller: searchController),
              SizedBox(height: 25),
              _BannerOff(context),
              SizedBox(height: 15),
              _allCategory(),
               SizedBox(height: 15),

              _featuredToday(),
                 SizedBox(height: 15),
                 _featuredToday()
            ],
          ),
        ),
      ),
    );
  }

  //──────────────────────────── Header ────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //  icon
          CustomIconContainer(icon: Icons.notifications_outlined),

          //────────── Address + greeting ─────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text(
                    'طاولة رقم ١٢ • فرع الكرادة',
                    style: TextStyle(color: AppColors.greyText, fontSize: 14),
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
                text: const TextSpan(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: 'أهلاً بك في ',
                      style: TextStyle(color: AppColors.white),
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
  Widget _BannerOff(BuildContext context) {
    return Center(
      child: CustomContainer(
        color: AppColors.darkOrange,
        height: 200,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset("assets/image/download.jpg", fit: BoxFit.cover),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.transparent,
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.4),
                      // ignore: deprecated_member_use
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "خصم 20% على \n",
                          style: TextStyle(color: AppColors.white),
                        ),
                        TextSpan(
                          text: ' جميع المشاوي',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //──────────────────────────── Category  ────────────────────────────────────────

  Widget _allCategory() {
    // ignore: non_constant_identifier_names
    List<Map<String, dynamic>> Categoryitems = [
      {"name": "مشاوي"},
      {"name": "بركر"},
      {"name": "بيتزا"},
      {"name": "عصائر"},
      {"name": "ريزو"},
      {"name": "مقبلات"},
      {"name": "شرقي"},
      {"name": "بركر"},
      {"name": "بيتزا"},
      {"name": "عصائر"},
      {"name": "ريزو"},
      {"name": "مقبلات"},
      {"name": "شرقي"},
    ];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "عرض الكل",
                style: TextStyle(fontSize: 15, color: AppColors.primaryOrange),
              ),
              Text(
                "الأقسام",
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 80,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: Categoryitems.length,

              separatorBuilder: (_, _) => const SizedBox(width: 10),

              itemBuilder: (context, index) {
                return Obx(() {
                  final isSelected = controller.selectedCategory.value == index;

                  return GestureDetector(
                    onTap: () => controller.changeCategory(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                      width: isSelected ? 120 : 110,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFFE65100), Color(0xFFFF9800)],
                              )
                            : null,
                        color: isSelected ? null : AppColors.bottomNav,
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
                          color: AppColors.white,
                          fontSize: isSelected ? 18 : 16,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        child: Text(
                          Categoryitems[index]["name"],
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ),
      ],
    );
  }


  //──────────────────────────── featuredToday  ────────────────────────────────────────


  Widget _featuredToday() {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "عرض الكل",
              style: TextStyle(
                color: AppColors.primaryOrange,
                fontSize: 15,
              ),
            ),
            Text(
              "المميز اليوم",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 15),

      SizedBox(
        height: 320,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          reverse: true,
          itemCount: 5,
          separatorBuilder: (_, _) => const SizedBox(width: 15),
          itemBuilder: (context, index) {
            return Container(
              width: 280,
              decoration: BoxDecoration(
                color: AppColors.bottomNav,
                borderRadius: BorderRadius.circular(25),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(25),
                        ),
                        child: Image.asset(
                          "assets/image/download.jpg",
                          height: 170,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffF4A62A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "مميز",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                "4.9",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          "مسكوف بغدادي",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          "سمك مشوي على الطريقة البغدادية الأصيلة",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: AppColors.greyText,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: AppColors.greyText,
                              size: 18,
                            ),

                            const SizedBox(width: 5),

                            const Text(
                              "35 د",
                              style: TextStyle(
                                color: AppColors.greyText,
                              ),
                            ),

                            const Spacer(),

                            Text(
                              "٢٨,٠٠٠ د.ع",
                              style: TextStyle(
                                color: AppColors.primaryOrange,
                                fontSize: 24,
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
            );
          },
        ),
      ),
    ],
  );
}
}
