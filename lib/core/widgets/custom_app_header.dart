import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import '../helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class CustomAppHeader extends StatelessWidget {
  final bool? canBack;
  final String? title;
  final double? horizSpace;
  final void Function()? onTap;
  final List<Widget>? actionsWidgets;
  final bool? seenAll;
  final void Function()? onSeenAllTap;

  const CustomAppHeader({
    super.key,
    this.canBack,
    this.title,
    this.onTap,
    this.horizSpace,
    this.actionsWidgets,
    this.seenAll,
    this.onSeenAllTap,
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
        Spacer(),
        seenAll == null || seenAll == false ? Container() : horizontalSpace(24),
        GestureDetector(
          onTap: onSeenAllTap,
          child: Text(
            'Seen All',
            style: AppTextStyles.poppinsBlack(
              14,
              FontWeight.w500,
            ).copyWith(
              color: AppColors.tFFErrorColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.tFFErrorColor,
            ),
          ),
        ),
      ],
    );
  }
}
