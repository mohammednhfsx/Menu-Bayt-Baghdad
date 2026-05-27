import 'package:flutter/material.dart';
import 'package:menubaghdad/core/theme/app_colors.dart';
import 'package:menubaghdad/view/widgets/custom_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [_buildHeader()],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //──────────────────────────── Header ────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //  icon
          CustomIconContainer(icon: Icons.notifications_outlined),

          //────────── Address + greeting ─────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text(
                    'طاولة رقم ١٢ • فرع الكرادة',
                    style: TextStyle(color: AppColors.greyText, fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.location_on,
                    color: AppColors.primaryOrange,
                    size: 14,
                  ),
                ],
              ),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: 'أهلاً بك في ',
                      style: TextStyle(color:AppColors.white),
                    ),
                    TextSpan(
                      text: 'منيو بغداد',
                      style: TextStyle(color:AppColors.primaryOrange),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
