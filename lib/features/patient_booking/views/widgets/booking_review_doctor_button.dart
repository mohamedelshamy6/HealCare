import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';
import 'package:heal_care/features/patient_booking/logic/cubit/cubit/rate_cubit.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'review_dialog.dart';

class BookingReviewDoctorButton extends StatelessWidget {
  final String doctorId;
  final String patientId;
  final String doctorName;
  const BookingReviewDoctorButton({
    super.key,
    required this.doctorId,
    required this.patientId,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showAdaptiveDialog(
          context: context,
          builder: (context) => BlocProvider(
            create: (context) => RateCubit(
              DependencyInjection.getIt(),
            ),
            child: ReviewDialog(
              doctorId: doctorId,
              patientId: patientId,
              doctorName: doctorName,
            ),
          ),
        );
      },
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      child: Container(
        constraints: BoxConstraints(maxWidth: 140.w),
        height: 24.h,
        padding: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.iconsReviewIconWhite),
            horizontalSpace(2),
            Text(
              'Review',
              style: AppTextStyles.poppinsWhite(
                10,
                FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
