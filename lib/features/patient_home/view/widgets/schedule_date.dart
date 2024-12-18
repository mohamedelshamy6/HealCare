import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ScheduleDate extends StatelessWidget {
  const ScheduleDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Schedule Date',
                style: AppTextStyles.poppinsBlack(14, FontWeight.w700),
              ),
              Spacer(),
              TextButton.icon(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.zero),
                  splashFactory: NoSplash.splashFactory,
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {},
                label: Text(
                  'Edit',
                  style: AppTextStyles.poppinsMainColor(
                    12,
                    FontWeight.w700,
                  ),
                ),
                icon: SvgPicture.asset(Assets.iconsEditIconBlue),
              )
            ],
          ),
          verticalSpace(16),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.mainColor.withOpacity(0.3),
                  border: Border.all(color: AppColors.mainColor),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.all(6.r),
                child: Center(
                  child: SvgPicture.asset(
                    Assets.svgsAppointmentCalender,
                  ),
                ),
              ),
              horizontalSpace(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Appointment',
                    style: AppTextStyles.poppinsGrey(
                      12,
                      FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Wednesday, 10 Jan 2024, 11:00',
                    style: AppTextStyles.poppinsBlack(
                      14,
                      FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
          verticalSpace(8),
        ],
      ),
    );
  }
}
