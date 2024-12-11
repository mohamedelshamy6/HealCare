import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_bar.dart';
import 'package:heal_care/core/widgets/custom_tab_bar.dart';
import 'package:heal_care/features/doctor_home/data/models/all_booking_model.dart';
import 'package:heal_care/features/doctor_home/logic/tabbar_cubit/tabbar_cubit.dart';
import '../widgets/tabs_booking_list_view.dart';

class DoctorBooking extends StatelessWidget {
  const DoctorBooking({super.key});

  @override
  Widget build(BuildContext context) {
    List<AllBookingModel> bookingList = [
      AllBookingModel(
          name: 'John Deo',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: 'assets/images/patients/patient_m.png',
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Lama',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: 'assets/images/patients/patient_f.png',
          jobAddress: 'Nutritionist',
          startDate: '02 February 2024',
          endDate: '2:00 PM - 3:00 PM'),
      AllBookingModel(
          name: 'Mala',
          specialty: 'M.Sc. - lunch and Nutrition',
          imageUrl: 'assets/images/patients/patient_f2.png',
          jobAddress: 'Nutritionist',
          startDate: '02 February 2025',
          endDate: '3:00 PM - 4:00 PM'),
      AllBookingModel(
          name: 'Linda',
          specialty: 'M.Sc. - Food only',
          imageUrl: 'assets/images/patients/patient_f3.png',
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Sam',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: 'assets/images/patients/patient_m2.png',
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Dan',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: 'assets/images/patients/patient_m3.png',
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Mad',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: 'assets/images/patients/patient_m4.png',
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Leo',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: 'assets/images/patients/patient_m5.png',
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
      AllBookingModel(
          name: 'Ramy',
          specialty: 'M.Sc. - Food and Nutrition',
          imageUrl: 'assets/images/patients/patient_m6.png',
          jobAddress: 'Nutritionist',
          startDate: '02 February 2023',
          endDate: '1:00 PM - 2:00 PM'),
    ];
    int selectedIndex = 0;
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
                  BlocBuilder<TabbarCubit, TabbarState>(
                    builder: (context, state) {
                      return context.read<TabbarCubit>().selectedIndex == 0
                          ? Text(
                              'Cancel All',
                              style: AppTextStyles.poppinsBlack(
                                      14, FontWeight.w500)
                                  .copyWith(
                                color: AppColors.tFFErrorColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.tFFErrorColor,
                              ),
                            )
                          : Container();
                    },
                  ),
                ],
              ),
              verticalSpace(20),
              CustomTabBar(
                selectedIndex:
                    BlocProvider.of<TabbarCubit>(context).selectedIndex,
                onTabChange: (index) {
                  BlocProvider.of<TabbarCubit>(context).changeTabs(index);
                },
              ),
              verticalSpace(16),
              Expanded(
                child: TabBarView(children: [
                  BlocBuilder<TabbarCubit, TabbarState>(
                    builder: (context, state) {
                      int currentIndex =
                          context.read<TabbarCubit>().selectedIndex;

                      return TabsBookingListView(
                          allBookingModel: bookingList, selectedIndex: currentIndex);
                    },
                  ),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
