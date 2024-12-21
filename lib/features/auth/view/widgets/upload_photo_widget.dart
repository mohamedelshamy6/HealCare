import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class UploadPhotoWidget extends StatelessWidget {
  const UploadPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: AppColors.dropDownColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 24.r,
                  color: Color(0xff676767),
                ),
              ),
              Container(
                width: 25.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Icon(
                  Icons.add,
                  size: 12.r,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          horizontalSpace(8),
          Text(
            'Upload Photo',
            style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
