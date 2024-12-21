import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key, required this.message});
final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end, 
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
             mainAxisSize: MainAxisSize.min, 
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    constraints: BoxConstraints(
                    maxWidth: 270.w,),
                   // width: 270.w,
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
                      message,
                      style: AppTextStyles.poppinsWhite(14, FontWeight.w400),
                    ),
                  ),
                   Positioned(bottom: -22.h,left: 0,child:  Text(
              '18:27',
              style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
            ),)
                ],
              ),
              horizontalSpace(8.87),
              CircleAvatar(
                radius: 19.r,
                backgroundImage: AssetImage(Assets.imagesDoctorsDoctorM),
              ),
            ],
          ),
          verticalSpace(24),
        ],
      ),
    );
  }
}
