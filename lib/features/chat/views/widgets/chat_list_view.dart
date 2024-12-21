import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/features/chat/views/widgets/chat_item.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          itemCount: 12,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: 16.h,
              ),
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.insideChat,arguments: index);
                  },
                  child: ChatItem()),
            );
          }),
    );
  }
}
