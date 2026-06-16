import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menubaghdad/core/localization/local_change.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/core/theme/theme_app.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final LocaleController localeCtrl = Get.find<LocaleController>();
    final ThemeController themeCtrl = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'الإعدادات',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle(context, 'التفضيلات'),
              const SizedBox(height: 12),
              _buildLanguageTile(context, localeCtrl),
              const SizedBox(height: 10),
              _buildThemeTile(context, themeCtrl),
              const SizedBox(height: 24),

              _buildSectionTitle(context, 'الدعم'),
              const SizedBox(height: 12),
              _buildTile(
                context: context,
                icon: Icons.support_agent,
                title: 'الدعم الفني',
                subtitle: 'تواصل مع فريق الدعم',
                onTap: () => _showSupportDialog(context),
              ),
              const SizedBox(height: 10),
              _buildTile(
                context: context,
                icon: Icons.feedback_outlined,
                title: 'إرسال ملاحظة',
                subtitle: 'شاركنا رأيك أو اقتراحك',
                onTap: () => _showFeedbackDialog(context),
              ),
              const SizedBox(height: 10),
              _buildTile(
                context: context,
                icon: Icons.help_outline,
                title: 'الأسئلة الشائعة',
                subtitle: 'إجابات على أكثر الأسئلة شيوعاً',
                onTap: () => Get.snackbar(
                  'قريباً',
                  'هذه الميزة قيد التطوير',
                  backgroundColor: Theme.of(context).cardColor,
                  colorText: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle(context, 'عن التطبيق'),
              const SizedBox(height: 12),
              _buildTile(
                context: context,
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
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryOrange,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ─── تايل عام ─────────────────────────────────
  Widget _buildTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback? onTap,
    bool showArrow = true,
  }) {
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final subColor = Theme.of(context).hintColor;
    final cardBg = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: context.isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Row(
          children: [
            if (showArrow)
              Icon(Icons.arrow_forward_ios, color: subColor, size: 16),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(title,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(subtitle,
                    style: TextStyle(color: subColor, fontSize: 12)),
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
              child: Icon(icon, color: AppColors.primaryOrange, size: 22),
            ),
          ],
        ),
      ),
    );
  }

  // ─── تايل اللغة ───────────────────────────────
  Widget _buildLanguageTile(BuildContext context, LocaleController localeCtrl) {
    final cardBg = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final subColor = Theme.of(context).hintColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
        boxShadow: context.isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ],
      ),
      child: Row(
        children: [
          Obx(() => Row(children: [
                _langBtn(context, localeCtrl, 'EN', 'en'),
                const SizedBox(width: 8),
                _langBtn(context, localeCtrl, 'عربي', 'ar'),
              ])),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('اللغة',
                  style: TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 3),
              Text('اختر لغة التطبيق',
                  style: TextStyle(color: subColor, fontSize: 12)),
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

  Widget _langBtn(
      BuildContext context, LocaleController localeCtrl, String label, String value) {
    final isSelected = localeCtrl.selectedLang.value == value;
    final bgColor = context.isDark ? AppColors.background : AppColors.lightBackground;
    final borderColor = context.isDark ? AppColors.border : AppColors.lightBorder;

    return GestureDetector(
      onTap: () => localeCtrl.changeLang(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryOrange : bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.primaryOrange : borderColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Theme.of(context).hintColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // ─── تايل الثيم ───────────────────────────────
  Widget _buildThemeTile(BuildContext context, ThemeController themeCtrl) {
    final cardBg = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final subColor = Theme.of(context).hintColor;

    return Obx(() {
      final dark = themeCtrl.isDark.value;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor),
          boxShadow: context.isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
        ),
        child: Row(
          children: [
            Switch(
              value: dark,
              onChanged: (val) {
                themeCtrl.setDark(val);
                Get.snackbar(
                  'المظهر',
                  val ? 'الوضع الداكن' : 'الوضع الفاتح',
                  backgroundColor: AppColors.primaryOrange,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              },
              activeColor: AppColors.primaryOrange,
              activeTrackColor:
                  // ignore: deprecated_member_use
                  AppColors.primaryOrange.withOpacity(0.3),
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('المظهر',
                    style: TextStyle(
                        color: textColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(
                  dark ? 'الوضع الداكن' : 'الوضع الفاتح',
                  style: TextStyle(color: subColor, fontSize: 12),
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
                dark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                color: AppColors.primaryOrange,
                size: 22,
              ),
            ),
          ],
        ),
      );
    });
  }

  // ─── Dialog الدعم ─────────────────────────────
  void _showSupportDialog(BuildContext context) {
    Get.dialog(
      Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('الدعم الفني',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge?.color)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('تواصل معنا عبر:',
                  style: TextStyle(color: Theme.of(context).hintColor)),
              const SizedBox(height: 16),
              _contactRow('support@menubaghdad.com'),
              const SizedBox(height: 10),
              _contactRow('+964 750 000 0000'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('إغلاق',
                  style: TextStyle(color: AppColors.primaryOrange)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contactRow(String text) {
    return Row(children: [
      const Icon(Icons.email_outlined,
          color: AppColors.primaryOrange, size: 18),
      const SizedBox(width: 10),
      Text(text, style: const TextStyle(color: AppColors.greyText)),
    ]);
  }

  // ─── Dialog الملاحظات ─────────────────────────
  void _showFeedbackDialog(BuildContext context) {
    final feedbackCtrl = TextEditingController();
    final cardBg = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;
    final bgFill = Theme.of(context).scaffoldBackgroundColor;
    final borderColor = Theme.of(context).dividerColor;

    Get.dialog(
      Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          backgroundColor: cardBg,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('إرسال ملاحظة', style: TextStyle(color: textColor)),
          content: TextField(
            controller: feedbackCtrl,
            maxLines: 4,
            style: TextStyle(color: textColor),
            textAlign: TextAlign.right,
            decoration: InputDecoration(
              hintText: 'اكتب ملاحظتك أو اقتراحك هنا...',
              hintStyle: const TextStyle(
                  color: AppColors.greyText, fontSize: 13),
              filled: true,
              fillColor: bgFill,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: AppColors.primaryOrange),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('إلغاء',
                  style: TextStyle(color: Theme.of(context).hintColor)),
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
                  style: TextStyle(color: AppColors.primaryOrange)),
            ),
          ],
        ),
      ),
    );
  }
}