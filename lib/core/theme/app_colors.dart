

import 'package:flutter/material.dart';

class AppColors {
  // ── Backgrounds ──────────────────────────────────────────
    static const Color background = Color(0xFF120806);
  static const Color bottomNav = Color(0xFF2A1D19);
  static const Color cardColor = Color(0xFF241714);
  static const Color border = Color(0xFF3A2A24);
  static const Color searchFill = Color(0xFF251C19);

  // ── Brand ────────────────────────────────────────────────
  static const Color primaryOrange = Color(0xFFE8A020);
  static const Color Orange        = Color(0xFFF5B942);
  static const Color darkOrange    = Color(0xFFC47D10);

  // ── Text ─────────────────────────────────────────────────
  static const Color white     = Color(0xFFFFFFFF);
  static const Color greyText  = Color(0xFF9A9A9A);

  // ── Status ───────────────────────────────────────────────
  static const Color red   = Color(0xFFE84020);
  static const Color green = Color(0xFF2A7A2A);
  static const Color blue = Colors.blue;

  // ── Gradient helpers ─────────────────────────────────────
  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE65100), Color(0xFFFF9800)],
  );
}