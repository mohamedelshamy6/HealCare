import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/routing/routes.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../data/models/information_model.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/information_row.dart';
import '../widgets/profile_header.dart';

class PatientProfile extends StatelessWidget {
  const PatientProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppHeader(canBack: false, title: 'Profile'),
                verticalSpace(16),
                Center(child: ProfileHeader()),
                verticalSpace(24),
                Row(
                  children: [
                    Text(
                      'Your Information',
                      style: AppTextStyles.poppinsBlack(14, FontWeight.w500),
                    ),
                    Spacer(),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      child: Text(
                        'Edit',
                        style:
                            AppTextStyles.poppinsMainColor(12, FontWeight.w400),
                      ),
                      onTap: () => Navigator.of(context)
                          .pushNamed(Routes.patientEditProfile),
                    ),
                  ],
                ),
                verticalSpace(16),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InformationRow(
                            icon: informationList[index].icon,
                            label: informationList[index].label,
                            value: informationList[index].value,
                          ),
                      separatorBuilder: (context, index) => verticalSpace(8),
                      itemCount: informationList.length),
                ),
                verticalSpace(24),
                Text(
                  'Medical Information',
                  style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
                ),
                verticalSpace(8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eleifend pretium libero sit amet mollis. Duis ornare tempor molestie. Donec at elementum ligula.',
                  style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                ),
                verticalSpace(32),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  width: double.infinity,
                  color: AppColors.lighterBlue,
                  child: Center(
                    child: Text(
                      'Files',
                      style: AppTextStyles.poppinsBlack(16, FontWeight.w400),
                    ),
                  ),
                ),
                verticalSpace(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      Assets.imagesFileOne,
                      width: 157.w,
                      height: 143.h,
                    ),
                    Image.asset(
                      Assets.imagesFileTwo,
                      width: 157.w,
                      height: 143.h,
                    ),
                  ],
                ),
                verticalSpace(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      Assets.imagesFileOne,
                      width: 157.w,
                      height: 143.h,
                    ),
                    Image.asset(
                      Assets.imagesFileTwo,
                      width: 157.w,
                      height: 143.h,
                    ),
                  ],
                ),
                verticalSpace(8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
