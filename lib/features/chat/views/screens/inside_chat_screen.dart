import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/features/patient_home/data/models/doctors_models.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_header.dart';
import '../../data/models/message.dart';
import '../../data/models/get_conversations_model.dart';
import '../../../doctor_home/data/models/patient_model.dart';
import '../widgets/chat_bubble_for_friend.dart';

class InsideChatScreen extends StatefulWidget {
  const InsideChatScreen({
    super.key,
    required this.chatIndex,
    required this.model,
  });
  final String chatIndex;
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

    // Initialize messages from conversation if available
    if (widget.model is GetConversationsModel) {
      final conversation = widget.model as GetConversationsModel;
      if (conversation.lastMessageContent != null) {
        messages.add(Message(
          text: conversation.lastMessageContent!,
          timestamp: DateTime.parse(conversation.lastMessageSentAt ??
              DateTime.now().toIso8601String()),
        ));
      }
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String image = '';
    if (widget.model is GetConversationsModel) {
      image = (widget.model as GetConversationsModel).counterpartImage ?? '';
    } else if (widget.model is DoctorssModel) {
      image = (widget.model as DoctorssModel).image;
    } else if (widget.model is PatientModel) {
      image = (widget.model as PatientModel).image;
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ChatHeader(
                model: widget.model,
              ),
              verticalSpace(11),
              Expanded(
                child: ListView.builder(
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
                              'Today',
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
