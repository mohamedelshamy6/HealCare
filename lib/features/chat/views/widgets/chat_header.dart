import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/doctor_home/data/models/patient_model.dart';

import '../../../patient_home/data/models/doctors_model.dart';

class ChatHeader extends StatelessWidget {
  final Object model;
  const ChatHeader({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 24.r,
                child: Icon(
                  Icons.arrow_back,
                  size: 24.r,
                  color: AppColors.mainBlack,
                ),
              ),
            ),
            MediaQuery.sizeOf(context).width > 400
                ? horizontalSpace(12)
                : horizontalSpace(6),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundImage: AssetImage(model is DoctorsModel
                              ? (model as DoctorsModel).image
                              : (model as PatientModel).image),
                        ),
                        horizontalSpace(13.25),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                model is DoctorsModel
                                    ? (model as DoctorsModel).name
                                    : (model as PatientModel).name,
                                style: AppTextStyles.poppinsBlack(
                                    18, FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                'Online',
                                style: AppTextStyles.poppinsMainColor(
                                    15, FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(Assets.iconsCallIconBlue),
                      horizontalSpace(17.24),
                      SvgPicture.asset(Assets.iconsVideoIconBlue),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        verticalSpace(11),
      ],
    );
  }
}
