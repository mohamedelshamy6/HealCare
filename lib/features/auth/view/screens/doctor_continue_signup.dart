import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_drop_down.dart';
import '../widgets/tff_with_label.dart';
import '../widgets/upload_photo_widget.dart';

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
                  label: 'Doctor\'s name',
                  kbType: TextInputType.text,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Education',
                  kbType: TextInputType.text,
                ),
                verticalSpace(12),
                TFFWithLabel(
                  label: 'Instapay Link',
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
                  buttonAction: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.loginScreen, (route) => false,
                        arguments: 'doctor');
                  },
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
