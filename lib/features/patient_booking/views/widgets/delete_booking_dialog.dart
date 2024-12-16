import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class DeleteBookingDialog extends StatelessWidget {
  const DeleteBookingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Delete Booking',
              textAlign: TextAlign.center,
              style: AppTextStyles.poppinsBlack(
                18,
                FontWeight.w500,
              ),
            ),
            verticalSpace(16),
            Divider(color: Color(0xfff2f2f2)),
            verticalSpace(12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Text(
                'Are you sure you want to delete this item?',
                textAlign: TextAlign.center,
                style: AppTextStyles.poppinsBlack(
                  16,
                  FontWeight.w400,
                ),
              ),
            ),
            verticalSpace(24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonAction: () => Navigator.pop(context),
                      buttonText: 'Yes',
                      borderRadius: 8.r,
                      textStyle:
                          AppTextStyles.poppinsWhite(16, FontWeight.w500),
                      height: 44.h,
                    ),
                  ),
                  horizontalSpace(20),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      highlightColor: Colors.transparent,
                      splashFactory: NoSplash.splashFactory,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.tFFErrorColor,
                          ),
                        ),
                        height: 44.h,
                        child: Center(
                          child: Text(
                            'No',
                            style:
                                AppTextStyles.poppinsBlack(16, FontWeight.w500)
                                    .copyWith(color: AppColors.tFFErrorColor),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
