import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';

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
                              'You have successfully made an payment for appointment',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.poppinsBlack(
                                  20, FontWeight.w700),
                            ),
                            verticalSpace(150),
                            Container(
                              height: 64.h,
                              width: 64.w,
                              decoration: BoxDecoration(
                                color: Colors.pink[200]!.withOpacity(0.35),
                                borderRadius: BorderRadius.circular(24.r),
                                image: DecorationImage(
                                  image: AssetImage(
                                      doctorsModel.image ?? 'unkown'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            verticalSpace(12),
                            Text(
                              doctorsModel.name.toString(),
                              style: AppTextStyles.poppinsBlack(
                                  16, FontWeight.w700),
                            ),
                            verticalSpace(8),
                            Text(
                              doctorsModel.specialization!.contains(' - ')
                                  ? doctorsModel.specialization!
                                      .split('-')
                                      .first
                                  : doctorsModel.specialization!
                                      .split('|')
                                      .first,
                              style: AppTextStyles.poppinsGrey(
                                  12, FontWeight.w500),
                            ),
                            verticalSpace(28),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(36),
                    CustomButton(
                      buttonAction: () =>
                          Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.bookDoctorAppointment,
                        (route) => false,
                        arguments: doctorsModel,
                      ),
                      buttonText: 'Book an Appointment',
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
