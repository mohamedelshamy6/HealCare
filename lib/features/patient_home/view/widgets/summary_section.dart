import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class SummarySection extends StatelessWidget {
  const SummarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Total Payment',
              style: AppTextStyles.poppinsBlack(14, FontWeight.w700)),
          verticalSpace(12),
          Row(
            children: [
              Text('Consultation Fee',
                  style: AppTextStyles.poppinsGrey(14, FontWeight.w500)),
              const Spacer(),
              Text('IDR 200.000',
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w700)),
            ],
          ),
          verticalSpace(12),
          Row(
            children: [
              Text('Admin',
                  style: AppTextStyles.poppinsGrey(14, FontWeight.w500)),
              const Spacer(),
              Text('Free',
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }
}
