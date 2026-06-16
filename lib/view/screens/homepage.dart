import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:menubaghdad/view/screens/cart_screen.dart';
import 'package:menubaghdad/view/screens/home_content%20.dart';
import 'package:menubaghdad/view/screens/orders_screen.dart';
import 'package:menubaghdad/view/screens/setting.dart';

import 'package:menubaghdad/view/widgets/custom_bottom_nav_bar.dart';

import '../../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.find<HomeController>();

  final pages = [CartPage(), HomeContent(), OrdersScreen(), Setting()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children:[ Obx(() => pages[controller.selectedIndex.value]),
        const CustomBottomNavBar(),]),
     
    );
  }
}
