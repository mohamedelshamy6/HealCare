import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../core/routing/routes.dart';

class DoctorHomeHeader extends StatelessWidget {
  const DoctorHomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundImage: AssetImage(
                Assets.imagesDoctorsDoctorM2,
              ),
            ),
            horizontalSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                ),
                Text(
                  'Dr. Mena Wasef',
                  style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
                ),
              ],
            )
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.notificationsDoctorScreen,
              arguments: 'doctor',
            );
          },
          child: SvgPicture.asset(Assets.iconsNotificationIconBlueDot),
        ),
      ],
    );
  }
}
