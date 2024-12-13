import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_text_form_field.dart';

import '../widgets/doctors_container.dart';

class AllDoctorsScreen extends StatelessWidget {
  const AllDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppHeader(
                canBack: true,
                title: 'Doctors',
                horizSpace: 80,
              ),
              verticalSpace(48),
              CustomTFF(
                hintText: 'Search',
                kbType: TextInputType.text,
                hintTextStyle: AppTextStyles.poppinsGrey(15, FontWeight.w400),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(13.r),
                  child: SvgPicture.asset(
                    Assets.iconsSearchIconGrey,
                  ),
                ),
                enableFocusedBorder: false,
                suffixIcon: InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(5.r),
                    width: 38.w,
                    height: 38.h,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(Assets.iconsFilterIconWhite),
                    ),
                  ),
                ),
              ),
              verticalSpace(12),
              Text(
                'Specialist',
                style: AppTextStyles.poppinsBlack(16, FontWeight.w400),
              ),
              verticalSpace(8),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => verticalSpace(12),
                  itemCount: 8,
                  itemBuilder: (context, index) =>
                      DoctorsContainer(index: index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
