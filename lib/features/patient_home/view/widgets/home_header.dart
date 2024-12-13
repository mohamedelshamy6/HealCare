import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';

import '../../../../core/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundImage: AssetImage(Assets.imagesPatientsPatientM2),
        ),
        horizontalSpace(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome Back',
              style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
            ),
            Text(
              'Andrew Smith',
              style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                Assets.iconsWalletIcon,
                width: 22.w,
                height: 22.h,
              ),
            ),
            horizontalSpace(16),
            InkWell(
              onTap: () {},
              child: Image.asset(
                Assets.iconsFavoriteIconDarkblueOutlined,
                width: 22.w,
                height: 22.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
