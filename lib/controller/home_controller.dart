import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  RxInt selectedCategory = 0.obs;
   final selectedIndex = 3.obs;

  void changeCategory(int index) {
    selectedCategory.value = index;
  }
 

  void changePage(int index) {
    selectedIndex.value = index;
  }
}