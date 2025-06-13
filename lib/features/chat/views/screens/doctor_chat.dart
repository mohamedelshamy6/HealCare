import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/chat/logic/cubit/chat_cubit.dart';
import 'package:heal_care/features/chat/views/widgets/chat_list_view.dart';

class DoctorChat extends StatefulWidget {
  final String type;
  const DoctorChat({super.key, required this.type});

  @override
  State<DoctorChat> createState() => _DoctorChatState();
}

class _DoctorChatState extends State<DoctorChat> {
  @override
  void initState() {
    super.initState();
    context.read<ChatCubit>().getConversations(
          userId: CacheHelper().getData(key: 'doctor_Id') ?? '',
          userType: 'doctor',
        );
    log('doctor_Id: ${CacheHelper().getData(key: 'doctor_Id')}');
    log('userType: doctor');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              Expanded(
                child: ChatListView(type: widget.type),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
