import 'package:flutter/material.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';


class WalletItem extends StatelessWidget {
  const WalletItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
         Container(
           height: 48,
           width: 48,
           decoration: BoxDecoration(
               color: AppColors.lighterBlue,
               borderRadius: BorderRadius.circular(10)),
           child: Center(
             child: Icon(
               Icons.north_east,
               color: AppColors.mainColor,
             ),
           ),
         ),
         horizontalSpace(16),
         Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
            Text(
           'Adam Costa',
           style: AppTextStyles.poppinsBlack(16, FontWeight.w600),
         ),
         verticalSpace(2),
          Text(
           'Standard Chartered Bank',
           style: AppTextStyles.poppinsGrey(12, FontWeight.w600),
         ),
         ],),
        ],),
         Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
       Text(
       '5:02 PM',
       style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
     ),
     verticalSpace(8),
     Text(
       '200 EGP',
       style: AppTextStyles.poppinsMainColor(16, FontWeight.w600),
     ),
     
     ],),
      
      ],
    );
  }
}
