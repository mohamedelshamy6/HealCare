import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.buttonAction,
    required this.buttonStyle,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
  });

  final String buttonText;
  final TextStyle buttonStyle;
  final Function() buttonAction;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 40.h,
      child: MaterialButton(
        onPressed: buttonAction,
        padding: EdgeInsets.zero,
        color: color ?? AppColors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
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
