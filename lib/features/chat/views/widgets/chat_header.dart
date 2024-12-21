import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
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
                ? horizontalSpace(23.25)
                : horizontalSpace(12),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundImage:
                            AssetImage(Assets.imagesDoctorsDoctorM),
                      ),
                      horizontalSpace(13.25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. Kawsar',
                            style:
                                AppTextStyles.poppinsBlack(18, FontWeight.w400),
                          ),
                          Text(
                            'Online',
                            style: AppTextStyles.poppinsMainColor(
                                15, FontWeight.w400),
                          ),
                        ],
                      ),
                    ],
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
