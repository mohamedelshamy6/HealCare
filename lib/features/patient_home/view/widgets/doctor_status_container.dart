import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DoctorStatusContainer extends StatelessWidget {
  const DoctorStatusContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '350+',
                  style: AppTextStyles.poppinsMainColor(24, FontWeight.w600),
                ),
                Text(
                  'Patients',
                  style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '15+',
                  style: AppTextStyles.poppinsMainColor(24, FontWeight.w600)
                      .copyWith(color: Color(0xff9DEAC0)),
                ),
                Text(
                  'Exp. Years',
                  style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '284+',
                  style: AppTextStyles.poppinsMainColor(24, FontWeight.w600)
                      .copyWith(color: Color(0xffFF9A9A)),
                ),
                Text(
                  'Reviews',
                  style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
