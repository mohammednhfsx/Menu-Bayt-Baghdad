import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt selectedCategory = 0.obs;
  RxInt selectedIndex = 1.obs;

  void changeCategory(int index) {
    selectedCategory.value = index;
  }

  void changePage(int index) {
    selectedIndex.value = index;
  }
}