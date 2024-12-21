import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_text_form_field.dart';
import 'package:heal_care/features/chat/views/widgets/chat_bubble.dart';
import 'package:heal_care/features/chat/views/widgets/chat_bubble_for_friend.dart';
import 'package:heal_care/features/chat/views/widgets/chat_header.dart';

class InsideChatScreen extends StatelessWidget {
  const InsideChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ChatHeader(),
            verticalSpace(11),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(20.25),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Yesterday',
                        style: AppTextStyles.poppinsGrey(10, FontWeight.w400),
                      ),
                    ),
                    verticalSpace(13),
                    ChatBubble(
                      message:
                          'Hi Kawsar, I am cardio patient. I need your help immediately.',
                    ),
                    ChatBubbleForFriend(
                      message:
                          'Hi Kawsar, I am cardio patient. I need your help immediately.',
                    ),
                    ChatBubbleForFriend(
                      message: 'Hello there',
                    ),
                    ChatBubble(
                      message: 'hhh',
                    ),
                    ChatBubble(
                      message: 'knknlnj',
                    ),
                    ChatBubbleForFriend(
                      message: 'ggg',
                    ),
                    ChatBubbleForFriend(
                      message: 'ggg',
                    ),
                    ChatBubble(
                      message: 'ggg',
                    ),
                  ],
                ),
              ),
            ),
            CustomTFF(
              verticalPadding: 8.h,
              horizontalPadding: 23.w,
              hintText: 'Type a message',
              hintTextStyle: AppTextStyles.poppinsWhite(14, FontWeight.w400),
              kbType: TextInputType.text,
              color: AppColors.mainColor,
              borderRadius: 20.r,
              cursorColor: AppColors.mainColor,
              enableFocusedBorder: false,
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 23.11.w),
                child: SizedBox(
                  width: 80.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SvgPicture.asset(Assets.iconsSendFilesIconWhite),
                      horizontalSpace(20),
                      SvgPicture.asset(Assets.iconsMicrophoneIconWhite),
                    ],
                  ),
                ),
              ),
            ),
            verticalSpace(8)
          ],
        ),
      ),
    ));
  }
}
