import 'package:baraka_portfolio/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle headline1 = TextStyle(
    fontSize: 20.0,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static TextStyle label1 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.grey600,
  );

  static TextStyle label2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.grey900,
  );
}
