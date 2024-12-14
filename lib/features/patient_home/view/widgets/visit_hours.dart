import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class VisitHours extends StatelessWidget {
  const VisitHours({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 12.h,
      children: List.generate(
        8,
        (index) => Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: index == 1 ? AppColors.mainColor : Colors.transparent,
          ),
          child: Text(
            '11:00AM',
            style: index == 1
                ? AppTextStyles.poppinsWhite(12, FontWeight.w500)
                : index == 0 || index == 3 || index == 5
                    ? AppTextStyles.poppinsGrey(12, FontWeight.w500)
                    : AppTextStyles.poppinsBlack(12, FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
