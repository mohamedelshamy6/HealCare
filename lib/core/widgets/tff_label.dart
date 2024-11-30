import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

class TFFLabel extends StatelessWidget {
  final String label;
  const TFFLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        label,
        style: AppTextStyles.poppinsBlack(16, FontWeight.w600),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
