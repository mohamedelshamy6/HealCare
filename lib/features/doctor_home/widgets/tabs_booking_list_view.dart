
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/doctor_home/widgets/booking_item.dart';
class TabsBookingListView extends StatelessWidget {
  const TabsBookingListView({
    super.key,
    required this.images,
    required this.selectedIndex,
  });

  final List<String> images;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          index = index;
          return images.length == 1
              ? SizedBox(
                  height: 180.h,
                  child: BookingItem(
                    selectedIndex: selectedIndex,
                    imageUrl: images[index],
                  ))
              : Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: BookingItem(
                    selectedIndex: selectedIndex,
                    imageUrl: images[index],
                  ),
                );
        });
  }
}
