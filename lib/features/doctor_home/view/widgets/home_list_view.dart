import 'package:flutter/material.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'doctor_card_home.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({super.key, required this.appointments});

  final List<DoctorBookingModel> appointments;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DoctorCardHome(
              appointment: appointments[index],
            ),
          );
        },
        childCount: appointments.length,
      ),
    );
  }
}
