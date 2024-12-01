import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_text_styles.dart';

class TFFWithLabel extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextInputType kbType;
  final TextEditingController? controller;
  final Color? color;
  final int? maxInputLength;
  final int? maxLines;
  final double? borderRadius;
  final bool? enableBorders;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final String? Function(String?)? validate;
  const TFFWithLabel({
    super.key,
    required this.label,
    this.hintText,
    required this.kbType,
    this.controller,
    this.color,
    this.maxInputLength,
    this.maxLines,
    this.borderRadius,
    this.enableBorders,
    this.hintTextStyle,
    this.validate,
    this.labelTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
              labelTextStyle ?? AppTextStyles.poppinsGrey(14, FontWeight.w400),
        ),
        SizedBox(height: 8),
        CustomTFF(
          borderRadius: borderRadius ?? 8.r,
          hintText: hintText ?? '',
          enableFocusedBorder: false,
          hintTextStyle:
              hintTextStyle ?? AppTextStyles.poppinsGrey(13, FontWeight.w400),
          maxInputLength: maxInputLength,
          color: color ?? AppColors.dropDownColor,
          kbType: kbType,
          maxLines: maxLines ?? 1,
        ),
      ],
    );
  }
}
