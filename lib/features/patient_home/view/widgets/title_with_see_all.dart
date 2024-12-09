import 'package:flutter/material.dart';
import '../../../../core/theme/app_text_styles.dart';

class TitleWithSeeAll extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const TitleWithSeeAll({
    super.key,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
        ),
        Spacer(),
        TextButton(
          onPressed: onPressed ?? () {},
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            overlayColor: WidgetStatePropertyAll(Colors.transparent),
            surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
          child: Text(
            'See All',
            style: AppTextStyles.poppinsMainColor(14, FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
