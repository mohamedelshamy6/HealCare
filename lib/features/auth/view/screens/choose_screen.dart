import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_button.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_border_button.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 72.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Make Online And Live Consultation\nEasily With Top Doctors',
                  style: AppTextStyles.poppinsBlack(24, FontWeight.w600),
                ),
                verticalSpace(4),
                Padding(
                  padding: EdgeInsets.only(left: 24.w),
                  child: SvgPicture.asset(Assets.svgsChoosePageLine),
                ),
                verticalSpace(16),
                Image.asset(Assets.imagesChoosePageImage),
                verticalSpace(64),
                CustomButton(
                  borderRadius: 10,
                  height: 50.h,
                  buttonText: 'Sign Up As Doctor',
                  buttonAction: () {
                    Navigator.pushNamed(
                      context,
                      Routes.signUpScreen,
                      arguments: 'doctor',
                    );
                  },
                  buttonStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500),
                ),
                verticalSpace(16),
                CustomBorderButton(
                  borderRadius: 10,
                  height: 50.h,
                  buttonText: 'Sign Up As Patient',
                  buttonAction: () {
                    Navigator.pushNamed(
                      context,
                      Routes.signUpScreen,
                      arguments: 'patient',
                    );
                  },
                  buttonStyle:
                      AppTextStyles.poppinsMainColor(15, FontWeight.w500),
                ),
                verticalSpace(16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
