import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../logic/cubit/chat_cubit.dart';
import 'chat_item.dart';
import '../screens/inside_chat_screen.dart';
import '../screens/chat_bot.dart';

class ChatListView extends StatelessWidget {
  final String type;
  const ChatListView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) {
        if (current is GetChatConversitionSuccess ||
            current is GetChatConversitionLoading ||
            current is GetChatConversitionFailure) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        if (state is GetChatConversitionLoading) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.r,
                        backgroundColor: Colors.white,
                      ),
                      horizontalSpace(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                            verticalSpace(8),
                            Container(
                              width: 200.w,
                              height: 14.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        if (state is GetChatConversitionSuccess) {
          if (state.conversations.isEmpty) {
            return Center(
              child: Text(
                'No conversations yet',
                style: AppTextStyles.poppinsGrey(16, FontWeight.w500),
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            itemCount: state.conversations.length,
            itemBuilder: (context, index) {
              final conversation = state.conversations[index];
              return GestureDetector(
                onTap: () {
                  final chatCubit = context.read<ChatCubit>();
                  // Show ChatBotScreen first for patient chats
                  if (conversation.doctorId != null && type == 'patient') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: chatCubit,
                          child: ChatBotScreen(
                            chatIndex: conversation.conversationId ?? '',
                            model: conversation,
                          ),
                        ),
                      ),
                    );
                  }

                  // For patient chats, go directly to chat screen
                  if (type == 'doctor') {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: chatCubit,
                          child: InsideChatScreen(
                            chatIndex: conversation.conversationId ?? '',
                            model: conversation,
                          ),
                        ),
                      ),
                    );
                  }
                },
                child: ChatItem(
                  model: conversation,
                  type: type,
                ),
              );
            },
          );
        }

        if (state is GetChatConversitionFailure) {
          return Center(
            child: Text(
              state.error,
              style: AppTextStyles.poppinsGrey(16, FontWeight.w500),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
