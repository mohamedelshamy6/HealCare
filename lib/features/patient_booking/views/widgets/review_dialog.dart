
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_text_form_field.dart';
import 'package:heal_care/features/patient_booking/logic/cubit/cubit/rate_cubit.dart';

import '../../../../core/widgets/custom_button.dart';

class ReviewDialog extends StatefulWidget {
  final String doctorName;
  final String doctorId;
  final String patientId;

  const ReviewDialog({
    super.key,
    required this.doctorName,
    required this.doctorId,
    required this.patientId,
  });

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final TextEditingController feedbackController = TextEditingController();
  double rating = 0;

  void submitFeedback(BuildContext context) {
    final body = {
      "doctor_id": widget.doctorId,
      "patient_id": widget.patientId,
      "rate": rating,
      "feedback": feedbackController.text.trim(),
    };

    context.read<RateCubit>().rateDoctor(
          path: '${AppConstants.baseRestUrl}rates',
          body: body,
        );
  }

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
              'Give a feedback about ${widget.doctorName}',
              textAlign: TextAlign.center,
              style: AppTextStyles.poppinsBlack(18, FontWeight.w400),
            ),
            verticalSpace(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                final isFilled = rating >= starIndex;

                return GestureDetector(
                  onTap: () {
                    setState(() => rating = starIndex.toDouble());
                  },
                  child: Opacity(
                    opacity: isFilled ? 1.0 : 0.3,
                    child: SvgPicture.asset(
                      Assets.iconsStarIconYellow,
                      height:
                          MediaQuery.of(context).size.width < 400 ? 32.h : 42.h,
                      width:
                          MediaQuery.of(context).size.width < 400 ? 32.h : 42.w,
                    ),
                  ),
                );
              }),
            ),
            verticalSpace(32),
            Material(
              child: CustomTFF(
                controller: feedbackController,
                hintText: 'Write your feedback',
                kbType: TextInputType.text,
                borderRadius: 12.r,
                color: const Color(0xfff5f5f5),
                maxLines: 3,
              ),
            ),
            verticalSpace(20),
            BlocConsumer<RateCubit, RateState>(
              listener: (context, state) {
                if (state is RateSuccess) {
                  HelperMethods.showCustomSnackBarSuccess(
                      context, 'Feedback submitted successfully');
                  Navigator.pop(context);
                } else if (state is RateError) {
                  HelperMethods.showCustomSnackBarError(context, state.error);
                }
                if (state is RateLoading) {
                  HelperMethods.showLoadingAlertDialog(context);
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return CustomButton(
                  buttonAction: () => submitFeedback(context),
                  buttonText: 'Done',
                  borderRadius: 12.r,
                  textStyle: AppTextStyles.poppinsWhite(16, FontWeight.w500),
                  height: 48.h,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
