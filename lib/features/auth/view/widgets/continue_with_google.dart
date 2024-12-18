import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/theme/app_text_styles.dart';

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Divider(
                color: AppColors.mainGrey,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                'Or',
                style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
              ),
            ),
            const Expanded(
              child: Divider(
                color: AppColors.mainGrey,
              ),
            ),
          ],
        ),
        verticalSpace(24),
        InkWell(
          splashFactory: NoSplash.splashFactory,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: () async {},
          child: SizedBox(
            height: 60.h,
            width: double.infinity,
            child: Card(
              surfaceTintColor: Colors.white,
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              color: AppColors.mainWhite,
              child: Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      width: 30.w,
                      height: 30.h,
                      Assets.svgsGoogle,
                    ),
                    horizontalSpace(
                        MediaQuery.sizeOf(context).width < 400 ? 24 : 48),
                    Text(
                      'Continue with Google',
                      style: AppTextStyles.poppinsBlack(14, FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
