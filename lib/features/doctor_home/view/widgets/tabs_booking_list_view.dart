
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/all_booking_model.dart';
import 'booking_item.dart';
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
