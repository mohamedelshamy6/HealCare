import 'app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle setPoppinsTextStyle({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.poppins(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }

  static TextStyle poppinsWhite(double fontSize, FontWeight fontWeight) {
    return setPoppinsTextStyle(
      color: AppColors.mainWhite,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle poppinsBlack(double fontSize, FontWeight fontWeight) {
    return setPoppinsTextStyle(
      color: AppColors.mainBlack,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
  static TextStyle poppinsMainColor(double fontSize, FontWeight fontWeight) {
    return setPoppinsTextStyle(
      color: AppColors.mainColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
