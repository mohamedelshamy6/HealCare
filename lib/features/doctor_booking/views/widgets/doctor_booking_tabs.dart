import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:heal_care/features/doctor_booking/logic/cubit/doctorbooking_cubit.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/book_shimmer.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/tabs_booking_list_view.dart';

class DoctorBookingTabs extends StatelessWidget {
  const DoctorBookingTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorbookingCubit, DoctorbookingState>(
      builder: (context, state) {
        if (state is DoctorbookingLoading) {
          return const BookingShimmer();
        } else if (state is DoctorbookingFailure) {
          return Center(child: Text(state.message));
        } else if (state is DoctorbookingSuccess) {
          final allBookingModel = state.doctorBooking;

          return TabBarView(
            children: List.generate(4, (int index) {
              List<DoctorBookingModel> filteredBookings;

              switch (index) {
                case 1:
                  filteredBookings = allBookingModel
                      .where((booking) => booking.status == 'scheduled')
                      .toList();
                  break;
                case 2:
                  filteredBookings = allBookingModel
                      .where((booking) => booking.status == 'completed')
                      .toList();
                  break;
                case 3:
                  filteredBookings = allBookingModel
                      .where((booking) => booking.status == 'cancelled')
                      .toList();
                  break;
                default:
                  filteredBookings = allBookingModel;
              }

              return TabsBookingListView(
                allBookingModel: filteredBookings,
                selectedIndex: index,
              );
            }),
          );
        } else {
          return const BookingShimmer();
        }
      },
    );
  }
}
