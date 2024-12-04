import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/errors/messages/validation_error_messages.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/core/widgets/custom_text_form_field.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomAppHeader(
                          canBack: true,
                          title: 'Reset Password',
                          horizSpace: 45.25,
                          // onTap: () => Navigator.pushNamedAndRemoveUntil(
                          // context, Routes.choose, (route) => false),
                        ),
                        verticalSpace(23),
                        Text(
                          'Enter a new password',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w400),
                        ),
                        verticalSpace(96),
                        CustomTFF(
                          hintText: 'New Password',
                          kbType: TextInputType.visiblePassword,
                          validate: (password) =>
                              ValidationErrorTexts.loginPasswordValidation(
                                  password),
                        ),
                        verticalSpace(20),
                        CustomTFF(
                          hintText: 'Confirm Password',
                          kbType: TextInputType.visiblePassword,
                          validate: (password) =>
                              ValidationErrorTexts.loginPasswordValidation(
                                  password),
                        ),
                        verticalSpace(55),
                      ],
                    ),
                  ),
                ),
              ),
              CustomButton(
                  height: 50.h,
                  buttonText: 'Confirm',
                  buttonAction: () {},
                  buttonStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500)),
              verticalSpace(49)
            ],
          ),
        ),
      ),
    );
  }
}
