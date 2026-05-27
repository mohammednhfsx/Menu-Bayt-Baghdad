import 'package:flutter/material.dart';
import 'package:menubaghdad/view/widgets/custom_icons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 14, 5, 2),
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
  // ──────────────────────────────────────────────────────────────
  // ── Header ────────────────────────────────────────────────────
  // ──────────────────────────────────────────────────────────────

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ──────────────────────────────────────────────────────────────
          // Bell icon
          // ──────────────────────────────────────────────────────────────
          CustomIconContainer(icon: Icons.notifications_outlined),

          // ──────────────────────────────────────────────────────────────
          // Address + greeting
          // ──────────────────────────────────────────────────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  const Text(
                    'طاولة رقم ١٢ • فرع الكرادة',
                    style: TextStyle(color: Color(0xFFB0A090), fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.location_on,
                    color: Color(0xFFE8961A),
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
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'منيو بغداد',
                      style: TextStyle(color: Color(0xFFE8961A)),
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
