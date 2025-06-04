import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/utils/payment_method_type.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/widgets/custom_radio.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class PaymentMethod extends StatefulWidget {
  final PaymentMethodType? selectedMethod;
  final ValueChanged<PaymentMethodType> onChanged;

  const PaymentMethod({
    super.key,
    required this.selectedMethod,
    required this.onChanged,
  });

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
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
          _buildOption(
            leading: Row(
              children: [
                Image.asset(Assets.imagesVisa, height: 20.h),
                horizontalSpace(4),
                Image.asset(Assets.imagesMasterCard, height: 20.h),
              ],
            ),
            title: 'Credit Card',
            value: PaymentMethodType.creditCard,
          ),
          verticalSpace(8),
          verticalSpace(8),
          _buildOption(
            leading: Image.asset(Assets.iconsInstapay, height: 32.h),
            title: 'InstaPay',
            value: PaymentMethodType.instaPay,
          ),
        ],
      ),
    );
  }

  Widget _buildOption({
    required Widget leading,
    required String title,
    required PaymentMethodType value,
  }) {
    return Row(
      children: [
        leading,
        horizontalSpace(12),
        Text(
          title,
          style: AppTextStyles.poppinsBlack(15, FontWeight.w400),
        ),
        Spacer(),
        CustomRadio<PaymentMethodType>(
          value: value,
          groupValue: widget.selectedMethod,
          onChanged: widget.onChanged,
        ),
      ],
    );
  }
}
