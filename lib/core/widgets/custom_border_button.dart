import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CustomBorderButton extends StatelessWidget {
  const CustomBorderButton({
    super.key,
    required this.buttonText,
    required this.buttonAction,
    required this.buttonStyle,
    this.height,
    this.width,
    this.borderRadius,
  });

  final String buttonText;
  final TextStyle buttonStyle;
  final Function() buttonAction;
  final double? width, height, borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 40.h,
      child: MaterialButton(
        onPressed: buttonAction,
        padding: EdgeInsets.zero,
        color: AppColors.mainWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
          side: BorderSide(
            color: AppColors.mainColor,
            width: 1.w,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: buttonStyle,
          ),
        ),
      ),
    );
  }
}
