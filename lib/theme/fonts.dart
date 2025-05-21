import 'package:child_missing_app1/theme/colors.dart' show AppColors;
import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontFamily: 'hanken',
    color: AppColors.textPrimary,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontFamily: 'hanken',
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: 16,
    color: AppColors.primary,
    fontWeight: FontWeight.normal,
    fontFamily: 'hanken',
  );

  static const TextStyle smallText = TextStyle(
    fontSize: 12,
    fontFamily: 'hanken',
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
  );

  static const TextStyle errorText = TextStyle(
    fontSize: 14,
    fontFamily: 'hanken',
    color: AppColors.error,
  );
}
