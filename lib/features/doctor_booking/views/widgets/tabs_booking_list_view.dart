import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import '../../../../core/routing/routes.dart';
import 'booking_item.dart';

class TabsBookingListView extends StatelessWidget {
  const TabsBookingListView({
    super.key,
    required this.allBookingModel,
    required this.selectedIndex,
  });

  final List<DoctorBookingModel> allBookingModel;
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(Routes.detailsScreen, arguments: {
                        'doctorBookingModel': allBookingModel[index],
                        'selectedIndex': selectedIndex,
                      });
                    },
                    child: BookingItem(
                      selectedIndex: selectedIndex,
                      patientsModel: allBookingModel[index].patient!,
                      bookingModel: allBookingModel[index],
                    ),
                  ))
              : Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Routes.detailsScreen,
                        arguments: {
                          'doctorBookingModel': allBookingModel[index],
                          'selectedIndex': selectedIndex,
                        },
                      );
                    },
                    child: BookingItem(
                      bookingModel: allBookingModel[index],
                      selectedIndex: selectedIndex,
                      patientsModel: allBookingModel[index].patient!,
                    ),
                  ),
                );
        });
  }
}
