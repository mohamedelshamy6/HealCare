import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../data/models/doctors_model.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/payment_header.dart';
import '../widgets/payment_method.dart';
import '../widgets/schedule_date.dart';

class BookingPayment extends StatelessWidget {
  final DoctorsModel doctorsModel;
  const BookingPayment({
    super.key,
    required this.doctorsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(16.r),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
                ),
                verticalSpace(8),
                Text(
                  'IDR 200.000',
                  style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
                ),
              ],
            ),
            Spacer(),
            CustomButton(
              borderRadius: 8.r,
              height: 48.h,
              width: 164.w,
              buttonText: 'Pay',
              buttonAction: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Routes.paymentSuccess,
                  (route) => false,
                  arguments: doctorsModel,
                );
              },
              textStyle: AppTextStyles.poppinsWhite(14, FontWeight.w700),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24.w, top: 16.h),
                child: CustomAppHeader(
                  canBack: true,
                  title: 'Payment',
                  horizSpace: MediaQuery.sizeOf(context).width < 400 ? 56 : 72,
                ),
              ),
              verticalSpace(8),
              PaymentHeader(doctorsModel: doctorsModel),
              verticalSpace(8),
              ScheduleDate(),
              verticalSpace(12),
              PaymentMethod(),
              verticalSpace(8),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Payment',
                      style: AppTextStyles.poppinsBlack(14, FontWeight.w700),
                    ),
                    verticalSpace(12),
                    Row(
                      children: [
                        Text(
                          'Consultation Fee',
                          style: AppTextStyles.poppinsGrey(14, FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          'IDR 200.000',
                          style:
                              AppTextStyles.poppinsBlack(14, FontWeight.w700),
                        ),
                      ],
                    ),
                    verticalSpace(12),
                    Row(
                      children: [
                        Text(
                          'Admin',
                          style: AppTextStyles.poppinsGrey(14, FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          'Free',
                          style:
                              AppTextStyles.poppinsBlack(14, FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
