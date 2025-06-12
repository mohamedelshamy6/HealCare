import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/book_shimmer.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/custom_app_bar_shimmer.dart';

class DoctorBookingLoading extends StatelessWidget {
  const DoctorBookingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 50.h),
      child: Column(
        children: [
          const CustomAppBarShimmer(),
          verticalSpace(20),
          const Expanded(child: BookingShimmer()),
        ],
      ),
    );
  }
}
