import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_text_form_field.dart';
import 'package:heal_care/features/chat/views/widgets/chat_bubble.dart';
import 'package:heal_care/features/chat/views/widgets/chat_header.dart';
import 'package:heal_care/features/chat/data/models/message.dart';

import '../../../doctor_home/data/models/patient_model.dart';
import '../../../patient_home/data/models/doctors_model.dart';
import '../widgets/chat_bubble_for_friend.dart';

class InsideChatScreen extends StatefulWidget {
  const InsideChatScreen({
    super.key,
    required this.chatIndex,
    required this.model,
  });
  final int chatIndex;
  final Object model;
  @override
  State<InsideChatScreen> createState() => _InsideChatScreenState();
}

class _InsideChatScreenState extends State<InsideChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<Message> messages = [];
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String image = (widget.model is DoctorsModel
        ? ((widget.model) as DoctorsModel).image
        : ((widget.model) as PatientModel).image);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChatHeader(
                  model: widget.model is DoctorsModel
                      ? (widget.model) as DoctorsModel
                      : (widget.model) as PatientModel),
              verticalSpace(11),
              Expanded(
                child: widget.chatIndex == 0
                    ? ListView.builder(
                        controller: _scrollController,
                        itemCount: messages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalSpace(20.25),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Yesterday',
                                    style: AppTextStyles.poppinsGrey(
                                        10, FontWeight.w400),
                                  ),
                                ),
                                verticalSpace(13),
                              ],
                            );
                          }
                          return ChatBubble(
                            image: image,
                            message: messages[index - 1].text,
                            date:
                                '${messages[index - 1].timestamp.hour}:${messages[index - 1].timestamp.minute}',
                          );
                        },
                      )
                    : ListView(
                        controller: _scrollController,
                        children: [
                          verticalSpace(20.25),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Yesterday',
                              style: AppTextStyles.poppinsGrey(
                                  10, FontWeight.w400),
                            ),
                          ),
                          verticalSpace(13),
                          ChatBubbleForFriend(
                            type: widget.model is DoctorsModel
                                ? 'patient'
                                : 'doctor',
                            message: 'hi',
                            date: '18:57',
                          ),
                          ChatBubble(
                            image: image,
                            message: 'hi',
                            date: '18:57',
                          ),
                          ChatBubbleForFriend(
                            type: widget.model is DoctorsModel
                                ? 'patient'
                                : 'doctor',
                            message:
                                'Hi doctor, I am cardio patient. I need your help imidiately.',
                            date: '18:57',
                          ),
                          ChatBubble(
                            image: image,
                            message:
                                'Hi, don’t worry! I am here. Let me know your situation now.',
                            date: '18:58',
                          ),
                          ChatBubbleForFriend(
                            type: widget.model is DoctorsModel
                                ? 'patient'
                                : 'doctor',
                            message:
                                'Hi doctor, I am cardio patient. I need your help imidiately.',
                            date: '18:59',
                          ),
                          ChatBubble(
                            image: image,
                            message:
                                'Hi, don’t worry! I am here. Let me know your situation now.',
                            date: '19:00',
                          ),
                          ChatBubbleForFriend(
                            type: widget.model is DoctorsModel
                                ? 'patient'
                                : 'doctor',
                            message:
                                'Hi doctor, I am cardio patient. I need your help imidiately.',
                            date: '19:00',
                          ),
                          ChatBubble(
                            image: image,
                            message:
                                'Hi, don’t worry! I am here. Let me know your situation now.',
                            date: '19:00',
                          ),
                          ChatBubbleForFriend(
                            message:
                                'Hi doctor, I am cardio patient. I need your help imidiately.',
                            type: widget.model is DoctorsModel
                                ? 'patient'
                                : 'doctor',
                            date: '19:01',
                          ),
                          ChatBubble(
                            image: image,
                            message:
                                'Hi, don’t worry! I am here. Let me know your situation now.',
                            date: '19:01',
                          ),
                        ],
                      ),
              ),
              verticalSpace(16),
              Row(
                children: [
                  Expanded(
                    child: CustomTFF(
                      maxLines: null,
                      maxInputLength: 1024,
                      verticalPadding: 15.h,
                      horizontalPadding: 23.w,
                      controller: messageController,
                      focusNode: _focusNode,
                      hintText: 'Type a message',
                      hintTextStyle:
                          AppTextStyles.poppinsWhite(16, FontWeight.w400),
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
                  IconButton(
                      onPressed: () {
                        if (messageController.text.isNotEmpty) {
                          setState(() {
                            messages.add(Message(
                              text: messageController.text,
                              timestamp: DateTime.now(),
                            ));
                            messageController.clear();
                          });
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        size: 26.r,
                        color: AppColors.mainColor,
                      ))
                ],
              ),
              verticalSpace(8)
            ],
          ),
        ),
      ),
    );
  }
}
