import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:shimmer/shimmer.dart';


class CustomAppBarShimmer extends StatelessWidget implements PreferredSizeWidget {
  final double? toolbarHeight;

  const CustomAppBarShimmer({super.key, this.toolbarHeight});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: toolbarHeight ?? 60.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 24.h,
              width: 24.w,
              color: Colors.white,
            ),
            Container(
              height: 20.h,
              width: 120.w,
              color: Colors.white,
            ),
            Container(
              height: 24.h,
              width: 24.w,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, toolbarHeight ?? 60.h);
}
