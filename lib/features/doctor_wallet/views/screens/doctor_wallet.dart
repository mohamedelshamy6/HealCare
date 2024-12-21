import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../widgets/wallet_item.dart';

class DoctorWallet extends StatelessWidget {
  const DoctorWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       Image.asset(Assets.walletFrame),
        verticalSpace(18),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recently Transactions',
                style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
              ),
              Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child:SvgPicture.asset(Assets.iconsFilterIconWhite)
                ),
              ),
            ],
          ),
        ),
        verticalSpace(8),
         Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: BouncingScrollPhysics(),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h,horizontal: 24.w),
                        child: WalletItem(),
                      );
                    }),
              )
      ],
    );
  }
}
