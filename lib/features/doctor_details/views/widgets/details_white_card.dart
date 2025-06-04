import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DetailsWhiteCard extends StatelessWidget {
  const DetailsWhiteCard({
    super.key,
    required this.doctorBookingModel,
    required this.selectedIndex,
  });

  final DoctorBookingModel doctorBookingModel;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final rawDate = doctorBookingModel.appointmentDate ?? '';
    final parsedDate = DateTime.tryParse(rawDate);

    final rawTime = doctorBookingModel.appointmentTime ?? '';
    DateTime? parsedDateTime;
    if (parsedDate != null && rawTime.isNotEmpty) {
      parsedDateTime = DateTime.tryParse('$rawDate $rawTime');
    }

    final formattedDate = parsedDate != null
        ? DateFormat('d MMMM yyyy', 'en_US').format(parsedDate)
        : '';

    final formattedTime = parsedDateTime != null
        ? DateFormat.jm('en_US').format(parsedDateTime)
        : '';
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
                  child: CachedNetworkImage(
                    imageUrl: "${doctorBookingModel.patient!.image}",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.person,
                        size: 35.r, color: AppColors.mainGrey),
                  )),
              horizontalSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          doctorBookingModel.patient!.name!,
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w500),
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
                                        ? AppColors.lightGreen
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
                                            ? AppColors.darkGreen
                                            : AppColors.tFFErrorColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    Text(
                      doctorBookingModel.patient!.address!,
                      style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
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
                      formattedDate,
                      style: AppTextStyles.poppinsBlack(12, FontWeight.w500),
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
                      formattedTime,
                      style: AppTextStyles.poppinsBlack(12, FontWeight.w500),
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
            doctorBookingModel.patient!.medicalHistory ?? '',
            style: AppTextStyles.poppinsGrey(12, FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
