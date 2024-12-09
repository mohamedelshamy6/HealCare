import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';

import '../../../../core/theme/app_text_styles.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> categoriesIcons = [
      Assets.iconsCadiologist,
      Assets.iconsDentists,
      Assets.iconsNephrologists,
      Assets.iconsGastroenterologists,
      Assets.iconsPulmonologists,
      Assets.iconsNeurologists,
      Assets.iconsPsychiatrists,
      Assets.iconsHepatologists,
    ];
    const List<String> categoriesLabels = [
      'Heart',
      'Dental',
      'Kidney',
      'Stomach',
      'Lungs',
      'Brain',
      'Mental',
      'Liver',
    ];
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
      ),
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.categoryCardColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(categoriesIcons[index]),
            ),
            verticalSpace(4),
            Text(
              maxLines: 1,
              categoriesLabels[index],
              style: AppTextStyles.poppinsGrey(12, FontWeight.w600).copyWith(
                color: Color(0xff7D8A95),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
