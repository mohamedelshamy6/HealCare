import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/errors/messages/validation_error_messages.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/core/widgets/custom_text_form_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppHeader(
                    canBack: true,
                    title: 'Forgot Password',
                    horizSpace: 41.25,
                    // onTap: () => Navigator.pushNamedAndRemoveUntil(
                    // context, Routes.choose, (route) => false),
                  ),
                  verticalSpace(23),
                  Text(
                    'We need your registration phone number to send you password reset code!',
                    style: AppTextStyles.poppinsBlack(16, FontWeight.w400),
                  ),
                  verticalSpace(74),
                  CustomTFF(
                    hintText: 'Email',
                    kbType: TextInputType.emailAddress,
                    validate: (email) =>
                        ValidationErrorTexts.emailValidation(email),
                  ),
                  verticalSpace(18),
                  CustomButton(
                    buttonText: 'Send Code',
                    buttonAction: () {
                      Navigator.of(context).pushNamed(Routes.codeVerification);
                    },
                    buttonStyle:
                        AppTextStyles.poppinsWhite(15, FontWeight.w500),
                    height: 50.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
