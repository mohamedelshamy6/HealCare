import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DoctorProfileHeader extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback? onImageTap;

  const DoctorProfileHeader({
    super.key,
    required this.name,
    required this.image,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onImageTap,
          child: Stack(
            alignment: Alignment.bottomRight,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.r),
                ),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.r),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.person, size: 40),
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
