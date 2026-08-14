import 'package:get/get.dart';
import 'package:menubaghdad/controller/home_controller.dart';
import 'package:menubaghdad/core/dummy_data.dart';

class AppMenuController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    fetchMenu();
  }

  Future<void> fetchMenu() async {
    try {
      isLoading.value = true;

      // محاكاة تأخير بسيط لإظهار أنيميشن الـ Shimmer الأنيق
      await Future.delayed(const Duration(milliseconds: 400));

      categories.assignAll(DummyData.categories);
      menuItems.assignAll(DummyData.menuItems);
    } catch (e) {
      Get.snackbar('خطأ', 'تعذر تحميل المنيو: $e');
    } finally {
      isLoading.value = false;
    }
  }
}

