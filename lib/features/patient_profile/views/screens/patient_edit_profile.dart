import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/features/patient_profile/views/widgets/profile_header.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../../../auth/view/widgets/tff_with_label.dart';

class PatientEditProfile extends StatelessWidget {
  const PatientEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                CustomAppHeader(
                  canBack: true,
                  title: 'Edit Profile',
                  horizSpace: MediaQuery.sizeOf(context).width < 400 ? 56 : 70,
                ),
                verticalSpace(16),
                ProfileHeader(),
                verticalSpace(32),
                CustomDropdown(
                  itemList: <String>[
                    'Blood Pressure',
                    'Fever',
                    'Headache',
                    'Diabetes',
                  ],
                  hint: 'Cold',
                  label: 'Disease Type',
                ),
                verticalSpace(12),
                CustomDropdown(
                  itemList: <String>[
                    'A+',
                    'A-',
                    'AB',
                    'B+',
                    'B-',
                    'O+',
                    'O-',
                  ],
                  hint: 'A+',
                  label: 'Blood Type',
                ),
                verticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: TFFWithLabel(
                        label: 'Age',
                        hintText: '22 Years',
                        kbType: TextInputType.number,
                      ),
                    ),
                    horizontalSpace(8),
                    Expanded(
                      child: CustomDropdown(
                        itemList: <String>[
                          'Male',
                          'Female',
                          'Rather Not Say',
                        ],
                        hint: 'Male',
                        label: 'Gender',
                      ),
                    ),
                  ],
                ),
                verticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: TFFWithLabel(
                        label: 'Weight',
                        maxInputLength: 3,
                        hintText: '50 Kg',
                        kbType: TextInputType.number,
                      ),
                    ),
                    horizontalSpace(8),
                    Expanded(
                      child: TFFWithLabel(
                        label: 'Height',
                        hintText: '185 cm',
                        maxInputLength: 3,
                        kbType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Address',
                  kbType: TextInputType.multiline,
                  maxLines: 3,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Medical History',
                  kbType: TextInputType.multiline,
                  maxLines: 6,
                ),
                verticalSpace(12),
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
                verticalSpace(24),
                CustomButton(
                  buttonText: 'Save',
                  buttonAction: () {},
                  textStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500),
                  height: 52.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
