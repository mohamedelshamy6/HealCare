import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          //  mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 19.r,
              backgroundImage: AssetImage(Assets.imagesDoctorsDoctorM),
            ),
            horizontalSpace(8.87),
            Container(
              width: 270.w,
              padding: EdgeInsets.only(
                  top: 17.h, right: 12.w, bottom: 16.h, left: 17.w),
              decoration: BoxDecoration(
                color: AppColors.mainWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Text(
                'Hi Kawsar, I am a cardio patient. I need your help immediately.',
                style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
              ),
            ),
          ],
        ),
        verticalSpace(4),
        Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 9.w),
              child: Text(
                '18:27',
                style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
              ),
            )),
        verticalSpace(8),
      ],
    );
  }
}
