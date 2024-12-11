import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

import '../widgets/wallet_item.dart';

class DoctorWallet extends StatelessWidget {
  const DoctorWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            height: 206.h,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24)),
            ),
          ),
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
                    child: Icon(
                      Icons.filter_list,
                      color: AppColors.mainWhite,
                    ),
                  ),
                ),
              ],
            ),
          ),
           Expanded(
                  child: ListView.builder(
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
      ),
    );
  }
}
