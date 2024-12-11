import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/errors/messages/validation_error_messages.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/auth_continue_question.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/continue_with_google.dart';

class LoginScreen extends StatelessWidget {
  final String type;
  const LoginScreen({
    super.key,
    required this.type,
  });

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
                    title: 'Let\'s Sign In',
                  ),
                  verticalSpace(48),
                  Text(
                    'Welcome!',
                    style: AppTextStyles.poppinsBlack(30, FontWeight.w500),
                  ),
                  verticalSpace(86),
                  CustomTFF(
                    hintText: 'Email',
                    kbType: TextInputType.emailAddress,
                    validate: (email) =>
                        ValidationErrorTexts.emailValidation(email),
                  ),
                  verticalSpace(20),
                  CustomTFF(
                    hintText: 'Password',
                    kbType: TextInputType.visiblePassword,
                    validate: (password) =>
                        ValidationErrorTexts.loginPasswordValidation(password),
                  ),
                  verticalSpace(8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.forgetPassword);
                      },
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        surfaceTintColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        splashFactory: NoSplash.splashFactory,
                      ),
                      child: Text(
                        'Forgot Password?',
                        style:
                            AppTextStyles.poppinsMainColor(13, FontWeight.w500),
                      ),
                    ),
                  ),
                  verticalSpace(72),
                  CustomButton(
                    buttonAction: () {
                      if (formKey.currentState!.validate()) {}
                    },
                    buttonText: 'Sign In',
                    height: 50.h,
                    borderRadius: 10,
                    textStyle:
                        AppTextStyles.poppinsWhite(15, FontWeight.w500),
                  ),
                  verticalSpace(16),
                  AuthContinueQuestion(
                    label: 'Don’t have an account?',
                    action: 'Sign Up',
                    route: Routes.signUpScreen,
                    type: '',
                  ),
                  verticalSpace(32),
                  ContinueWithGoogle(),
                  verticalSpace(24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
