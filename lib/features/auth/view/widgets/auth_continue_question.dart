import 'package:flutter/material.dart';
import '../../../../core/routing/routes.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AuthContinueQuestion extends StatelessWidget {
  final String label, action, route;
  const AuthContinueQuestion(
      {super.key,
      required this.label,
      required this.action,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: AppTextStyles.poppinsBlack(13, FontWeight.w400),
        ),
        TextButton(
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
          onPressed: () => route == Routes.loginScreen
              ? Navigator.pushNamed(
                  context,
                  route,
                )
              : Navigator.pushNamedAndRemoveUntil(
                  context, route, (route) => false),
          child: Text(
            action,
            style: AppTextStyles.poppinsMainColor(14, FontWeight.w500).copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColors.mainColor,
            ),
          ),
        ),
      ],
    );
  }
}
