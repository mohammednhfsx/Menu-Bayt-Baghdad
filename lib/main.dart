import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:menubaghdad/view/screens/splash_screen.dart';

import 'controller/home_controller.dart';

void main() {
      Get.put(HomeController());
    

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}