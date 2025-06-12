import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class BookingDateTime extends StatelessWidget {
  final String? appointmentDate;
  final String? appointmentTime;
  final bool isVertical;

  const BookingDateTime({
    super.key,
    required this.appointmentDate,
    required this.appointmentTime,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                Assets.iconsCalenderIconDarkblue,
                height: 20.h,
                width: 20.w,
              ),
              horizontalSpace(4),
              Text(
                HelperMethods.formatDate(appointmentDate),
                style: AppTextStyles.poppinsBlack(10, FontWeight.w400),
              ),
            ],
          ),
          verticalSpace(4),
          Row(
            children: [
              SvgPicture.asset(
                Assets.iconsClockIconDarkblue,
                height: 20.h,
                width: 20.w,
              ),
              horizontalSpace(4),
              Text(
                HelperMethods.formatTime(appointmentTime),
                style: AppTextStyles.poppinsBlack(10, FontWeight.w400),
              ),
            ],
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              Assets.iconsCalenderIconDarkblue,
              height: 20.h,
              width: 20.w,
            ),
            horizontalSpace(2),
            Text(
              HelperMethods.formatDate(appointmentDate),
              style: AppTextStyles.poppinsBlack(10, FontWeight.w400),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
              Assets.iconsClockIconDarkblue,
              height: 20.h,
              width: 20.w,
            ),
            horizontalSpace(2),
            Text(
              HelperMethods.formatTime(appointmentTime),
              style: AppTextStyles.poppinsBlack(10, FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }
}
