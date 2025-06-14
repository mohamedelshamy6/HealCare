import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/chat/logic/cubit/chat_cubit.dart';
import 'package:heal_care/features/chat/views/widgets/chat_list_view.dart';

class PatientChat extends StatefulWidget {
  const PatientChat({super.key, required this.type});
  final String type;

  @override
  State<PatientChat> createState() => _PatientChatState();
}

class _PatientChatState extends State<PatientChat> {
  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  void _loadConversations() {
    final String patientId =
        CacheHelper().getData(key: 'patient_Id')?.toString() ?? '';
    final String? userId = CacheHelper().getData(key: 'userId');

    String? patientIdCheck() {
      if (patientId.isNotEmpty && patientId != "null") {
        return patientId;
      } else if (userId != null && userId.isNotEmpty && userId != "null") {
        return userId;
      }
      return null;
    }

    final String? finalPatientId = patientIdCheck();

    if (finalPatientId != null) {
      context.read<ChatCubit>().getConversations(
            userId: finalPatientId,
            userType: 'patient',
          );
    }

    log('patient_Id: ${CacheHelper().getData(key: 'patient_Id')}');
    log('userType: patient');
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
