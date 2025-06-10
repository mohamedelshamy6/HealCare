import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';

class PaymentHistoryForDoctorShimmer extends StatelessWidget {
  const PaymentHistoryForDoctorShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
                  decoration: BoxDecoration(
                    color: AppColors.mainWhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 10.h,
                        width: 48.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: 14.h, width: 120.w, color: Colors.white),
                          SizedBox(height: 6.h),
                          Container(
                              height: 12.h, width: 180.w, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
                  decoration: BoxDecoration(
                    color: AppColors.mainWhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 70.h,
                        width: 70.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                height: 14.h,
                                width: 120.w,
                                color: Colors.white),
                            SizedBox(height: 6.h),
                            Container(
                                height: 12.h,
                                width: 180.w,
                                color: Colors.white),
                            SizedBox(height: 6.h),
                            Container(
                                height: 12.h,
                                width: 140.w,
                                color: Colors.white),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Container(
                                    height: 10.h,
                                    width: 70.w,
                                    color: Colors.white),
                                SizedBox(width: 10.w),
                                Container(
                                    height: 10.h,
                                    width: 60.w,
                                    color: Colors.white),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
