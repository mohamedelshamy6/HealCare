import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/doctor_home/widgets/doctor_card_home.dart';

class HomeListView extends StatelessWidget {
  const HomeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(itemCount: 3,itemBuilder: (context,index){
      return Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: DoctorCardHome(),
      );
    });
  }
}