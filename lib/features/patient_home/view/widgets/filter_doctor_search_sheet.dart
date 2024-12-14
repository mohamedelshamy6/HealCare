import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

import '../../../../core/widgets/custom_button.dart';

class FilterDoctorSearchSheet extends StatelessWidget {
  const FilterDoctorSearchSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: Color(0xfff9f9f9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: AppTextStyles.poppinsBlack(
              16,
              FontWeight.w400,
            ),
          ),
          verticalSpace(16),
          // ? THIS IS TEMPORARY CODE FOR UI.
          // ? ===============================================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Dermatology',
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Cardiologist',
                  style: AppTextStyles.poppinsWhite(14, FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Pediatrics',
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                ),
              ),
            ],
          ),
          verticalSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Ophthalmology',
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Pediatrics',
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Pediatrics',
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                ),
              ),
            ],
          ),
          verticalSpace(10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Ophthalmology',
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.mainWhite,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Pediatrics',
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Pediatrics',
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                ),
              ),
            ],
          ),
          // ? ==================================================================
          // ? THIS IS THE MAIN CODE FOR UI.
          // Wrap(
          //   spacing: 10.w,
          //   runSpacing: 10.h,
          //   children: List.generate(
          //     9,
          //     (index) => Container(
          //       padding: EdgeInsets.all(10.r),
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(8.r),
          //       ),
          //       child: Text(
          //         index == 0
          //             ? 'Dermatology'
          //             : index == 1
          //                 ? 'Cardiologist'
          //                 : index == 3 || index == 6
          //                     ? 'Ophthalmology'
          //                     : 'Pediatrics',
          //         style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
          //       ),
          //     ),
          //   ),
          // ),
          // ? ====================================================================
          verticalSpace(40),
          CustomButton(
            buttonAction: () {},
            buttonText: 'Apply Filters',
            textStyle: AppTextStyles.poppinsWhite(
              15,
              FontWeight.w500,
            ),
            borderRadius: 8.r,
            height: 48.h,
          ),
          verticalSpace(16),
          Center(
            child: InkWell(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
              onTap: () {},
              child: Text(
                'Clear Filters',
                style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
