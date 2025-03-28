import 'package:flutter/material.dart';
import 'package:simple_simple_todo/src/core/constants/app_colors.dart';

const TextStyle taskStyle = TextStyle(
  fontSize: 14,
  color: AppColors.textColor,
);
const TextStyle titleStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: AppColors.textColor,
);
const completedTaskStyle = TextStyle(
  fontSize: 14,
  decoration: TextDecoration.lineThrough,
  decorationColor: AppColors.textColor,
  color: AppColors.disabledTextColor,
);
const hintStyle = TextStyle(
  fontSize: 14,
  color: AppColors.disabledTextColor,
);
