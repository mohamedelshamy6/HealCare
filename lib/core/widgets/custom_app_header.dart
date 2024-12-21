import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class CustomAppHeader extends StatelessWidget {
  final bool? canBack;
  final String? title;
  final double? horizSpace;
  final void Function()? onTap;
  const CustomAppHeader({
    super.key,
    this.canBack,
    this.title,
    this.onTap,
    this.horizSpace,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: canBack == null || canBack == false
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        canBack == null || canBack == false
            ? Container()
            : InkWell(
                splashFactory: NoSplash.splashFactory,
                highlightColor: Colors.transparent,
                onTap: onTap ?? () => Navigator.pop(context),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24.r,
                  child: Icon(Icons.arrow_back, size: 24.r),
                ),
              ),
        canBack == null || canBack == false
            ? Container()
            : horizontalSpace(horizSpace ?? 64),
        Text(
          title ?? '',
          style: AppTextStyles.poppinsBlack(18, FontWeight.w500),
        ),
      ],
    );
  }
}
