import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';

class DoctorProfileHeader extends StatelessWidget {
  const DoctorProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                image: const DecorationImage(
                  image: AssetImage(Assets.imagesPatientsPatientM),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColors.mainColor,
              radius: 12.r,
              child: Center(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 12.r,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(16),
        Text(
          'Lucas Scott',
          style: AppTextStyles.poppinsBlack(16, FontWeight.w800),
        ),
      ],
    );
  }
}
