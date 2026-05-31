import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:menubaghdad/view/screens/cart_screen.dart';
import 'package:menubaghdad/view/screens/home_content%20.dart';
import 'package:menubaghdad/view/screens/orders_screen.dart';

import 'package:menubaghdad/view/widgets/custom_bottom_nav_bar.dart';


import '../../controller/home_controller.dart';



class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.find<HomeController>();

final pages = [
  CartScreen(),
  HomeContent(), 
  OrdersScreen(),
];

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     
      
  
      backgroundColor: const Color.fromARGB(255, 24, 4, 0),
      body: 
       Obx(
      () => pages[controller.selectedIndex.value],
    ),
    bottomNavigationBar: const CustomBottomNavBar(),
  );
}}