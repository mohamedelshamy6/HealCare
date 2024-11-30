import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class CustomAppHeader extends StatelessWidget {
  final bool? canBack;
  final String? title;
  const CustomAppHeader({
    super.key,
    this.canBack,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: canBack == null || canBack == false
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          radius: 24.r,
          child: Icon(Icons.arrow_back, size: 24.r),
        ),
        horizontalSpace(64),
        Text(
          title ?? '',
          style: AppTextStyles.poppinsBlack(18, FontWeight.w500),
        ),
      ],
    );
  }
}
