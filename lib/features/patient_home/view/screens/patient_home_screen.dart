import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../widgets/home_header.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/find_doctor_container.dart';
import '../widgets/home_banner.dart';
import '../widgets/home_categories.dart';
import '../widgets/title_with_see_all.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: HomeHeader(),
              ),
              verticalSpace(32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Upcoming Appointments',
                  style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
                ),
              ),
              PatientHomeBanner(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleWithSeeAll(title: 'Categories'),
                    verticalSpace(8),
                    HomeCategories(),
                    verticalSpace(24.h),
                    TitleWithSeeAll(
                      title: 'Find Doctors',
                      onPressed: () => Navigator.of(context)
                          .pushNamed(Routes.allDoctorsScreen),
                    ),
                    verticalSpace(8),
                    FindDoctorsContainer(),
                    verticalSpace(16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
