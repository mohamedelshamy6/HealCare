
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.selectedIndex, this.onTabChange,
  });

  final int selectedIndex;
  final Function(int index)?onTabChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(8)),
      height: 44.h,
      width: 349.w,
      child: Center(
        child: TabBar(
          onTap: onTabChange,
          tabAlignment: TabAlignment.center,
          labelPadding: EdgeInsets.zero,
          labelStyle: AppTextStyles.poppinsGrey(12, FontWeight.w500),
          // indicatorSize: TabBarIndicatorSize.tab,
          dividerHeight: 0,
          splashBorderRadius: BorderRadius.circular(8),
          labelColor: selectedIndex == selectedIndex
              ? AppColors.mainColor
              : AppColors.mainGrey,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.lighterBlue,
          ),
          indicatorColor: AppColors.lighterBlue,
          tabs: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w, vertical: 4.h),
              child: Text('All'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w, vertical: 4.h),
              child: Text('Upcoming'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w, vertical: 4.h),
              child: Text('Completed'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.w, vertical: 4.h),
              child: Text('Canceled'),
            ),
          ],
        ),
      ),
    );
  }
}
