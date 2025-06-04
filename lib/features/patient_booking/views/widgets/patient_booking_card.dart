import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/patient_booking/data/model/appoientment_model.dart';
import 'package:heal_care/features/patient_booking/views/widgets/booking_review_doctor_button.dart';
import 'package:heal_care/features/patient_booking/views/widgets/delete_booking_button.dart';
import 'package:heal_care/features/patient_booking/views/widgets/patient_booking_card_header.dart';

class PatientBookingCard extends StatelessWidget {
  final AppointmentModel appointment;

  const PatientBookingCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final doctor = appointment.doctor;

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
          PatientBookingCardHeader(doctor: doctor),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.w,
            children: [
              SvgPicture.asset(Assets.iconsCalenderIconDarkblue,
                  width: 16.w, height: 16.h),
              Text(
                appointment.appointmentDate,
                style: AppTextStyles.poppinsBlack(10, FontWeight.w400),
              ),
              SvgPicture.asset(Assets.iconsClockIconDarkblue,
                  width: 14.w, height: 14.h),
              Text(
                appointment.appointmentTime,
                style: AppTextStyles.poppinsBlack(10, FontWeight.w400),
              ),
              MediaQuery.of(context).size.width < 410
                  ? SizedBox()
                  : DeleteBookingButton(),
            ],
          ),
          MediaQuery.of(context).size.width < 410
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DeleteBookingButton(),
                    BookingReviewDoctorButton(
                        doctorId: appointment.doctorId,
                        patientId: appointment.patientId,
                        doctorName: doctor?.name ?? 'Unknown'),
                  ],
                )
              : Center(
                  child: BookingReviewDoctorButton(
                      doctorId: appointment.doctorId,
                      patientId: appointment.patientId,
                      doctorName: doctor?.name ?? 'Unknown'),
                ),
        ],
      ),
    );
  }
}
