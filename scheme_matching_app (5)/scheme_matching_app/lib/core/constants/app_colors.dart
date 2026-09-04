import 'package:flutter/material.dart';

/// Central color palette. Chosen for high contrast and accessibility -
/// our target users may have limited digital literacy, so we avoid
/// low-contrast pastel UI patterns common in generic apps.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF0B5D3B); // trust green (govt-adjacent, not copying any logo)
  static const Color primaryDark = Color(0xFF07422A);
  static const Color secondary = Color(0xFFF4A300); // warm amber for CTAs
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF5C5C5C);

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFED6C02);
  static const Color error = Color(0xFFC62828);

  static const Color matchHigh = Color(0xFF2E7D32); // >80%
  static const Color matchMedium = Color(0xFFED6C02); // 50-80%
  static const Color matchLow = Color(0xFF9E9E9E); // <50%

  static const Color cardBorder = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFBDBDBD);
}
