import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../patient_home/data/models/doctors_model.dart';

class PatientBookingCardHeader extends StatelessWidget {
  final int index;
  const PatientBookingCardHeader({
    super.key, required this.index,
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
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(doctors[index].image),
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
                    style: AppTextStyles.poppinsBlack(
                      14,
                      FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: doctors[index].name,
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
                  'Diagnostic Imaging (X-Ray, MRI, CT Scan) + 2 more',
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
