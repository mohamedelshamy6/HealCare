import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';

class PatientHomeHeader extends StatefulWidget {
  const PatientHomeHeader({super.key});

  @override
  State<PatientHomeHeader> createState() => _PatientHomeHeaderState();
}

class _PatientHomeHeaderState extends State<PatientHomeHeader> {
  late final Future<PatientsModel?> _patientFuture;

  @override
  void initState() {
    super.initState();
    _patientFuture = UserCacheHelper.getCachedPatientData();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder<PatientsModel?>(
          future: _patientFuture,
          builder: (context, snapshot) {
            final imageUrl = snapshot.data?.image ?? '';
            return CircleAvatar(
              radius: 30.r,
              backgroundColor: AppColors.mainColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                    radius: 30.r,
                    backgroundImage: imageProvider,
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) =>
                      Icon(Icons.person, size: 60.r),
                ),
              ),
            );
          },
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: FutureBuilder<PatientsModel?>(
            future: _patientFuture,
            builder: (context, snapshot) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back,',
                    style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                  ),
                  Text(
                    snapshot.data?.name ?? 'Patient',
                    style: AppTextStyles.poppinsBlack(20, FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
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
