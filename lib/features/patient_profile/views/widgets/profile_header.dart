import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/features/auth/view/widgets/upload_photo_widget.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';

import '../../../../core/theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String image;

  const ProfileHeader({
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
              ),
              child: CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.person),
              ),
            ),
            CircleAvatar(
              backgroundColor: AppColors.mainColor,
              radius: 12.r,
              child: Center(
                child: InkWell(
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 12.r,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16.r)),
                      ),
                      builder: (_) => Padding(
                        padding: EdgeInsets.all(16.r),
                        child: UploadPhotoWidget(
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
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
