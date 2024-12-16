import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationsList extends StatelessWidget {
  const NotificationsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> icons = [
      Assets.iconsNotificationCalenderBlue,
      Assets.iconsNotificationCalenderDarkblue,
      Assets.iconsNotificationCalenderOrange
    ];
    List<Color> colors = [
      AppColors.mainColor.withOpacity(0.1),
      Color(0xffEEEEFB),
      Color(0xffFFF6F2),
    ];
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(6.r),
              height: 30.h,
              width: 30.w,
              decoration: BoxDecoration(
                color: colors[index],
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Center(
                child: SvgPicture.asset(icons[index]),
              ),
            ),
            horizontalSpace(8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  index != 2
                      ? Text(
                          'You have appointment with Mahbuba Islam at 9:00 pm today',
                          style: AppTextStyles.poppinsBlack(
                            13,
                            FontWeight.w400,
                          ),
                        )
                      : Text.rich(
                          TextSpan(
                            text:
                                'Completed your profile to be better health consults. ',
                            style: AppTextStyles.poppinsBlack(
                              13,
                              FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                text: 'Complete Profile',
                                style: AppTextStyles.poppinsMainColor(
                                  13,
                                  FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                  verticalSpace(4),
                  Text(
                    index == 0 ? 'Just Now' : '25 Minutes Ago',
                    style: AppTextStyles.poppinsMainColor(
                      12,
                      FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        separatorBuilder: (context, index) => SizedBox(height: 24.h),
        itemCount: 3,
      ),
    );
  }
}
