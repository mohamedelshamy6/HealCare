import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/routing/routes.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.insideChat);
      },
      child: Container(padding: EdgeInsets.all(16),color: Colors.transparent,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(Assets.imagesDoctorsDoctorM2), 
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Adam Costa',
                        style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
                      ),
                      Text(
                        '5:02 PM',
                        style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                      ),
                    ],
                  ),
                  verticalSpace(5.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 230.w,
                        child: Text(
                          'Of course, we just added that to your order. Thanks for letting us know!',
                          style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
