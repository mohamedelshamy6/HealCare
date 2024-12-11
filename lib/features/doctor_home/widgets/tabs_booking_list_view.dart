
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/doctor_home/data/models/all_booking_model.dart';
import 'package:heal_care/features/doctor_home/widgets/booking_item.dart';
class TabsBookingListView extends StatelessWidget {
  const TabsBookingListView({
    super.key,
    required this.allBookingModel,
    required this.selectedIndex,
  });

  final List<AllBookingModel> allBookingModel;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: allBookingModel.length,
        itemBuilder: (context, index) {
          index = index;
          return allBookingModel.length == 1
              ? SizedBox(
                  height: 180.h,
                  child: BookingItem(
                    selectedIndex: selectedIndex,
                    allBookingModel: allBookingModel[index],
                  ))
              : Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: BookingItem(
                    selectedIndex: selectedIndex,
                    allBookingModel: allBookingModel[index],
                  ),
                );
        });
  }
}
