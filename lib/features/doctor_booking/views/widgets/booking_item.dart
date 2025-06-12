import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:heal_care/features/doctor_booking/logic/cubit/doctorbooking_cubit.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/booking_cancel_button.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/booking_date_time.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/booking_patient_info.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';


class BookingItem extends StatelessWidget {
  final PatientsModel patientsModel;
  final DoctorBookingModel bookingModel;
  final int selectedIndex;

  const BookingItem({
    super.key,
    required this.selectedIndex,
    required this.patientsModel,
    required this.bookingModel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<DoctorbookingCubit, DoctorbookingState>(
      listener: (context, state) {
        if (state is DoctorbookingCancelAppointmentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is DoctorbookingCancelAppointmentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainWhite,
        ),
        child: Column(
          children: [
            BookingPatientInfo(patientsModel: patientsModel),
            verticalSpace(14),
            BookingDateTime(
              appointmentDate: bookingModel.appointmentDate,
              appointmentTime: bookingModel.appointmentTime,
              isVertical: MediaQuery.of(context).size.width < 400,
            ),
            if (selectedIndex == 0) ...[
              verticalSpace(14),
              BookingCancelButton(
                appointmentId: bookingModel.id ?? '',
                cubit: context.read<DoctorbookingCubit>(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
