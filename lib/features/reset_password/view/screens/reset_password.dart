import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/errors/messages/validation_error_messages.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

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
                          canBack: false,
                          title: 'Reset Password',
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
                      ],
                    ),
                  ),
                ),
              ),
              CustomButton(
                  height: 50.h,
                  buttonText: 'Confirm',
                  buttonAction: () {},
                  textStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500)),
              verticalSpace(49)
            ],
          ),
        ),
      ),
    );
  }
}
