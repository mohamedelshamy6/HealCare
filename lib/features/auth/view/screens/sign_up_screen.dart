import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/errors/messages/validation_error_messages.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/auth_continue_question.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/continue_with_google.dart';

class SignUpScreen extends StatelessWidget {
  final String type;
  const SignUpScreen({super.key, required this.type});

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
                    title: 'Let\'s Sign Up',
                    horizSpace:
                        MediaQuery.sizeOf(context).width < 400 ? 46 : null,
                    onTap: () => Navigator.pushNamedAndRemoveUntil(
                        context, Routes.choose, (route) => false),
                  ),
                  verticalSpace(48),
                  Text(
                    'Create\nAccount!',
                    style: AppTextStyles.poppinsBlack(30, FontWeight.w500),
                  ),
                  verticalSpace(48),
                  CustomTFF(
                    hintText: 'Name',
                    kbType: TextInputType.name,
                    validate: (name) =>
                        ValidationErrorTexts.nameValidation(name),
                  ),
                  verticalSpace(20),
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
                        ValidationErrorTexts.signUpPasswordValidation(password),
                  ),
                  verticalSpace(20),
                  CustomTFF(
                    hintText: 'Confirm Password',
                    kbType: TextInputType.visiblePassword,
                    //TODO Use the text from the password field.
                    validate: (passwordConfirmation) =>
                        ValidationErrorTexts.confirmPasswordValidation(
                      passwordConfirmation,
                      passwordConfirmation,
                    ),
                  ),
                  verticalSpace(32),
                  CustomButton(
                    buttonAction: () {
                      if (formKey.currentState!.validate()) {
                        type == 'doctor'
                            ? Navigator.pushNamed(
                                context, Routes.doctorContinueSignUpScreen)
                            : Navigator.pushNamed(
                                context, Routes.patientContinueSignUpScreen);
                      }
                    },
                    buttonText: 'Next',
                    height: 50.h,
                    borderRadius: 10,
                    textStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500),
                  ),
                  verticalSpace(16),
                  AuthContinueQuestion(
                    label: 'Already have an account?',
                    action: 'Sign In',
                    route: Routes.loginScreen,
                    type: type,
                  ),
                  verticalSpace(24),
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
