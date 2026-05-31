
import 'package:get/get.dart';

class CartController extends GetxController {

  RxInt itemTotal = 1.obs;

  void increment(){
    itemTotal.value++;
  }

  void decrement(){
    if(itemTotal.value != 1){
      itemTotal.value--;
    }
  }

}