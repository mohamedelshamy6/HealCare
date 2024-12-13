import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/bottom_navigation_bar_cubit.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  final int index;
  final String type;
  const CustomBottomNavigationBarItem({
    super.key,
    required this.index,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<BottomNavigationBarCubit>(context);
    return InkWell(
      onTap: () {
        cubit.indexChanged(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            cubit.selectedIndex == index
                ? type == 'patient'
                    ? cubit.patientBotNavBarItemsActiveIcon[index]
                    : cubit.doctorBotNavBarItemsActiveIcon[index]
                : type == 'patient'
                    ? cubit.patientBotNavBarItemsInActiveIcon[index]
                    : cubit.doctorBotNavBarItemsInActiveIcon[index],
            width: cubit.selectedIndex == index && (index == 0 || index == 1)
                ? 28.w
                : (cubit.selectedIndex != index &&
                        index == 3 &&
                        type == 'doctor')
                    ? 20.w
                    : 24.w,
            height: cubit.selectedIndex == index && (index == 0 || index == 1)
                ? 28.h
                : (cubit.selectedIndex != index &&
                        index == 3 &&
                        type == 'doctor')
                    ? 20.h
                    : 24.h,
          ),
          verticalSpace(cubit.selectedIndex == index &&
                  (index == 0 || index == 1)
              ? 2
              : (cubit.selectedIndex != index && index == 3 && type == 'doctor')
                  ? 10
                  : 6),
          Text(
            type == 'patient'
                ? cubit.patientBotNavBarItemsLabel[index]
                : cubit.doctorBotNavBarItemsLabel[index],
            style: AppTextStyles.poppinsGrey(12, FontWeight.w400).copyWith(
                color: cubit.selectedIndex == index
                    ? AppColors.mainColor
                    : AppColors.bottomNavBarItemColor),
          ),
        ],
      ),
    );
  }
}
