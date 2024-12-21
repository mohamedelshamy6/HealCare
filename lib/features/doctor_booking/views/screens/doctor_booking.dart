import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/doctor_booking/views/widgets/cancel_sessions_dialog.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_tab_bar.dart';
import '../../data/models/all_booking_model.dart';
import '../../logic/tabbar_cubit/tabbar_cubit.dart';
import '../widgets/tabs_booking_list_view.dart';

class DoctorBooking extends StatelessWidget {
  const DoctorBooking({super.key});
  @override
  Widget build(BuildContext context) {
    
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
                          ? InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CancelSessionsDialog(),
                                );
                              },
                              child: Text(
                                'Cancel All',
                                style: AppTextStyles.poppinsBlack(
                                        14, FontWeight.w500)
                                    .copyWith(
                                  color: AppColors.tFFErrorColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.tFFErrorColor,
                                ),
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
                child: BlocBuilder<TabbarCubit, TabbarState>(
                  builder: (context, state) {
                    //   int selectedIndex=context.read<TabbarCubit>().selectedIndex;
                    return TabBarView(
                      children: List.generate(4, (int index) {
                        return TabsBookingListView(
                            allBookingModel: bookingList, selectedIndex: index);
                      }),
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
