import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/features/patient_home/data/models/doctors_model.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';

class ChatBotScreen extends StatelessWidget {
  final int chatIndex;
  final DoctorsModel model;
  const ChatBotScreen(
      {super.key, required this.chatIndex, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            Expanded(
              child: CustomTFF(
                maxLines: null,
                maxInputLength: 1024,
                verticalPadding: 15.h,
                horizontalPadding: 23.w,
                hintText: 'Type a message',
                hintTextStyle: AppTextStyles.poppinsWhite(16, FontWeight.w400),
                kbType: TextInputType.multiline,
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
            ),
            horizontalSpace(6),
            CircleAvatar(
              radius: 24.r,
              backgroundColor: AppColors.mainColor,
              child: Center(
                child: SvgPicture.asset(Assets.iconsChatBotSend,
                    width: 24.w, height: 24.h),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
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
                  horizontalSpace(24),
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: AssetImage(Assets.imagesChatBot),
                  ),
                  horizontalSpace(12),
                  Text(
                    'ARIA',
                    style: AppTextStyles.poppinsBlack(16, FontWeight.w600),
                  ),
                ],
              ),
              verticalSpace(32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width < 400
                                ? 222.w
                                : 270.w,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.mainWhite),
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Text(
                              'Hi there,\nBefore chatting with the doctor\nCan you tell me what’s your problem?',
                              style: AppTextStyles.poppinsBlack(
                                  14, FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width < 400
                                ? 222.w
                                : 270.w,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.mainColor),
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Text(
                              'Help me customize a one-week fitness and diet weight loss plan.',
                              style: AppTextStyles.poppinsWhite(
                                  14, FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.sizeOf(context).width < 400
                                ? 222.w
                                : 270.w,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: AppColors.mainWhite),
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Column(
                              children: [
                                Text(
                                  'Some of the popular tourist destinations in the United States are as follow\nNew York City is a must-visit, with its renowned Times Square, the Statue of Liberty standing tall in the harbor, and the vast and beautiful Central Park.\nLos Angeles attracts countless tourists with the allure of Hollywood, where you can catch a glimpse of the glitz and glamour of the film industry, as well as the exciting Universal Studios.\nSan Francisco is known for the magnificent Golden Gate Bridge that spans the bay, the notorious Alcatraz Island, and its unique and charming neighborhoods.',
                                  style: AppTextStyles.poppinsBlack(
                                      14, FontWeight.w400),
                                ),
                                Divider(),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4.r),
                                      decoration: BoxDecoration(
                                        color: AppColors.mainGrey
                                            .withOpacity(0.35),
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: SvgPicture.asset(
                                        Assets.iconsCopy,
                                        width: 14.w,
                                        height: 14.w,
                                      ),
                                    ),
                                    horizontalSpace(8),
                                    Container(
                                      padding: EdgeInsets.all(4.r),
                                      decoration: BoxDecoration(
                                        color: AppColors.mainGrey
                                            .withOpacity(0.35),
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: SvgPicture.asset(
                                        Assets.iconsLike,
                                        width: 14.w,
                                        height: 14.w,
                                      ),
                                    ),
                                    horizontalSpace(8),
                                    Container(
                                      padding: EdgeInsets.all(4.r),
                                      decoration: BoxDecoration(
                                        color: AppColors.mainGrey
                                            .withOpacity(0.35),
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: SvgPicture.asset(
                                        Assets.iconsSound,
                                        width: 14.w,
                                        height: 14.w,
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: EdgeInsets.all(4.r),
                                      decoration: BoxDecoration(
                                        color: AppColors.mainGrey
                                            .withOpacity(0.35),
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: SvgPicture.asset(
                                        Assets.iconsAgain,
                                        width: 14.w,
                                        height: 14.w,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.mainWhite),
                          child: Padding(
                            padding: EdgeInsets.all(8.r),
                            child: Text(
                              'Tell me more.',
                              style: AppTextStyles.poppinsBlack(
                                  14, FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(16),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.insideChat, arguments: [
                            chatIndex,
                            'patient',
                            model,
                          ]);
                        },
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColors.mainWhite),
                            child: Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Text(
                                'Go to the chat with the doctor.',
                                style: AppTextStyles.poppinsBlack(
                                    14, FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
