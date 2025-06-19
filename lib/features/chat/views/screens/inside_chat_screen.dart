import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/chat/data/models/get_all_messages_for_aspecific_conversation_model.dart';
import 'package:heal_care/features/chat/logic/cubit/chat_cubit.dart';
import 'package:heal_care/features/chat/views/widgets/chat_bubble.dart';
import 'package:heal_care/features/chat/views/widgets/chat_bubble_for_friend.dart';
import 'package:shimmer/shimmer.dart';

class InsideChatScreen extends StatefulWidget {
  final String chatIndex;
  final dynamic model;

  const InsideChatScreen({
    super.key,
    required this.chatIndex,
    required this.model,
  });

  @override
  State<InsideChatScreen> createState() => _InsideChatScreenState();
}

class _InsideChatScreenState extends State<InsideChatScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollToBottom();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ChatCubit>()
          .getMessagesForConversation(conversationId: widget.chatIndex);
      context.read<ChatCubit>().listenToNewMessages(widget.chatIndex);
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  String _formatTime(String? isoTime) {
    if (isoTime == null) return '';
    try {
      final dateTime = DateTime.parse(isoTime);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      return '';
    }
  }

  bool _isValidMessage(String message) {
    if (message.trim().isEmpty || message.length > 500) return false;
    return message.trim().replaceAll(RegExp(r'[^\w\s]'), '').isNotEmpty;
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: index % 2 == 0
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                if (index % 2 == 0) ...[
                  CircleAvatar(radius: 20.r, backgroundColor: Colors.white),
                  horizontalSpace(8),
                ],
                Container(
                  width: 200.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                if (index % 2 != 0) ...[
                  horizontalSpace(8),
                  CircleAvatar(radius: 20.r, backgroundColor: Colors.white),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final String? image = widget.model.senderUserImage;
    // final String? doctorImage = CacheHelper().getData(key: 'doctor_image');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppHeader(
              title: widget.model.senderUsername ?? '',
              canBack: true,
              actionsWidgets: [
                Icon(Icons.calendar_today, color: AppColors.mainColor),
                horizontalSpace(8),
                Icon(Icons.video_call, color: AppColors.mainColor),
                horizontalSpace(8),
              ],
            ),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                builder: (context, state) {
                  if (state is GetMessagesForConversationLoading) {
                    return _buildShimmerLoading();
                  }

                  final messages = context
                          .read<ChatCubit>()
                          .conversationMessages[widget.chatIndex] ??
                      [];

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scrollToBottom();
                  });

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: _getMessageWidget(messages[index]),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!;
                          } else {
                            return Container();
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 3,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      focusNode: _focusNode,
                      maxLength: 500,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                        counterText: '',
                      ),
                    ),
                  ),
                  horizontalSpace(6),
                  isSending
                      ? SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: CircularProgressIndicator(strokeWidth: 2.r),
                        )
                      : IconButton(
                          icon: Icon(Icons.send,
                              color: AppColors.mainColor, size: 24.w),
                          onPressed: () async {
                            final message = messageController.text.trim();
                            final String? senderType =
                                CacheHelper().getData(key: 'role');

                            String? currentUserId;

                            if (senderType == 'patient') {
                              final patient =
                                  await UserCacheHelper.getCachedPatientData();
                              currentUserId = patient?.id;
                            } else if (senderType == 'doctor') {
                              final doctor =
                                  await UserCacheHelper.getCachedDoctorData();
                              currentUserId = doctor?.id;
                            }

                            if (currentUserId == null || senderType == null) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Failed to get user information. Please try logging out and back in.'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              return;
                            }

                            if (!_isValidMessage(message)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a valid message'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            messageController.clear();
                            setState(() => isSending = true);

                            await context
                                .read<ChatCubit>()
                                .sendMessageinConversation(
                                  conversationId: widget.chatIndex,
                                  senderId: currentUserId,
                                  content: message,
                                  senderType: senderType,
                                );

                            setState(() => isSending = false);
                          },
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Widget> _getMessageWidget(
      GetAllMessagesForAspecificConversationModel message) async {
    final String? senderType = CacheHelper().getData(key: 'role');
    String? currentUserId;

    if (senderType == 'patient') {
      final patient = await UserCacheHelper.getCachedPatientData();
      currentUserId = patient?.id;
    } else if (senderType == 'doctor') {
      final doctor = await UserCacheHelper.getCachedDoctorData();
      currentUserId = doctor?.id;
    }

    final bool isSentByMe = message.senderId == currentUserId;

    final String? senderImage = isSentByMe
        ? (CacheHelper().getData(key: 'patient_image') ??
            CacheHelper().getData(key: 'doctor_image'))
        : widget.model.senderUserImage;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: isSentByMe
          ? ChatBubbleForFriend(
              key: ValueKey('${message.id}'),
              message: message.content ?? '',
              date: _formatTime(message.sentAt),
              type: 'sender',
              image: senderImage ?? '',
            )
          : ChatBubble(
              key: ValueKey('${message.id}'),
              message: message.content ?? '',
              date: _formatTime(message.sentAt),
              image: widget.model.senderUserImage ?? '',
              senderType: 'receiver',
            ),
    );
  }
}
