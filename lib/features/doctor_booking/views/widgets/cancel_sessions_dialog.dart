import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/core/widgets/custom_text_form_field.dart';

class CancelSessionsDialog extends StatelessWidget {
  const CancelSessionsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0), 
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, 
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 31.h),
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cancel your Sessions',
              textAlign: TextAlign.center,
              style: AppTextStyles.poppinsBlack(
                18,
                FontWeight.w400,
              ),
            ),
            verticalSpace(32),
            CustomTFF(
              hintText: 'Write your Reason',
              kbType: TextInputType.text,
              borderRadius: 12.r,
              color: Color(0xfff5f5f5),
              maxLines: 4,
            ),
            verticalSpace(22),
            CustomButton(
              buttonAction: () => Navigator.pop(context),
              buttonText: 'Done',
              borderRadius: 12.r,
              textStyle: AppTextStyles.poppinsWhite(16, FontWeight.w500),
              height: 48.h,
            ),
          ],
        ),
      ),
    );
  }
}
