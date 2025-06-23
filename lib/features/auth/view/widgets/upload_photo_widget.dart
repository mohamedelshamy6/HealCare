import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';

class UploadPhotoWidget extends StatelessWidget {
  final void Function()? onTap;
  final File? imagePath;
  final String? imageUrl; 

  const UploadPhotoWidget({
    super.key,
    this.onTap,
    this.imagePath,
    this.imageUrl, 
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;

    if (imagePath != null) {
      backgroundImage = FileImage(imagePath!);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      backgroundImage = NetworkImage(imageUrl!);
    }

    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
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
                  image: backgroundImage != null
                      ? DecorationImage(
                          image: backgroundImage,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: backgroundImage != null
                    ? null
                    : Icon(
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
        ],
      ),
    );
  }
}
