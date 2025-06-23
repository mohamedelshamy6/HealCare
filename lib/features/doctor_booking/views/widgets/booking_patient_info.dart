import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';

class BookingPatientInfo extends StatelessWidget {
  final PatientsModel patientsModel;

  const BookingPatientInfo({
    super.key,
    required this.patientsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50.w,
          height: 40.h,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: AppColors.mainGrey,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: CachedNetworkImage(
              imageUrl: patientsModel.image ?? '',
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.person),
            ),
          ),
        ),
        horizontalSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Patient  ${patientsModel.name}',
                style: AppTextStyles.poppinsBlack(14, FontWeight.w500),
              ),
              verticalSpace(4),
              Text(
                'Disease: ${patientsModel.disease}',
                style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
              ),
              verticalSpace(4),
              Text(
                'Medical History: ${patientsModel.medicalHistory}',
                style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
