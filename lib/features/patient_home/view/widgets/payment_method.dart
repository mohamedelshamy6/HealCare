import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/widgets/custom_radio.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({
    super.key,
  });

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int? groupValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select Payment Method',
            style: AppTextStyles.poppinsBlack(14, FontWeight.w700),
          ),
          verticalSpace(16),
          Row(
            children: [
              Image.asset(
                Assets.imagesVisa,
                height: 20.h,
              ),
              horizontalSpace(4),
              Image.asset(
                Assets.imagesMasterCard,
                height: 20.h,
              ),
              horizontalSpace(12),
              Text(
                'Credit Card',
                style: AppTextStyles.poppinsBlack(15, FontWeight.w400),
              ),
              Spacer(),
              CustomRadio(
                value: 0,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() {
                    groupValue = value;
                  });
                },
              ),
            ],
          ),
          verticalSpace(8),
          Row(
            children: [
              SvgPicture.asset(
                Assets.iconsEWalletBlue,
                height: 20.h,
              ),
              horizontalSpace(48),
              Text(
                'E-Wallet',
                style: AppTextStyles.poppinsBlack(15, FontWeight.w400),
              ),
              Spacer(),
              CustomRadio(
                value: 1,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() {
                    groupValue = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
