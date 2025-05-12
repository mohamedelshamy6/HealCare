import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';

class PatientBookingCardHeader extends StatelessWidget {
  final DoctorsModel? doctor;

  const PatientBookingCardHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF9f9f9),
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
              image: DecorationImage(
                fit: BoxFit.fill,
                image: doctor != null
                    ? NetworkImage(doctor!.image ?? '')
                    : AssetImage('assets/images/placeholder.png')
                        as ImageProvider,
              ),
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
                    style: AppTextStyles.poppinsBlack(14, FontWeight.w400),
                    children: [
                      TextSpan(
                        text: doctor?.name ?? 'Unknown',
                        style:
                            AppTextStyles.poppinsMainColor(14, FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                verticalSpace(2),
                Row(
                  children: [
                    Text(
                      doctor?.specialization ?? 'No Specialization',
                      style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                    ),
                    horizontalSpace(8),
                    Text(
                      doctor?.address ?? 'No Address',
                      style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                    ),
                  ],
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
