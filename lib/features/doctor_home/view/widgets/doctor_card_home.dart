import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../core/helpers/app_images.dart';

class DoctorCardHome extends StatelessWidget {
  final DoctorBookingModel appointment;

  const DoctorCardHome({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.mainGrey.withOpacity(.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                child: CachedNetworkImage(
                  imageUrl: appointment.patient?.image ?? '',
                  fit: BoxFit.fill,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.person, size: 35.r, color: AppColors.mainGrey),
                ),
              ),
              horizontalSpace(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${appointment.patient?.name ?? 'Unknown'} ',
                    style: AppTextStyles.poppinsBlack(14, FontWeight.w600),
                  ),
                  verticalSpace(4),
                  Text(
                    appointment.status ?? '',
                    style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
          verticalSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    appointment.appointmentDate ?? '',
                    style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
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
                    appointment.appointmentTime ?? '',
                    style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
