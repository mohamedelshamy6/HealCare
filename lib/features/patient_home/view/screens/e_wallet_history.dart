import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';

import '../../../../core/helpers/app_images.dart';

class EWalletHistory extends StatelessWidget {
  const EWalletHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppHeader(
                  canBack: true,
                  title: 'Payment History',
                  horizSpace: MediaQuery.sizeOf(context).width < 400 ? 28 : 42,
                ),
                verticalSpace(20),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      padding: EdgeInsets.all(12.r),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            Assets.iconsPayMoneyIconBlue,
                            width: 20.w,
                            height: 20.h,
                          ),
                          horizontalSpace(12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Rental Income',
                                style: AppTextStyles.poppinsBlack(
                                    14, FontWeight.w500),
                              ),
                              verticalSpace(4),
                              Text(
                                '14 July 2021',
                                style: AppTextStyles.poppinsGrey(
                                    12, FontWeight.w400),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            '5000EGP',
                            style:
                                AppTextStyles.poppinsBlack(14, FontWeight.w400)
                                    .copyWith(color: Color(0xff50c474)),
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemCount: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
