import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/pinput_code.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppHeader(
                      canBack: true,
                      title: 'Verification Code',
                      horizSpace: 38.25,
                    ),
                    verticalSpace(23),
                    Text(
                      'Enter the code we sent you',
                      style: AppTextStyles.poppinsBlack(16, FontWeight.w400),
                    ),
                    verticalSpace(95),
                    Center(
                      child: PinputCode(),
                    ),
                    verticalSpace(3),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 7.w),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Resent Code',
                            style: AppTextStyles.poppinsMainColor(
                                16, FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomButton(
                buttonText: 'Confirm',
                buttonAction: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.setNewPassword);
                },
                textStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500),
                height: 50.h,
              ),
              verticalSpace(49)
            ],
          ),
        ),
      ),
    );
  }
}
