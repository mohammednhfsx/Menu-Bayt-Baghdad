import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/core/localization/local_change.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/core/theme/theme_app.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String selectedLang = 'ar';
  bool isDark = false;
    final LocaleController localeCtrl = Get.find<LocaleController>();
    final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('الإعدادات',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),

              _buildSectionTitle('التفضيلات'),
              const SizedBox(height: 12),
              _buildLanguageTile(),
              const SizedBox(height: 10),
              _buildThemeTile(),
              const SizedBox(height: 24),

              _buildSectionTitle('الدعم'),
              const SizedBox(height: 12),
              _buildTile(
                icon: Icons.support_agent,
                title: 'الدعم الفني',
                subtitle: 'تواصل مع فريق الدعم',
                onTap: _showSupportDialog,
              ),
              const SizedBox(height: 10),
              _buildTile(
                icon: Icons.feedback_outlined,
                title: 'إرسال ملاحظة',
                subtitle: 'شاركنا رأيك أو اقتراحك',
                onTap: _showFeedbackDialog,
              ),
              const SizedBox(height: 10),
              _buildTile(
                icon: Icons.help_outline,
                title: 'الأسئلة الشائعة',
                subtitle: 'إجابات على أكثر الأسئلة شيوعاً',
                onTap: () => Get.snackbar('قريباً', 'هذه الميزة قيد التطوير',
                    backgroundColor: AppColors.cardColor,
                    colorText: AppColors.white),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('عن التطبيق'),
              const SizedBox(height: 12),
              _buildTile(
                icon: Icons.info_outline,
                title: 'الإصدار',
                subtitle: 'v1.0.0',
                onTap: null,
                showArrow: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── عنوان القسم ──────────────────────────────

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(title,
          style: const TextStyle(
              color: AppColors.primaryOrange,
              fontSize: 13,
              fontWeight: FontWeight.bold)),
    );
  }

  // ─── تايل عام ─────────────────────────────────

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    bool showArrow = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            if (showArrow)
              const Icon(Icons.arrow_forward_ios,
                  color: AppColors.greyText, size: 16),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: const TextStyle(
                        color: AppColors.greyText, fontSize: 12)),
              ],
            ),
            const SizedBox(width: 12),
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: AppColors.primaryOrange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child:
                  Icon(icon, color: AppColors.primaryOrange, size: 22),
            ),
          ],
        ),
      ),
    );
  }

  // ─── تايل اللغة ───────────────────────────────

  Widget _buildLanguageTile() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: AppColors.cardColor,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.border),
    ),
    child: Row(
      children: [
        // ← Obx لأن selectedLang هو RxString
        Obx(() => Row(children: [
          _langBtn('EN', 'en'),
          const SizedBox(width: 8),
          _langBtn('عربي', 'ar'),
        ])),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text('اللغة',
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 3),
            Text('اختر لغة التطبيق',
                style: TextStyle(
                    color: AppColors.greyText, fontSize: 12)),
          ],
        ),
        const SizedBox(width: 12),
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: AppColors.primaryOrange.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.language,
              color: AppColors.primaryOrange, size: 22),
        ),
      ],
    ),
  );
}

 Widget _langBtn(String label, String value) {
  // ← يقرأ من LocaleController مباشرة
  final isSelected = localeCtrl.selectedLang.value == value;

  return GestureDetector(
    onTap: () => localeCtrl.changeLang(value), // ← يغير اللغة ويحفظها
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryOrange : AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isSelected ? AppColors.primaryOrange : AppColors.border,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : AppColors.greyText,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    ),
  );
}

  // ─── تايل الثيم ───────────────────────────────

  Widget _buildThemeTile() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Switch(
            value: isDark,
      onChanged: (val) {
        setState(() {
          isDark = val;
        });

        themeController.togglerTheme(val);
              Get.snackbar(
                'المظهر',
                val ? 'الوضع الداكن' : 'الوضع الفاتح',
                backgroundColor: AppColors.white,
                colorText: AppColors.background,
              );
            },
            activeThumbColor: AppColors.primaryOrange,
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('المظهر',
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 3),
              Text(
                isDark ? 'الوضع الداكن' : 'الوضع الفاتح',
                style: const TextStyle(
                    color: AppColors.greyText, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: AppColors.primaryOrange.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isDark
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
              color: AppColors.primaryOrange,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Dialog الدعم ─────────────────────────────

  void _showSupportDialog() {
    Get.dialog(
      Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AppColors.cardColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: const Text('الدعم الفني',
              style: TextStyle(color: AppColors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('تواصل معنا عبر:',
                  style: TextStyle(color: AppColors.greyText)),
              const SizedBox(height: 16),
              _contactRow(
                  Icons.email_outlined, 'support@menubaghdad.com'),
              const SizedBox(height: 10),
              _contactRow(
                  Icons.phone_outlined, '+964 750 000 0000'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('إغلاق',
                  style:
                      TextStyle(color: AppColors.primaryOrange)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Row(children: [
      Icon(icon, color: AppColors.primaryOrange, size: 18),
      const SizedBox(width: 10),
      Text(text, style: const TextStyle(color: AppColors.white)),
    ]);
  }

  // ─── Dialog الملاحظات ─────────────────────────

  void _showFeedbackDialog() {
    final feedbackCtrl = TextEditingController();
    Get.dialog(
      Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: AppColors.cardColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: const Text('إرسال ملاحظة',
              style: TextStyle(color: AppColors.white)),
          content: TextField(
            controller: feedbackCtrl,
            maxLines: 4,
            style: const TextStyle(color: AppColors.white),
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'اكتب ملاحظتك أو اقتراحك هنا...',
              hintStyle: const TextStyle(
                  color: AppColors.greyText, fontSize: 13),
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                    color: AppColors.primaryOrange),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('إلغاء',
                  style:
                      TextStyle(color: AppColors.greyText)),
            ),
            TextButton(
              onPressed: () {
                if (feedbackCtrl.text.trim().isEmpty) return;
                Get.back();
                Get.snackbar(
                  '✅ شكراً!',
                  'تم إرسال ملاحظتك بنجاح',
                  backgroundColor: AppColors.primaryOrange,
                  colorText: Colors.white,
                );
              },
              child: const Text('إرسال',
                  style: TextStyle(
                      color: AppColors.primaryOrange)),
            ),
          ],
        ),
      ),
    );
  }
}