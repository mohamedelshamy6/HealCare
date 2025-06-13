import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';

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
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: CachedNetworkImage(
                imageUrl: doctorsModel.image ?? '',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 32.r,
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => CircleAvatar(
                  radius: 35.r,
                  backgroundColor: Colors.grey[200],
                ),
                errorWidget: (context, url, error) => CircleAvatar(
                  radius: 35.r,
                  backgroundColor: Colors.grey[200],
                  child:
                      Icon(Icons.person, size: 35.r, color: Colors.grey[500]),
                ),
              )),
          horizontalSpace(16),
          Expanded(
            child: Column(
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
                  doctorsModel.name.toString(),
                  style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
                ),
                Text(
                  doctorsModel.education?.contains(' - ') ?? false
                      ? doctorsModel.education?.split('-').first.trim() ?? ''
                      : doctorsModel.education?.split('|').first.trim() ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
