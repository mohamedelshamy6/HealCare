import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/features/doctor_booking/logic/cubit/doctorbooking_cubit.dart';

class CancelAppointmentDialog extends StatelessWidget {
  final String appointmentId;
  final DoctorbookingCubit cubit;

  const CancelAppointmentDialog({
    super.key,
    required this.appointmentId,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 31.h),
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Cancel Appointment',
              textAlign: TextAlign.center,
              style: AppTextStyles.poppinsBlack(
                18,
                FontWeight.w400,
              ),
            ),
            verticalSpace(16),
            Text(
              'Are you sure you want to cancel this appointment?',
              textAlign: TextAlign.center,
              style: AppTextStyles.poppinsBlack(
                14,
                FontWeight.w400,
              ),
            ),
            verticalSpace(32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  buttonAction: () => Navigator.pop(context),
                  buttonText: 'No',
                  borderRadius: 12.r,
                  textStyle: AppTextStyles.poppinsBlack(16, FontWeight.w500),
                  height: 48.h,
                  color: Colors.grey[200],
                ),
                CustomButton(
                  buttonAction: () async {
                    await cubit.cancelAppointment(appointmentId);
                    if (context.mounted) {
                      Navigator.pop(context);
                      // Refresh the data
                      final doctorId = cubit.doctorBooking.isNotEmpty
                          ? cubit.doctorBooking[0].doctorId
                          : '';
                      if (doctorId != null && doctorId.isNotEmpty) {
                        cubit.fetchAppointments(doctorId);
                      }
                    }
                  },
                  buttonText: 'Yes',
                  borderRadius: 12.r,
                  textStyle: AppTextStyles.poppinsWhite(16, FontWeight.w500),
                  height: 48.h,
                  color: AppColors.tFFErrorColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
