import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/home_list_view.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 44.h),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            height: 48.h,
                            width: 48.w,
                            child: Image.asset(
                              Assets.imagesPatientsPatientM2,
                            )),
                        horizontalSpace(3),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Back',
                              style: AppTextStyles.poppinsGrey(
                                  14, FontWeight.w400),
                            ),
                            Text(
                              'Andrew Smith',
                              style: AppTextStyles.poppinsBlack(
                                  16, FontWeight.w500),
                            ),
                          ],
                        )
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.notificationsScreen,
                          arguments: 'doctor',
                        );
                      },
                      child:
                          SvgPicture.asset(Assets.iconsNotificationIconBlueDot),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: verticalSpace(24),
              ),
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Positioned(
                      top: 20.h,
                      child: Text(
                        'Start your journey',
                        style: AppTextStyles.poppinsBlack(14, FontWeight.w600),
                      ),
                    ),
                    Image.asset(
                      Assets.imagesDoctorHomeBanner,
                      height: 178.h,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: verticalSpace(25),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Patients Visits',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w600),
                        ),
                        Text(
                          '1 OCT - 30 OCT',
                          style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 32.h,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'This Month',
                                style: AppTextStyles.poppinsMainColor(
                                    10, FontWeight.w500),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: AppColors.mainColor,
                                size: 20.r,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: verticalSpace(24),
              ),
              SliverToBoxAdapter(
                child: Image.asset(
                  Assets.imagesDataChart,
                  height: 166.h,
                  fit: BoxFit.contain,
                ),
              ),
              SliverToBoxAdapter(
                child: verticalSpace(40),
              ),
              SliverToBoxAdapter(
                child: Text(
                  'Recently Appointment',
                  style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
                ),
              ),
              SliverToBoxAdapter(
                child: verticalSpace(16),
              ),
              HomeListView(),
            ],
          )),
    );
  }
}
