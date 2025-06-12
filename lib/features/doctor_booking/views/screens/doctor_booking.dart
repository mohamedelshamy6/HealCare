
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/widgets/custom_app_bar.dart';
import 'package:heal_care/core/widgets/custom_tab_bar.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/doctor_booking/logic/cubit/doctorbooking_cubit.dart';
import 'package:heal_care/features/doctor_booking/logic/tabbar_cubit/tabbar_cubit.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/doctor_booking_loading.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/doctor_booking_tabs.dart';

class DoctorBooking extends StatelessWidget {
  const DoctorBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) {
        if (state is DoctorsLoading) {
          return const DoctorBookingLoading();
        } else if (state is DoctorsFailure) {
          return Center(child: Text('Failed to load doctors: ${state.error}'));
        } else if (state is DoctorsSuccess) {
          final doctorId =
              state.doctorsModel.isNotEmpty ? state.doctorsModel[0].id : null;

          if (doctorId == null) {
            return const Center(child: Text('No doctor found.'));
          }

          final patientState = context.read<PatientsCubit>().state;
          if (patientState is PatientsSuccess) {
            context.read<DoctorbookingCubit>().fetchAppointments(doctorId);
          }

          return BlocListener<PatientsCubit, PatientsState>(
            listener: (context, patientState) {
              if (patientState is PatientsSuccess) {
                final doctorBookingCubit = context.read<DoctorbookingCubit>();
                doctorBookingCubit.fetchAppointments(doctorId);
              }
            },
            child: DefaultTabController(
              initialIndex: 0,
              length: 4,
              child: Scaffold(
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 13.w,
                      right: 13.w,
                      top: 24.h,
                    ),
                    child: Column(
                      children: [
                        CustomAppBar(
                          backgroundColor: Colors.transparent,
                          title: 'All Booking',
                        ),
                        verticalSpace(16),
                        CustomTabBar(
                          selectedIndex:
                              context.read<TabbarCubit>().selectedIndex,
                          onTabChange: (index) {
                            context.read<TabbarCubit>().changeTabs(index);
                          },
                        ),
                        verticalSpace(16),
                        const Expanded(
                          child: DoctorBookingTabs(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
