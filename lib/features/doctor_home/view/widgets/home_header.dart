import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          SizedBox(
              height: 48.h,
              width: 48.w,
              child: Image.asset(
               Assets.imagesPatientsPatientM2,
              )),
          horizontalSpace(3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back',
                style:
                    AppTextStyles.poppinsGrey(14, FontWeight.w400),
              ),
              Text(
                'Andrew Smith',
                style:
                    AppTextStyles.poppinsBlack(16, FontWeight.w500),
              ),
            ],
          )
        ],
      ),
      SvgPicture.asset(Assets.iconsNotificationIconBlueDot),
    ],
                );
  }
}
