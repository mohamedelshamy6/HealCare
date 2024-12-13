import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class DoctorsContainer extends StatelessWidget {
  final int index;
  const DoctorsContainer({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(12.r),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(22.r),
                    bottomRight: Radius.circular(22.r),
                    topLeft: Radius.circular(22.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.h),
                  child: Image.asset(
                    index % 2 == 0
                        ? Assets.imagesDoctorsDoctorF4
                        : Assets.imagesDoctorsDoctorM4,
                  ),
                ),
              ),
              Positioned(
                top: -1.h,
                right: -1.w,
                child: CircleAvatar(
                  radius: 6.r,
                  backgroundColor: Colors.white,
                  child: Center(
                    child: CircleAvatar(
                      radius: 4.r,
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr. Mahbuba Islam',
                  style: AppTextStyles.poppinsBlack(
                    16,
                    FontWeight.w500,
                  ),
                ),
                verticalSpace(4),
                Text(
                  'Cardiologist- Cumilla Madical Collage',
                  style: AppTextStyles.poppinsGrey(
                    10,
                    FontWeight.w400,
                  ),
                ),
                verticalSpace(4),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        '10:20 AM - 12:30 PM',
                        style: AppTextStyles.poppinsMainColor(
                          9,
                          FontWeight.w400,
                        ),
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: AppColors.mainColor,
                      radius: 10.r,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 14.r,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
