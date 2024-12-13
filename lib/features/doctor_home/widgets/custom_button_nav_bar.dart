import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/features/doctor_home/logic/tabbar_cubit/tabbar_cubit.dart';
import 'package:heal_care/features/doctor_home/screens/doctor_booking.dart';
import 'package:heal_care/features/doctor_home/screens/doctor_chat.dart';
import 'package:heal_care/features/doctor_home/screens/doctor_home_screen.dart';
import 'package:heal_care/features/doctor_home/screens/doctor_profile.dart';
import 'package:heal_care/features/doctor_home/screens/doctor_wallet.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CustomButtonNavBar extends StatefulWidget {
  const CustomButtonNavBar({super.key});

  @override
  State<CustomButtonNavBar> createState() => _CustomButtonNavBarState();
}

class _CustomButtonNavBarState extends State<CustomButtonNavBar> {
  final controller = PersistentTabController(initialIndex: 2);
  List<Widget> _allScreens() {
    return [
      BlocProvider(
        create: (context) => TabbarCubit(),
        child: DoctorBooking(),
      ),
      DoctorChat(),
      DoctorHomeScreen(),
      DoctorWallet(),
      DoctorProfile()
    ];
  }

  _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.book_online),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.mainGrey,
        title: 'Booking',
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.chat),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.mainGrey,
        title: 'Chat',
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.home,
          color: AppColors.mainWhite,
        ),
        activeColorPrimary: controller.index == 2
            ? AppColors.mainColor
            : AppColors.mainDarkGrey,
        inactiveColorPrimary: AppColors.mainDarkGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.wallet),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.mainGrey,
        title: 'E-Wallet',
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.mainGrey,
        title: 'Profile',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainWhite,
      bottomNavigationBar: PersistentTabView(
        context,
        //margin: EdgeInsets.only(bottom: 12, top: 10),
        padding: EdgeInsets.only(top: 6.h, bottom: 6.h),
        controller: controller,
        screens: _allScreens(),
        /* decoration: NavBarDecoration(
           boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), 
              spreadRadius: .1,
              blurRadius: .1, 
              offset: Offset(0, -.1), 
            ),
          ],
        ), */

        navBarHeight: 60.h,
        // bottomScreenMargin: 12,
        items: _navBarItems(),
        backgroundColor: AppColors.mainWhite,
        navBarStyle: NavBarStyle.style15,
      ),
      body: _allScreens()[controller.index],
    );
  }
}
