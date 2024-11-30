import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/auth_continue_question.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/continue_with_google.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: SingleChildScrollView(
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
                ),
                verticalSpace(20),
                CustomTFF(
                  hintText: 'Password',
                  kbType: TextInputType.emailAddress,
                ),
                verticalSpace(8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
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
                  buttonAction: () {},
                  buttonText: 'Sign In',
                  height: 50.h,
                  borderRadius: 10,
                  buttonStyle: AppTextStyles.poppinsWhite(15, FontWeight.w500),
                ),
                verticalSpace(16),
                AuthContinueQuestion(
                  label: 'Don’t have an account?',
                  action: 'Sign Up',
                  route: 'route',
                ),
                verticalSpace(32),
                ContinueWithGoogle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
