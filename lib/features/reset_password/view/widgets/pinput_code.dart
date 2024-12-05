import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:pinput/pinput.dart';

class PinputCode extends StatelessWidget {
  const PinputCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 5,
      mouseCursor: MouseCursor.defer,
      errorPinTheme: PinTheme(
        height: 52.h,
        width: 52.h,
        decoration: BoxDecoration(
            color: AppColors.mainWhite,
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
      ),
      defaultPinTheme: PinTheme(
        height: 52.h,
        width: 52.h,
        decoration: BoxDecoration(
            color: AppColors.mainWhite,
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
      ),
      focusedPinTheme: PinTheme(
        height: 52.h,
        width: 52.h,
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.symmetric(horizontal: 4.w),
      ),
    );
  }
}
