import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/controller/cart_controller.dart';
import 'package:menubaghdad/controller/order_controller.dart';
import 'package:menubaghdad/core/localization/local_change.dart';
import 'package:menubaghdad/core/services/services.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/core/theme/theme_app.dart';
import 'package:menubaghdad/view/screens/splash_screen.dart';
import 'controller/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  Get.put(LocaleController());
  Get.put(HomeController());
  Get.put(CartController());
  Get.put(OrdersController());
  final themeController = Get.put(ThemeController());
  // انتظر تحميل الثيم المحفوظ
  await Future.delayed(const Duration(milliseconds: 100));
  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;
  const MyApp({super.key, required this.themeController});
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeController.isDark.value
              ? ThemeMode.dark
              : ThemeMode.light,
          locale: Get.find<LocaleController>().language,
          fallbackLocale: const Locale('ar'),
          home: SplashScreen(),
        ));
  }
}

