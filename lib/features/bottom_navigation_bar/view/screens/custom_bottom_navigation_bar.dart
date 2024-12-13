import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/bottom_navigation_bar/logic/bottom_navigation_bar_cubit.dart';

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
      Center(child: Text('booking')),
      Center(child: Text('chat')),
      Center(child: Text('home')),
      Center(child: Text('notification')),
      Center(child: Text('profile')),
    ];

    List<Widget> doctorPages = [
      Center(child: Text('booking')),
      Center(child: Text('chat')),
      Center(child: Text('home')),
      Center(child: Text('E-Wallet')),
      Center(child: Text('profile')),
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
                        ? SizedBox(width: 50.w)
                        : CustomBottomNavigationBarItem(
                            type: type,
                            index: index,
                          ),
                  ),
                ),
              ),
              BottomNavigationBarHomeItem(),
            ],
          ),
        );
      },
    );
  }
}
