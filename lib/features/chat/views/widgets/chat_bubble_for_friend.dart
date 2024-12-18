import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 270.w,
                padding: EdgeInsets.only(
                    top: 17.h, right: 12.w, bottom: 16.h, left: 17.w),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                    bottomLeft: Radius.circular(20.r),
                  ),
                ),
                child: Text(
                  'Hi Kawsar, I am a cardio patient. I need your help immediately.',
                  style: AppTextStyles.poppinsWhite(14, FontWeight.w400),
                ),
              ),
              horizontalSpace(8.87),
              CircleAvatar(
                radius: 19.r,
                backgroundImage: AssetImage(Assets.imagesDoctorsDoctorM),
              ),
            ],
          ),
          verticalSpace(4),
          Padding(
            padding: EdgeInsets.only(right: 9.w),
            child: Text(
              '18:27',
              style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
            ),
          ),
          verticalSpace(8),
        ],
      ),
    );
  }
}