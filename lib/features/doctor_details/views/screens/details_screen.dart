import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/doctor_booking/data/models/all_booking_model.dart';

import '../widgets/details_white_card.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.allBookingModel,
    required this.selectedIndex,
  });

  final AllBookingModel allBookingModel; // Add model parameter
  final int selectedIndex; // Add index parameter

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
              DetailsWhiteCard(allBookingModel: allBookingModel, selectedIndex: selectedIndex),
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
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eleifend pretium libero sit amet mollis. Duis ornare tempor molestie. Donec at elementum ligula.',
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
                            child: Image.asset(
                                'assets/images/doctors/details_file1.png')),
                        SizedBox(
                            height: 143.h,
                            width: 157.w,
                            child: Image.asset(
                                'assets/images/doctors/details_file2.png')),
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
