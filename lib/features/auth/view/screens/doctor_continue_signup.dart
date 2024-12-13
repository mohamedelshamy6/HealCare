import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../widgets/tff_with_label.dart';

class DoctorContinueSignupScreen extends StatelessWidget {
  const DoctorContinueSignupScreen({super.key});

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
                TFFWithLabel(
                  label: 'Education',
                  kbType: TextInputType.text,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Working hours availability',
                  kbType: TextInputType.text,
                ),
                verticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        itemList: <String>[
                          'Eyes',
                          'Teeth',
                          'Skin',
                          'Heart',
                          'Lungs',
                        ],
                        hint: 'Eyes',
                        label: 'Specialization',
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
                TFFWithLabel(
                  label: 'Address',
                  kbType: TextInputType.multiline,
                  maxLines: 3,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Experience',
                  kbType: TextInputType.multiline,
                  maxLines: 3,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Biography',
                  kbType: TextInputType.multiline,
                  maxLines: 7,
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

class UploadPhotoWidget extends StatelessWidget {
  const UploadPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: AppColors.dropDownColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 24.r,
                  color: Color(0xff676767),
                ),
              ),
              Container(
                width: 25.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.add,
                  size: 12.r,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          horizontalSpace(8),
          Text(
            'Upload Photo',
            style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
