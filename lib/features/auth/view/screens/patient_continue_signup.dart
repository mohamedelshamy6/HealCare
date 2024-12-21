import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../widgets/tff_with_label.dart';
import '../widgets/upload_photo_widget.dart';

class PatientContinueSignupScreen extends StatelessWidget {
  const PatientContinueSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(16),
                CustomAppHeader(canBack: true),
                verticalSpace(12),
                UploadPhotoWidget(),
                verticalSpace(16),
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
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 42.h,
                    decoration: BoxDecoration(
                      color: AppColors.mainWhite,
                      border: Border.all(color: AppColors.mainGrey),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.upload_file,
                          color: AppColors.mainColor,
                        ),
                        horizontalSpace(8),
                        Text(
                          'Upload File',
                          style: AppTextStyles.poppinsMainColor(
                              14, FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(36),
                CustomButton(
                  buttonAction: () {},
                  buttonText: 'Sign Up',
                  height: 50.h,
                  textStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500),
                ),
                verticalSpace(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
