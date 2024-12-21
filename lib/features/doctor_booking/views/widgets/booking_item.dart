import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../data/models/all_booking_model.dart';
import '../../../../core/helpers/app_images.dart';

class BookingItem extends StatelessWidget {
  const BookingItem({
    super.key,
    required this.selectedIndex,
    required this.allBookingModel,
  });

  final int selectedIndex;
  final AllBookingModel allBookingModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 18.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.mainWhite,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 35.r,
                  backgroundImage: AssetImage(allBookingModel.imageUrl ??
                      Assets.imagesPatientsPatientM)),
              horizontalSpace(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      allBookingModel.name!,
                      style: AppTextStyles.poppinsBlack(18, FontWeight.w600),
                    ),
                    Text(
                      allBookingModel.specialty!,
                      style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                    ),
                    Text(
                      allBookingModel.jobAddress!,
                      style: AppTextStyles.poppinsGrey(14, FontWeight.w500),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.iconsCalenderIconDarkblue,
                              height: 20.h,
                              width: 20.w,
                            ),
                            horizontalSpace(2),
                            Text(
                              allBookingModel.startDate!,
                              style: AppTextStyles.poppinsBlack(
                                  10, FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.iconsClockIconDarkblue,
                              height: 20.h,
                              width: 20.w,
                            ),
                            horizontalSpace(2),
                            Text(
                              allBookingModel.endDate!,
                              style: AppTextStyles.poppinsBlack(
                                  10, FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(14),
          selectedIndex == 0
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 17.w),
                  child: CustomButton(
                      color: AppColors.lightOrange,
                      buttonText: 'Canceled',
                      buttonAction: () {},
                      textStyle: AppTextStyles.setPoppinsTextStyle(
                          color: AppColors.tFFErrorColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                )
              : selectedIndex == 1
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 17.w),
                      child: CustomButton(
                          buttonText: 'Attend Session',
                          buttonAction: () {},
                          textStyle:
                              AppTextStyles.poppinsWhite(14, FontWeight.w500)),
                    )
                  : selectedIndex == 2
                      ? Padding(
                          padding: EdgeInsets.only(right: 60.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                                color:
                                    const Color.fromARGB(255, 142, 223, 145)),
                            child: Text(
                              'Completed',
                              style: AppTextStyles.setPoppinsTextStyle(
                                  color: Colors.green,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          ))
                      : Padding(
                          padding: EdgeInsets.only(right: 60.w),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: AppColors.lightOrange,
                            ),
                            child: Text(
                              'Canceled',
                              style: AppTextStyles.setPoppinsTextStyle(
                                  color: AppColors.tFFErrorColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          )),
        ],
      ),
    );
  }
}
