import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/features/reset_password/view/widgets/pinput_code.dart';

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
                      // onTap: () => Navigator.pushNamedAndRemoveUntil(
                      // context, Routes.choose, (route) => false),
                    ),
                    verticalSpace(23),
                    Text(
                      'Enter the code we sent you',
                      style: AppTextStyles.poppinsBlack(16, FontWeight.w400),
                    ),
                    verticalSpace(95),
                    Center(child: PinputCode()),
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
                          )),
                    ),
                    verticalSpace(94),
                  ],
                ),
              ),
              CustomButton(
                buttonText: 'Confirm',
                buttonAction: () {
                  Navigator.of(context).pushNamed(Routes.setNewPassword);
                },
                buttonStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500),
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
