import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/spacing.dart';
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
  TextEditingController messageController = TextEditingController();
  List<GetAllMessagesForAspecificConversationModel> messages = [];
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool isLoading = true;

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

    // Fetch messages when chat opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        isLoading = true;
      });
      context.read<ChatCubit>().getMessagesForConversation(
            conversationId: widget.chatIndex,
          );
    });
  }

  void _addMessageOptimistically(
      String content, String senderId, String senderType) {
    final newMessage = GetAllMessagesForAspecificConversationModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
      content: content,
      senderId: senderId,
      senderType: senderType,
      sentAt: DateTime.now().toIso8601String(),
      conversationId: widget.chatIndex,
    );

    setState(() {
      messages.add(newMessage);
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  String _formatTime(String? isoTime) {
    if (isoTime == null) return '';
    try {
      final dateTime = DateTime.parse(isoTime);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }

  bool _isValidMessage(String message) {
    // Check if message is empty or only contains whitespace
    if (message.trim().isEmpty) return false;

    // Check if message is too long (e.g., more than 500 characters)
    if (message.length > 500) return false;

    // Check if message contains only special characters
    final hasValidContent =
        message.trim().replaceAll(RegExp(r'[^\w\s]'), '').isNotEmpty;
    if (!hasValidContent) return false;

    return true;
  }

  Widget _buildSentMessageShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 200.w,
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Container(
                height: 16.h,
                color: Colors.white,
              ),
            ),
            horizontalSpace(8),
            CircleAvatar(
              radius: 20.r,
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
            child: Row(
              mainAxisAlignment: index % 2 == 0
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                if (index % 2 == 0) ...[
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.white,
                  ),
                  horizontalSpace(8),
                ],
                Container(
                  width: 200.w,
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Container(
                    height: 16.h,
                    color: Colors.white,
                  ),
                ),
                if (index % 2 != 0) ...[
                  horizontalSpace(8),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.white,
                  ),
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
    final String? image = widget.model.counterpartImage;
    final String? doctorImage = CacheHelper().getData(key: 'doctor_image');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppHeader(
              title: widget.model.counterpartName ?? '',
              canBack: true,
              actionsWidgets: [
                IconButton(
                  onPressed: () {
                    // TODO: Implement calendar functionality
                  },
                  icon: Icon(
                    Icons.calendar_today,
                    color: AppColors.mainColor,
                    size: 24.r,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Implement video call functionality
                  },
                  icon: Icon(
                    Icons.video_call,
                    color: AppColors.mainColor,
                    size: 24.r,
                  ),
                ),
                horizontalSpace(8),
              ],
            ),
            Expanded(
              child: BlocBuilder<ChatCubit, ChatState>(
                buildWhen: (previous, current) {
                  if (current is GetMessagesForConversationSuccess ||
                      current is SendMessageInConversationSuccess) {
                    setState(() {
                      isLoading = false;
                      if (current is GetMessagesForConversationSuccess) {
                        messages = current.messages;
                      }
                    });
                    return true;
                  } else if (current is GetMessagesForConversationLoading) {
                    setState(() {
                      isLoading = true;
                    });
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  if (state is GetMessagesForConversationSuccess ||
                      messages.isNotEmpty) {
                    // Scroll to bottom when new messages arrive
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottom();
                    });

                    final displayMessages =
                        state is GetMessagesForConversationSuccess
                            ? state.messages
                            : messages;

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: displayMessages.length,
                      itemBuilder: (context, index) {
                        final message = displayMessages[index];
                        final String? userType =
                            CacheHelper().getData(key: 'role');
                        final bool isSentByMe = message.senderType == userType;

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: isSentByMe
                              ? ChatBubbleForFriend(
                                  key: ValueKey(
                                      '${message.content}-${message.sentAt}'),
                                  message: message.content ?? '',
                                  date: _formatTime(message.sentAt),
                                  type: message.senderType ?? '',
                                  image: doctorImage ?? '',
                                )
                              : ChatBubble(
                                  key: ValueKey(
                                      '${message.content}-${message.sentAt}'),
                                  message: message.content ?? '',
                                  date: _formatTime(message.sentAt),
                                  image: image ?? '',
                                  senderType: message.senderType ?? '',
                                ),
                        );
                      },
                    );
                  }
                  return _buildShimmerLoading();
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
                    spreadRadius: 1,
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
                      maxLines: null,
                      maxLength: 500,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        counterText: '',
                      ),
                    ),
                  ),
                  horizontalSpace(6),
                  IconButton(
                    onPressed: () async {
                      final message = messageController.text.trim();

                      if (!_isValidMessage(message)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter a valid message'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      final String? senderId =
                          CacheHelper().getData(key: 'userId');
                      final String? senderType =
                          CacheHelper().getData(key: 'role');

                      if (senderId == null || senderType == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to get user information'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      messageController.clear();

                      // Add message optimistically
                      _addMessageOptimistically(message, senderId, senderType);

                      try {
                        await context
                            .read<ChatCubit>()
                            .sendMessageinConversation(
                              conversationId: widget.chatIndex,
                              senderId: senderId,
                              content: message,
                              senderType: senderType,
                            );
                      } catch (e) {
                        // Remove the optimistic message if sending fails
                        setState(() {
                          messages.removeLast();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to send message: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.send,
                      size: 24.w,
                      color: AppColors.mainColor,
                    ),
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
