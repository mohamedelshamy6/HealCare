import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../patient_home/data/models/doctors_model.dart';
import '../widgets/patient_booking_card.dart';

class PatientBookingScreen extends StatelessWidget {
  const PatientBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppHeader(
                  title: 'Booking',
                ),
                verticalSpace(24),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        PatientBookingCard(index: index),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 10.h),
                    itemCount: doctors.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
