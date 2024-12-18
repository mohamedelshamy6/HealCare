import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

class ReviewDialog extends StatelessWidget {
  final String doctorName;
  const ReviewDialog({super.key, required this.doctorName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 48.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Give a feedback about $doctorName',
              textAlign: TextAlign.center,
              style: AppTextStyles.poppinsBlack(
                18,
                FontWeight.w400,
              ),
            ),
            verticalSpace(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                5,
                (index) => index == 0
                    ? SvgPicture.asset(
                        Assets.iconsStarIconYellow,
                        height: MediaQuery.of(context).size.width < 400
                            ? 32.h
                            : 42.h,
                        width: MediaQuery.of(context).size.width < 400
                            ? 32.h
                            : 42.w,
                      )
                    : Opacity(
                        opacity: 0.3,
                        child: SvgPicture.asset(
                          Assets.iconsStarIconYellow,
                          height: MediaQuery.of(context).size.width < 400
                              ? 32.h
                              : 42.h,
                          width: MediaQuery.of(context).size.width < 400
                              ? 32.h
                              : 42.w,
                        ),
                      ),
              ),
            ),
            verticalSpace(32),
            CustomTFF(
              hintText: 'Write your feedback',
              kbType: TextInputType.text,
              borderRadius: 12.r,
              color: Color(0xfff5f5f5),
              maxLines: 3,
            ),
            verticalSpace(20),
            CustomButton(
              buttonAction: () => Navigator.pop(context),
              buttonText: 'Done',
              borderRadius: 12.r,
              textStyle: AppTextStyles.poppinsWhite(16, FontWeight.w500),
              height: 48.h,
            )
          ],
        ),
      ),
    );
  }
}
