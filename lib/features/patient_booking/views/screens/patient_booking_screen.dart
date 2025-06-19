import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/patient_booking/logic/cubit/appointementcubit_cubit.dart';
import 'package:heal_care/features/patient_booking/views/widgets/shimmer_loading_booking_card.dart';
import '../widgets/patient_booking_card.dart';

class PatientBookingScreen extends StatefulWidget {
  const PatientBookingScreen({super.key});

  @override
  State<PatientBookingScreen> createState() => _PatientBookingScreenState();
}

class _PatientBookingScreenState extends State<PatientBookingScreen> {
  @override
  void initState() {
    super.initState();
    // Ensure doctors are loaded when the screen initializes
    context.read<DoctorsCubit>().getAllDoctors();
    // Also fetch appointments if needed
    context.read<AppointementcubitCubit>().fetchAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: CustomAppHeader(title: 'My Bookings')),
              verticalSpace(24),
              // Doctors list section
              Expanded(
                child: BlocBuilder<DoctorsCubit, DoctorsState>(
                  builder: (context, state) {
                    if (state is DoctorsLoading) {
                      return ShimmerLoadingBookingCard();
                    } else if (state is DoctorsFailure) {
                      return Center(
                        child: Text(
                          'Failed to load doctors: ${state.error}',
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (state is DoctorsSuccess) {
                      final doctors = state.doctorsModel;
                      if (doctors.isEmpty) {
                        return const Center(
                          child: Text('No doctors available'),
                        );
                      }

                      return BlocBuilder<AppointementcubitCubit,
                          AppointementcubitState>(
                        builder: (context, appointmentState) {
                          if (appointmentState is AppointementcubitLoading) {
                            return ShimmerLoadingBookingCard();
                          }

                          // Get appointments if available
                          final appointments =
                              appointmentState is AppointementcubitSuccess
                                  ? appointmentState.appointments
                                  : [];

                          if (appointments.isEmpty) {
                            return const Center(
                              child: Text('You have no upcoming appointments'),
                            );
                          }

                          // Get unique doctor IDs from appointments
                          final doctorIdsWithAppointments =
                              appointments.map((appt) => appt.doctorId).toSet();

                          // Filter doctors to only those with appointments
                          final doctorsWithAppointments = doctors
                              .where(
                                (doctor) => doctorIdsWithAppointments
                                    .contains(doctor.id),
                              )
                              .toList();

                          if (doctorsWithAppointments.isEmpty) {
                            return const Center(
                              child: Text(
                                  'No doctors found for your appointments'),
                            );
                          }

                          return ListView.builder(
                            itemCount: doctorsWithAppointments.length,
                            itemBuilder: (context, index) {
                              final doctor = doctorsWithAppointments[index];
                              // Find appointments for this doctor
                              final doctorAppointments = appointments
                                  .where((appt) => appt.doctorId == doctor.id)
                                  .toList();

                              return PatientBookingCard(
                                appointment: appointments[index],
                              );
                            },
                          );
                        },
                      );
                    }
                    return const Center(
                        child: Text('No doctors data available'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widget for consistent spacing
Widget verticalSpace(double height) => SizedBox(height: height.h);
