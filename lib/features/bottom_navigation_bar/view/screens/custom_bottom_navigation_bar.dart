import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/chat/views/screens/patient_chat.dart';
import 'package:heal_care/features/notification/views/screens/notifications_patients_screen.dart';
import '../../../doctor_profile/views/screens/doctor_profile.dart';

import '../../../doctor_booking/views/screens/doctor_booking.dart';
import '../../../chat/views/screens/doctor_chat.dart';
import '../../../doctor_home/view/screens/doctor_home_screen.dart';
import '../../../doctor_wallet/views/screens/doctor_wallet.dart';
import '../../../patient_booking/views/screens/patient_booking_screen.dart';
import '../../../patient_home/view/screens/patient_home_screen.dart';
import '../../../patient_profile/views/screens/patient_profile.dart';
import '../../logic/bottom_navigation_bar_cubit.dart';
import '../widgets/bottom_navigation_bar_home_item.dart';
import '../widgets/bottom_navigation_bar_item.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/patient_booking/logic/cubit/appointementcubit_cubit.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final String type;
  const CustomBottomNavigationBar({super.key, required this.type});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    context.read<DoctorsCubit>().getAllDoctors();
    context.read<AppointementcubitCubit>().fetchAppointments();
    context.read<PatientsCubit>().getAllPatients();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> patientPages = [
      PatientBookingScreen(),
      PatientChat(type: 'patient'),
      PatientHomeScreen(),
      NotificationsPatientsScreen(
        type: 'patient',
      ),
      PatientProfile(),
    ];

    List<Widget> doctorPages = [
      DoctorBooking(),
      DoctorChat(type: 'doctor'),
      DoctorHomeScreen(),
      DoctorWallet(),
      DoctorProfile()
    ];
    var cubit = BlocProvider.of<BottomNavigationBarCubit>(context);

    return BlocBuilder<BottomNavigationBarCubit, BottomNavigationBarState>(
      builder: (context, state) {
        return Scaffold(
          body: widget.type == 'patient'
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
                            type: widget.type,
                            index: index,
                          ),
                  ),
                ),
              ),
              Positioned(
                top: -12.h,
                child: BottomNavigationBarHomeItem(),
              ),
            ],
          ),
        );
      },
    );
  }
}
