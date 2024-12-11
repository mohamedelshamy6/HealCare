import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_bar.dart';
import 'package:heal_care/core/widgets/custom_tab_bar.dart';
import '../widgets/tabs_booking_list_view.dart';

class DoctorBooking extends StatefulWidget {
  const DoctorBooking({super.key});

  @override
  State<DoctorBooking> createState() => _DoctorBookingState();
}

class _DoctorBookingState extends State<DoctorBooking> {
  int selectedIndex = 0;
  List<String> images = [
    'assets/images/patients/patient_m.png',
    'assets/images/patients/patient_f.png',
    'assets/images/patients/patient_f2.png',
    'assets/images/patients/patient_f3.png',
    'assets/images/patients/patient_m2.png',
    'assets/images/patients/patient_m3.png',
    'assets/images/patients/patient_m4.png',
    'assets/images/patients/patient_m5.png',
    'assets/images/patients/patient_m6.png',
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: selectedIndex,
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 13.w, right: 13.w, top: 24.h),
            child: Column(children: [
              CustomAppBar(
                backgroundColor: Colors.transparent,
                title: 'All Booking',
                actionsWidgets: [
                  selectedIndex == 0
                      ? Text(
                          'Cancel All',
                          style: AppTextStyles.poppinsBlack(14, FontWeight.w500)
                              .copyWith(
                            color: Color(0xffF23A00),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xffF23A00),
                          ),
                        )
                      : Container(),
                ],
              ),
              verticalSpace(20),
              CustomTabBar(
                selectedIndex: selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
              verticalSpace(16),
              Expanded(
                child: TabBarView(children: [
                  TabsBookingListView(images: images, selectedIndex: selectedIndex),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

