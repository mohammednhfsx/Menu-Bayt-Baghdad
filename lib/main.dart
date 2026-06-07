import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/cart_controller.dart';
import 'package:menubaghdad/controller/order_controller.dart';

import 'package:menubaghdad/core/localization/local_change.dart';
import 'package:menubaghdad/core/services/services.dart';
import 'package:menubaghdad/core/supabase_config.dart';

import 'package:menubaghdad/view/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controller/home_controller.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();

  // تهيئة Supabase 
  await Supabase.initialize(
    url:    SupabaseConfig.url,
    // ignore: deprecated_member_use
    anonKey: SupabaseConfig.anonKey,
  );

    await initialServices();
    Get.put(LocaleController());
  Get.put(HomeController());
  Get.put(CartController()); 

  Get.put(OrdersController());


  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        locale: Get.find<LocaleController>().language,
      fallbackLocale: const Locale('ar'),
      home: SplashScreen(),
    );
  }
}
