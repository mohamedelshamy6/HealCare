import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';

class PatientHomeBanner extends StatefulWidget {
  const PatientHomeBanner({
    super.key,
  });

  @override
  State<PatientHomeBanner> createState() => _PatientHomeBannerState();
}

class _PatientHomeBannerState extends State<PatientHomeBanner> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 210.h,
            child: PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              itemCount: 3,
              itemBuilder: (context, index) =>
                  Image.asset(Assets.imagesPatientHomeBanner),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height < 900 ? 42.h : 36.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  margin: EdgeInsets.only(right: 4.w),
                  width: index == currentPage ? 16.w : 4.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
