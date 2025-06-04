import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:intl/intl.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/helpers/app_images.dart';

class BookingItem extends StatelessWidget {
  final PatientsModel patientsModel;
  final DoctorBookingModel bookingModel;
  const BookingItem({
    super.key,
    required this.selectedIndex,
    required this.patientsModel,
    required this.bookingModel,
  });

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final rawDate = bookingModel.appointmentDate ?? '';
    final parsedDate = DateTime.tryParse(rawDate);

    final rawTime = bookingModel.appointmentTime ?? '';
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
                  child: CachedNetworkImage(
                    imageUrl: "${patientsModel.image}",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.person,
                        size: 30.r, color: AppColors.mainGrey),
                  )),
              horizontalSpace(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      patientsModel.name!,
                      style: AppTextStyles.poppinsBlack(18, FontWeight.w600),
                    ),
                    Text(
                      patientsModel.medicalHistory ?? '',
                      style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                    ),
                    Text(
                      patientsModel.address ?? '',
                      style: AppTextStyles.poppinsGrey(14, FontWeight.w500),
                    ),
                    MediaQuery.of(context).size.width > 400
                        ? Row(
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
                                    formattedDate,
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
                                    formattedTime,
                                    style: AppTextStyles.poppinsBlack(
                                        10, FontWeight.w400),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.iconsCalenderIconDarkblue,
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  horizontalSpace(4),
                                  Text(
                                    bookingModel.appointmentDate ?? '',
                                    style: AppTextStyles.poppinsBlack(
                                        10, FontWeight.w400),
                                  ),
                                ],
                              ),
                              verticalSpace(4),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.iconsClockIconDarkblue,
                                    height: 20.h,
                                    width: 20.w,
                                  ),
                                  horizontalSpace(4),
                                  Text(
                                    patientsModel.medicalHistory ?? '',
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
                            decoration:
                                BoxDecoration(color: AppColors.lightGreen),
                            child: Text(
                              'Completed',
                              style: AppTextStyles.setPoppinsTextStyle(
                                  color: AppColors.darkGreen,
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
