import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/routing/routes.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/doctors_model.dart';

class PaymentSuccess extends StatelessWidget {
  final DoctorsModel doctorsModel;
  const PaymentSuccess({
    super.key,
    required this.doctorsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
              left: 16.w, right: 16.w, top: 128.h, bottom: 32.h),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16.w, 88.h, 16.w, 16.w),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'You have successfully made an appointment',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.poppinsBlack(
                                  20, FontWeight.w700),
                            ),
                            verticalSpace(8),
                            Text(
                              'The appointment confirmation has been send to your email.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.poppinsGrey(
                                  12, FontWeight.w500),
                            ),
                            verticalSpace(40),
                            Container(
                              height: 64.h,
                              width: 64.w,
                              decoration: BoxDecoration(
                                color: Colors.pink[200]!.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(24.r),
                                image: DecorationImage(
                                  image: AssetImage(doctorsModel.image),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            verticalSpace(12),
                            Text(
                              doctorsModel.name,
                              style: AppTextStyles.poppinsBlack(
                                  16, FontWeight.w700),
                            ),
                            verticalSpace(8),
                            Text(
                              doctorsModel.job.contains(' - ')
                                  ? doctorsModel.job.split('-').first
                                  : doctorsModel.job.split('|').first,
                              style: AppTextStyles.poppinsGrey(
                                  12, FontWeight.w500),
                            ),
                            verticalSpace(28),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.mainColor.withOpacity(0.3),
                                    border: Border.all(
                                        color: AppColors.mainColor),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  padding: EdgeInsets.all(6.r),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Assets.svgsAppointmentCalender,
                                    ),
                                  ),
                                ),
                                horizontalSpace(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Appointment',
                                        style: AppTextStyles.poppinsGrey(
                                          12,
                                          FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Wednesday, 10 Jan 2024, 11:00',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyles.poppinsBlack(
                                          14,
                                          FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(36),
                    CustomButton(
                      buttonAction: () =>
                          Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.bottomNavBar,
                        (route) => false,
                        arguments: 'patient',
                      ),
                      buttonText: 'Back to home',
                      textStyle:
                          AppTextStyles.poppinsWhite(14, FontWeight.w700),
                      borderRadius: 8.r,
                      height: 48.h,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -64.h,
                child: SvgPicture.asset(Assets.svgsPaymentSuccess),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
