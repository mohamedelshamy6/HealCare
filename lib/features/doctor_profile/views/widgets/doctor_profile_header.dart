import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';

class DoctorProfileHeader extends StatelessWidget {
  final String name;
  final String image;

  const DoctorProfileHeader({
    super.key,
    required this.name,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32.r),
                image: DecorationImage(
                  image: image.isNotEmpty
                      ? NetworkImage(image) as ImageProvider
                      : const AssetImage(Assets.imagesDoctorsDoctorM2),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColors.mainColor,
              radius: 12.r,
              child: Center(
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 12.r,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(16),
        Text(
          name,
          style: AppTextStyles.poppinsBlack(16, FontWeight.w800),
        ),
      ],
    );
  }
}
