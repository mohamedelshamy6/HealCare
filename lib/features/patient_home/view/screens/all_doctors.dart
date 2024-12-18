import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

import '../widgets/doctors_container.dart';
import '../widgets/filter_doctor_search_sheet.dart';

class AllDoctorsScreen extends StatelessWidget {
  const AllDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppHeader(
                canBack: true,
                title: 'Doctors',
                horizSpace: MediaQuery.sizeOf(context).width < 400 ? 56 : 80,
              ),
              verticalSpace(32),
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
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => const FilterDoctorSearchSheet(),
                    );
                  },
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
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
