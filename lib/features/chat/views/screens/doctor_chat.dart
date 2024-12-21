import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/features/chat/views/widgets/chat_list_view.dart';
import '../../../../core/widgets/custom_app_header.dart';

class DoctorChat extends StatelessWidget {
  const DoctorChat({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppHeader(
                horizSpace: 89.w,
                title: 'Chats',
              ),
              verticalSpace(16),
              ChatListView()
            ],
          ),
        ),
      );
  }
}