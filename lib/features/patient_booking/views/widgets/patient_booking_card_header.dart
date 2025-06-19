import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class PatientBookingCardHeader extends StatelessWidget {
  final DoctorsModel? doctor;
  const PatientBookingCardHeader({
    super.key,
    this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffF9f9f9),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.findDoctorsCardBorderColor),
      ),
      padding: EdgeInsets.all(8.r),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: CachedNetworkImage(
              imageUrl: doctor?.image.toString() ?? '',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          horizontalSpace(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Appointment with ',
                    style: AppTextStyles.poppinsBlack(
                      14,
                      FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: doctor?.name ?? 'Unknown',
                        style: AppTextStyles.poppinsMainColor(
                          14,
                          FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.start,
                ),
                verticalSpace(2),
                Text(
                  '${doctor!.specialization} ',
                  style: AppTextStyles.poppinsGrey(
                    12,
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          horizontalSpace(8),
          SvgPicture.asset(Assets.iconsLocationIconDarkblue),
        ],
      ),
    );
  }
}
