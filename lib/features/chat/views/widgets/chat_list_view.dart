import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/routing/routes.dart';
import '../../logic/cubit/chat_cubit.dart';
import 'chat_item.dart';

class ChatListView extends StatelessWidget {
  final String type;
  const ChatListView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is GetChatConversitionLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is GetChatConversitionSuccess) {
          if (state.conversations.isEmpty) {
            return Center(
              child: Text(
                'No conversations yet',
                style: AppTextStyles.poppinsGrey(16, FontWeight.w500),
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            itemCount: state.conversations.length,
            itemBuilder: (context, index) {
              final conversation = state.conversations[index];
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 16.h,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Routes.insideChat,
                      arguments: [
                        conversation.conversationId,
                        type,
                        conversation,
                      ],
                    );
                  },
                  child: ChatItem(
                    type: type,
                    model: conversation,
                  ),
                ),
              );
            },
          );
        } else if (state is GetChatConversitionFailure) {
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
