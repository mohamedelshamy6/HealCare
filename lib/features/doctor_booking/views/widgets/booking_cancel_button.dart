import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/features/doctor_booking/logic/cubit/doctorbooking_cubit.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/cancel_appointment_dialog.dart';

class BookingCancelButton extends StatelessWidget {
  final String appointmentId;
  final DoctorbookingCubit cubit;

  const BookingCancelButton({
    super.key,
    required this.appointmentId,
    required this.cubit,
  });

  void _showCancelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CancelAppointmentDialog(
        appointmentId: appointmentId,
        cubit: cubit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorbookingCubit, DoctorbookingState>(
      builder: (context, state) {
        final isLoading = state is DoctorbookingCancelAppointmentLoading;
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: CustomButton(
            color: AppColors.lightOrange,
            buttonText: isLoading ? 'Canceling...' : 'Cancel',
            buttonAction: isLoading ? () {} : () => _showCancelDialog(context),
            textStyle: AppTextStyles.setPoppinsTextStyle(
              color: AppColors.tFFErrorColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
