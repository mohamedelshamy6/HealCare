
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/doctor_booking/data/models/all_booking_model.dart';

class DetailsWhiteCard extends StatelessWidget {
  const DetailsWhiteCard({
    super.key,
    required this.allBookingModel,
    required this.selectedIndex,
  });

  final AllBookingModel allBookingModel;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.mainWhite,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundImage:
                    AssetImage(allBookingModel.imageUrl!),
              ),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          allBookingModel.name!, // Use model data
                          style: AppTextStyles.poppinsBlack(
                              16, FontWeight.w500),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: selectedIndex == 0
                                ? AppColors.lightOrange
                                : selectedIndex == 1
                                    ? AppColors.mainColor
                                    : selectedIndex == 2
                                        ? const Color.fromARGB(
                                            255, 142, 223, 145)
                                        : AppColors.lightOrange,
                          ),
                          child: Text(
                            selectedIndex == 0 || selectedIndex == 3
                                ? 'Canceled'
                                : selectedIndex == 2
                                    ? 'Completed'
                                    : 'Attend Session',
                            style: AppTextStyles.setPoppinsTextStyle(
                                color: selectedIndex == 0
                                    ? AppColors.tFFErrorColor
                                    : selectedIndex == 1
                                        ? AppColors.mainWhite
                                        : selectedIndex == 2
                                            ? Colors.green
                                            : AppColors.tFFErrorColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    Text(
                      allBookingModel.jobAddress!,
                      style: AppTextStyles.poppinsGrey(
                          12, FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.detailsDateColor,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.iconsAgeIconBlue,
                      height: 20.h,
                      width: 20.w,
                      color: Colors.blue,
                    ),
                    horizontalSpace(8),
                    Text(
                      allBookingModel.startDate??'Monday, May 12',
                      style: AppTextStyles.poppinsBlack(
                          12, FontWeight.w500),
                    )
                  ],
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      Assets.iconsClockIconDarkblue,
                      height: 20.h,
                      width: 20.w,
                      color: Colors.blue,
                    ),
                    horizontalSpace(8),
                    Text(
                      allBookingModel.endDate??'11:00 - 12:00 Am',
                      style: AppTextStyles.poppinsBlack(
                          12, FontWeight.w500),
                    )
                  ],
                ),
              ],
            ),
          ),
          verticalSpace(12),
          Text(
            'Details',
            style: AppTextStyles.poppinsBlack(14, FontWeight.w500),
          ),
          verticalSpace(4),
          Text(
            'I’m having very bad migraines from past few days. It’s now killing. I’m willing to get some dietary recommendation along with medicines.',
            style: AppTextStyles.poppinsGrey(12, FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
