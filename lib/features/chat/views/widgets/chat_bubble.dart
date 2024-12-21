import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message, required this.date});
  final String message;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 19.r,
                backgroundImage: AssetImage(Assets.imagesDoctorsDoctorF3),
              ),
              horizontalSpace(8.87),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.sizeOf(context).width < 400
                          ? 222.w
                          : 270.w,
                    ),
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
                      message,
                      style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                    ),
                  ),
                  Positioned(
                    bottom: -22.h,
                    right: 0,
                    child: Text(
                      date,
                      style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                    ),
                  )
                ],
              ),
            ],
          ),
          verticalSpace(24)
        ],
      ),
    );
  }
}
