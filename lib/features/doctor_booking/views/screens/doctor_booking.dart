import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_bar.dart';
import 'package:heal_care/core/widgets/custom_tab_bar.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:heal_care/features/doctor_booking/logic/cubit/doctorbooking_cubit.dart';
import 'package:heal_care/features/doctor_booking/logic/tabbar_cubit/tabbar_cubit.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/book_shimmer.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/cancel_sessions_dialog.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/custom_app_bar_shimmer.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/tabs_booking_list_view.dart';

class DoctorBooking extends StatelessWidget {
  const DoctorBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) {
        if (state is DoctorsLoading) {
          return Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 50.h),
            child: Column(
              children: [
                const CustomAppBarShimmer(),
                verticalSpace(20),
                Expanded(child: const BookingShimmer()),
              ],
            ),
          );
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
                    padding:
                        EdgeInsets.only(left: 13.w, right: 13.w, top: 24.h),
                    child: Column(
                      children: [
                        CustomAppBar(
                          backgroundColor: Colors.transparent,
                          title: 'All Booking',
                          actionsWidgets: [
                            BlocBuilder<TabbarCubit, TabbarState>(
                              builder: (context, state) {
                                return context
                                            .read<TabbarCubit>()
                                            .selectedIndex ==
                                        0
                                    ? InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                CancelSessionsDialog(),
                                          );
                                        },
                                        child: Text(
                                          'Cancel All',
                                          style: AppTextStyles.poppinsBlack(
                                            14,
                                            FontWeight.w500,
                                          ).copyWith(
                                            color: AppColors.tFFErrorColor,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:
                                                AppColors.tFFErrorColor,
                                          ),
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        ),
                        verticalSpace(20),
                        CustomTabBar(
                          selectedIndex:
                              context.read<TabbarCubit>().selectedIndex,
                          onTabChange: (index) {
                            context.read<TabbarCubit>().changeTabs(index);
                          },
                        ),
                        verticalSpace(16),
                        Expanded(
                          child: BlocBuilder<TabbarCubit, TabbarState>(
                            builder: (context, state) {
                              return TabBarView(
                                children: List.generate(4, (int index) {
                                  return BlocBuilder<DoctorbookingCubit,
                                      DoctorbookingState>(
                                    builder: (context, state) {
                                      if (state is DoctorbookingLoading) {
                                        return const BookingShimmer();
                                      } else if (state
                                          is DoctorbookingFailure) {
                                        return Center(
                                            child: Text(state.message));
                                      } else if (state
                                          is DoctorbookingSuccess) {
                                        final allBookingModel =
                                            state.doctorBooking;

                                        List<DoctorBookingModel>
                                            filteredBookings;

                                        switch (index) {
                                          case 1:
                                            filteredBookings = allBookingModel
                                                .where((booking) =>
                                                    booking.status ==
                                                    'scheduled')
                                                .toList();
                                            break;
                                          case 2:
                                            filteredBookings = allBookingModel
                                                .where((booking) =>
                                                    booking.status ==
                                                    'completed')
                                                .toList();
                                            log('message: ${filteredBookings}');
                                            break;
                                          case 3:
                                            filteredBookings = allBookingModel
                                                .where((booking) =>
                                                    booking.status ==
                                                    'cancelled')
                                                .toList();
                                            log('message: ${filteredBookings}');
                                            break;
                                          default:
                                            filteredBookings = allBookingModel;
                                        }

                                        return TabsBookingListView(
                                          allBookingModel: filteredBookings,
                                          selectedIndex: index,
                                        );
                                      } else {
                                        return const BookingShimmer();
                                      }
                                    },
                                  );
                                }),
                              );
                            },
                          ),
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
