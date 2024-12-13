import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../core/helpers/app_images.dart';

class DoctorCardHome extends StatelessWidget {
  const DoctorCardHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.mainGrey.withOpacity(.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 48.h,
                width: 48.w,
                child: Image.asset(Assets.imagesPatientsPatientM2),
              ),
              horizontalSpace(3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Jennifer Miller',
                    style: AppTextStyles.poppinsBlack(14, FontWeight.w600),
                  ),
                  verticalSpace(4),
                  Text(
                    'Heart patient',
                    style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
          verticalSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.date_range,
                    color: AppColors.mainGrey,
                  ),
                  horizontalSpace(2),
                  Text(
                    '1/12/2024',
                    style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_view_day_rounded,
                    color: AppColors.mainGrey,
                  ),
                  horizontalSpace(2),
                  Text(
                    '10:30am - 5:30pm',
                    style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
