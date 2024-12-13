import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/features/bottom_navigation_bar/logic/bottom_navigation_bar_cubit.dart';

class BottomNavigationBarHomeItem extends StatelessWidget {
  const BottomNavigationBarHomeItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<BottomNavigationBarCubit>(context);

    return Positioned(
      top: -12.h,
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
        onTap: () {
          cubit.indexChanged(2);
        },
        child: CircleAvatar(
          radius: 34.r,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            radius: 28.r,
            backgroundColor: cubit.selectedIndex == 2
                ? AppColors.mainColor
                : AppColors.bottomNavBarItemColor,
            child: Center(
              child: SvgPicture.asset(
                Assets.iconsHomeIconWhite,
                width: cubit.selectedIndex == 2 ? 28.w : 22.w,
                height: cubit.selectedIndex == 2 ? 28.h : 22.h,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
