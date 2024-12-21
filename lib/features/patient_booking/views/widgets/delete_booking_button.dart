import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/theme/app_text_styles.dart';
import 'delete_booking_dialog.dart';

class DeleteBookingButton extends StatelessWidget {
  const DeleteBookingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAdaptiveDialog(
          context: context,
          builder: (context) => DeleteBookingDialog(),
        );
      },
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        constraints: BoxConstraints(maxWidth: 56.w),
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: AppColors.tFFErrorColor,
            width: 0.5.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SvgPicture.asset(
                Assets.iconsTrashIconRed,
                width: 14.w,
                height: 14.h,
              ),
            ),
            Text(
              'Delete',
              style: AppTextStyles.poppinsBlack(10, FontWeight.w400)
                  .copyWith(color: AppColors.tFFErrorColor),
            ),
          ],
        ),
      ),
    );
  }
}
