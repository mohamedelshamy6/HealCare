import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class DoctorHomeLoadingShimmer extends StatelessWidget {
  const DoctorHomeLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
        ),
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10.h,
                        width: 120.w,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        height: 10.h,
                        width: 80.w,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Container(height: 10.h, width: 100.w, color: Colors.grey),
            SizedBox(height: 6.h),
            Container(height: 10.h, width: 150.w, color: Colors.grey),
            SizedBox(height: 12.h),
            Container(height: 24.h, width: 100.w, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
