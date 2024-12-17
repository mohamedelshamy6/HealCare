import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../notification/views/screens/notifications_screen.dart';
import '../../../patient_booking/views/screens/patient_booking_screen.dart';
import '../../logic/bottom_navigation_bar_cubit.dart';

import '../../../doctor_home/view/screens/doctor_booking.dart';
import '../../../doctor_home/view/screens/doctor_chat.dart';
import '../../../doctor_home/view/screens/doctor_home_screen.dart';
import '../../../doctor_home/view/screens/doctor_profile.dart';
import '../../../doctor_home/view/screens/doctor_wallet.dart';
import '../../../patient_home/view/screens/patient_home_screen.dart';
import '../widgets/bottom_navigation_bar_home_item.dart';
import '../widgets/bottom_navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final String type;
  const CustomBottomNavigationBar({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> patientPages = [
      PatientBookingScreen(),
      Center(child: Text('chat')),
      PatientHomeScreen(),
      NotificationsScreen(),
      Center(child: Text('profile')),
    ];

    List<Widget> doctorPages = [
      DoctorBooking(),
      DoctorChat(),
      DoctorHomeScreen(),
      DoctorWallet(),
      DoctorProfile()
    ];
    var cubit = BlocProvider.of<BottomNavigationBarCubit>(context);

    return BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
      builder: (context, state) {
        return Scaffold(
          body: type == 'patient'
              ? patientPages[cubit.selectedIndex]
              : doctorPages[cubit.selectedIndex],
          bottomNavigationBar: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    5,
                    (index) => index == 2
                        ? SizedBox(width: 32.w)
                        : CustomBottomNavigationBarItem(
                            type: type,
                            index: index,
                          ),
                  ),
                ),
              ),
              Positioned(
                top: -12.h,
                right: type == 'patient'
                    ? MediaQuery.sizeOf(context).width < 400
                        ? 142.w
                        : 164.w
                    : MediaQuery.sizeOf(context).width < 400
                        ? 136.w
                        : 160.w,
                child: BottomNavigationBarHomeItem(),
              ),
            ],
          ),
        );
      },
    );
  }
}
