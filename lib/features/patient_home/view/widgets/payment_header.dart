import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/doctors_model.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class PaymentHeader extends StatelessWidget {
  const PaymentHeader({
    super.key,
    required this.doctorsModel,
  });

  final DoctorsModel doctorsModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(
        16.r,
      ),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            height: 64.h,
            width: 64.w,
            decoration: BoxDecoration(
              color: Colors.pink[200]!.withOpacity(0.35),
              borderRadius: BorderRadius.circular(24.r),
              image: DecorationImage(
                image: AssetImage(doctorsModel.image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          horizontalSpace(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Rating',
                    style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
                  ),
                  horizontalSpace(8),
                  ...List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: Colors.yellow[800],
                      size: 18.r,
                    ),
                  ),
                  horizontalSpace(8),
                  Text(
                    '5',
                    style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
                  ),
                ],
              ),
              Text(
                doctorsModel.name,
                style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
              ),
              Text(
                doctorsModel.job.contains(' - ')
                    ? doctorsModel.job.split('-').first
                    : doctorsModel.job.split('|').first,
                style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
