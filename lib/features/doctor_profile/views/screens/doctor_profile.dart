import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/features/doctor_profile/views/widgets/doctor_profile_header.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../data/models/information_model.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../widgets/information_row.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

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
                Center(child: DoctorProfileHeader()),
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
                verticalSpace(48),
                Text(
                  'Working Hours',
                  style: AppTextStyles.poppinsMainColor(16, FontWeight.w600),
                ),
                verticalSpace(16),
                Image.asset(Assets.imagesDoctorWorkingHours),
                verticalSpace(24),
                Text(
                  'Biography',
                  style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
                ),
                verticalSpace(8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eleifend pretium libero sit amet mollis. Duis ornare tempor molestie. Donec at elementum ligula.',
                  style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                ),
                verticalSpace(24),
                Text(
                  'Education',
                  style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
                ),
                verticalSpace(8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eleifend pretium libero sit amet mollis. Duis ornare tempor molestie. Donec at elementum ligula.',
                  style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                ),
                verticalSpace(24),
                Text(
                  'Experience',
                  style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
                ),
                verticalSpace(8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eleifend pretium libero sit amet mollis. Duis ornare tempor molestie. Donec at elementum ligula.',
                  style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
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
