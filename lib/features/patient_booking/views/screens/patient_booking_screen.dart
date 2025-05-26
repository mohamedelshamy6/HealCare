import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/patient_booking/logic/cubit/appointementcubit_cubit.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../widgets/patient_booking_card.dart';

class PatientBookingScreen extends StatelessWidget {
  const PatientBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CustomAppHeader(title: 'Booking'),
                verticalSpace(24),
                BlocBuilder<AppointementcubitCubit, AppointementcubitState>(
                  builder: (context, state) {
                    if (state is AppointementcubitLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AppointementcubitSuccess) {
                      final appointments = state.appointments;
                      if (appointments.isEmpty) {
                        return const Center(child: Text('No Appointments'));
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => PatientBookingCard(
                          appointment: appointments[index],
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10.h),
                        itemCount: appointments.length,
                      );
                    } else if (state is AppointementcubitFailure) {
                      return Center(child: Text('Error: ${state.error}'));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}