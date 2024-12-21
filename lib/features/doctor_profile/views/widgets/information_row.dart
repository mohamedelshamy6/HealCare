import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';

import '../../../../core/theme/app_text_styles.dart';

class InformationRow extends StatelessWidget {
  final String icon, label, value;
  const InformationRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SvgPicture.asset(icon),
            horizontalSpace(8),
            Text(
              label,
              style: AppTextStyles.poppinsBlack(13, FontWeight.w400),
            ),
            Expanded(
              child: Text(
                textAlign: TextAlign.end,
                value,
                style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
              ),
            ),
          ],
        ),
        Divider(color: AppColors.mainGrey.withOpacity(0.5)),
      ],
    );
  }
}
