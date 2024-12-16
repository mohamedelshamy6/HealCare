import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/features/patient_home/data/models/doctors_model.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../widgets/booking_review_doctor_button.dart';
import '../widgets/delete_booking_button.dart';
import '../widgets/patient_booking_card_header.dart';

class PatientBookingCard extends StatelessWidget {
  final int index;
  const PatientBookingCard({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border:
            Border.all(color: AppColors.findDoctorsCardBorderColor, width: 2),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      child: Column(
        spacing: 10.h,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PatientBookingCardHeader(
            index: index,
          ),
          Row(
            spacing: 8.w,
            children: [
              SvgPicture.asset(
                Assets.iconsCalenderIconDarkblue,
                width: 16.w,
                height: 16.h,
              ),
              Text(
                '02 February 2023',
                style: AppTextStyles.poppinsBlack(
                  10,
                  FontWeight.w400,
                ),
              ),
              SvgPicture.asset(
                Assets.iconsClockIconDarkblue,
                width: 14.w,
                height: 14.h,
              ),
              Text(
                '1:00 PM - 2:00 PM',
                style: AppTextStyles.poppinsBlack(
                  10,
                  FontWeight.w400,
                ),
              ),
              MediaQuery.of(context).size.width < 400
                  ? SizedBox()
                  : DeleteBookingButton(),
            ],
          ),
          MediaQuery.of(context).size.width < 400
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DeleteBookingButton(),
                    BookingReviewDoctorButton(
                      doctorName: doctors[index].name,
                    ),
                  ],
                )
              : SizedBox(),
          MediaQuery.of(context).size.width < 400
              ? SizedBox()
              : Center(
                  child: BookingReviewDoctorButton(
                    doctorName: doctors[index].name,
                  ),
                ),
        ],
      ),
    );
  }
}
