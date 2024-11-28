import 'app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle setInterTextStyle({
    required Color color,
    required double fontSize,
    required FontWeight fontWeight,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
    );
  }

  static TextStyle interWhite(double fontSize, FontWeight fontWeight) {
    return setInterTextStyle(
      color: AppColors.mainWhite,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle interBlack(double fontSize, FontWeight fontWeight) {
    return setInterTextStyle(
      color: AppColors.mainBlack,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
