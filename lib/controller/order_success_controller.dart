

import 'dart:async';
import 'package:get/get.dart';

class OrderSuccessController extends GetxController {
  
  final int totalSeconds = 30 * 60;
  final RxInt secondsLeft = (30 * 60).obs;
  
  Timer? _timer;

  // ─── حسابات تلقائية ───────────────────────
  String get timeFormatted {
    final m = secondsLeft.value ~/ 60;
    final s = secondsLeft.value % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  double get progress => 1 - (secondsLeft.value / totalSeconds);

  String get statusMessage {
    if (secondsLeft.value > 20 * 60) return '🍳 المطبخ بدأ التحضير';
    if (secondsLeft.value > 5 * 60)  return '⏳ طلبك على وشك الجهوز';
    return '✅ طلبك جاهز تقريباً!';
  }

  bool get isAlmostDone => secondsLeft.value < 5 * 60;

  // ─── تشغيل العداد ─────────────────────────
  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsLeft.value <= 0) {
        _timer?.cancel();
      } else {
        secondsLeft.value--;
      }
    });
  }

  // لاحقاً — نمرر الوقت الفعلي من Supabase
  void setDuration(int seconds) {
    _timer?.cancel();
    secondsLeft.value = seconds;
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel(); // يتوقف تلقائياً لما تُغلق الشاشة
    super.onClose();
  }
}