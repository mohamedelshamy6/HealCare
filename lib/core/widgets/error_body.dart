import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/app_images.dart';
import '../theme/app_text_styles.dart';
import 'custom_button.dart';

class ErrorBody extends StatelessWidget {
  final dynamic Function() buttonAction;
  const ErrorBody({super.key, required this.buttonAction});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            // todo Put the error image
            ' Assets.imagesServerError',
            height: 340.h,
          ),
          SizedBox(height: 10.h),
          const Text(
            'عذرا ، حدث خطأ في الاتصال بالسيرفر',
            // style: AppTextStyles.interBlack(16, FontWeight.w700),
          ),
          SizedBox(height: 16.h),
          CustomButton(
            buttonText: 'إعادة التحميل',
            width: 148.w,
            buttonAction: buttonAction,
            buttonStyle: AppTextStyles.interBlack(16, FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
