import 'package:get/get.dart';
import 'package:menubaghdad/controller/home_controller.dart';

import '../core/supabase_client.dart';

class AppMenuController  extends GetxController {
  // البيانات
  final RxList categories = [].obs;
  final RxList menuItems = [].obs;
  final RxBool isLoading = true.obs;

    final RxString searchQuery = ''.obs;

  void search(String query) {
  searchQuery.value = query.trim();

  // لما يبحث، روّح لـ "الكل" تلقائياً
  if (query.isNotEmpty) {
    Get.find<HomeController>().selectedCategory.value = 0;
  }
}

  // ID المطعم الحالي — لاحقاً يجي من QR Code
  final String restaurantId = '11111111-1111-1111-1111-111111111111';

  @override
  void onInit() {
    super.onInit();
    fetchMenu();
  }

 Future<void> fetchMenu() async {
    try {
      isLoading.value = true;

      // جلب التصنيفات
      final catResponse = await supabase
          .from('categories')
          .select()
          .eq('restaurant_id', restaurantId)
          .order('sort_order');

      // جلب الوجبات المتاحة فقط
      final itemsResponse = await supabase
          .from('menu_items')
          .select('*, categories!inner(restaurant_id)')
          .eq('categories.restaurant_id', restaurantId)
          .eq('is_available', true);

      categories.assignAll(catResponse);
      menuItems.assignAll(itemsResponse);

    } catch (e) {
      Get.snackbar('خطأ', 'تعذر تحميل المنيو: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
