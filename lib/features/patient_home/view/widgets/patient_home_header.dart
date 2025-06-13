import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';

class PatientHomeHeader extends StatelessWidget {
  final PatientsModel? cachedPatient;

  const PatientHomeHeader({
    super.key,
    this.cachedPatient,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30.r,
          backgroundColor: AppColors.mainColor,
          child: cachedPatient?.image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.network(
                    cachedPatient!.image!,
                    width: 60.w,
                    height: 60.h,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.person,
                        size: 30.r,
                        color: AppColors.mainWhite,
                      );
                    },
                  ),
                )
              : Icon(
                  Icons.person,
                  size: 30.r,
                  color: AppColors.mainWhite,
                ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back,',
                style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
              ),
              Text(
                cachedPatient?.name ?? 'Patient',
                style: AppTextStyles.poppinsBlack(20, FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.eWalletHistory);
              },
              child: SvgPicture.asset(
                Assets.iconsWalletIcon,
                width: 22.w,
                height: 22.h,
              ),
            ),
            horizontalSpace(16),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.patientFavoriteScreen);
              },
              child: Image.asset(
                Assets.iconsFavoriteIconDarkblueOutlined,
                width: 22.w,
                height: 22.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
