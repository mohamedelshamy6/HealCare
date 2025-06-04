import 'package:flutter/material.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'doctor_card_home.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({super.key, required this.patientsModel});
  final List<PatientsModel> patientsModel;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: DoctorCardHome(
              patient: patientsModel[index],
            ),
          );
        },
        childCount: patientsModel.length,
      ),
    );
  }
}
