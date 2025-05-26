import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class PatientHomeShimmer extends StatelessWidget {
  const PatientHomeShimmer({super.key});

  Widget shimmerBox(
      {double? height, double? width, BorderRadius? borderRadius}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            // Header
            shimmerBox(height: 24.h, width: 200.w),
            SizedBox(height: 32.h),
            shimmerBox(
                height: 20.h, width: 180.w), // Upcoming Appointments title
            SizedBox(height: 16.h),
            shimmerBox(height: 140.h, width: double.infinity), // Banner

            SizedBox(height: 32.h),
            shimmerBox(height: 20.h, width: 120.w), // Categories title
            SizedBox(height: 8.h),
            // Categories
            SizedBox(
              height: 100.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (_, __) => shimmerBox(
                  height: 100.h,
                  width: 80.w,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),

            SizedBox(height: 24.h),
            shimmerBox(height: 20.h, width: 120.w), // Find Doctors title
            SizedBox(height: 8.h),
            // Doctor Cards
            SizedBox(
              height: 180.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemBuilder: (_, __) => Container(
                  width: 140.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 32.r, backgroundColor: Colors.grey[400]),
                      SizedBox(height: 12.h),
                      shimmerBox(height: 12.h, width: 100.w),
                      SizedBox(height: 8.h),
                      shimmerBox(height: 10.h, width: 80.w),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
