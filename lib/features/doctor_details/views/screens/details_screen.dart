import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';

import '../widgets/details_white_card.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.doctorBookingModel,
    required this.selectedIndex,
  });

  final DoctorBookingModel? doctorBookingModel;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: CustomAppHeader(
                  title: 'Details',
                  canBack: true,
                  horizSpace: 86.25,
                ),
              ),
              verticalSpace(15.18),
              DetailsWhiteCard(
                  doctorBookingModel: doctorBookingModel!,
                  selectedIndex: selectedIndex),
              verticalSpace(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Medical Information',
                      style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
                    ),
                    verticalSpace(8),
                    Text(
                      doctorBookingModel!.patient!.medicalHistory ?? 'There is No Midical History',
                      style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                    ),
                    verticalSpace(24),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      decoration: BoxDecoration(
                        color: AppColors.detailsFilesCardColor,
                      ),
                      child: Center(
                        child: Text(
                          'Files',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w400),
                        ),
                      ),
                    ),
                    verticalSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            height: 143.h,
                            width: 157.w,
                            child: Image.asset(Assets.imagesFileOne)),
                        SizedBox(
                            height: 143.h,
                            width: 157.w,
                            child: Image.asset(Assets.imagesFileTwo)),
                      ],
                    )
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
