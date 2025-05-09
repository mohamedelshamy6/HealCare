import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import 'chat_item.dart';
import '../../../patient_home/data/models/doctor_appointment_model.dart';

import '../../../doctor_home/data/models/patient_model.dart';

class ChatListView extends StatelessWidget {
  final String type;
  const ChatListView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        itemCount: type == 'patient' ? doctors.length : patients.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: 16.h,
            ),
            child: GestureDetector(
              onTap: () {
                type == 'patient'
                    ? Navigator.of(context)
                        .pushNamed(Routes.chatBot, arguments: [
                        index,
                        type,
                        doctors[index],
                      ])
                    : Navigator.of(context)
                        .pushNamed(Routes.insideChat, arguments: [
                        index,
                        type,
                        patients[index],
                      ]);
              },
              child: ChatItem(
                type: type,
                model: type == 'patient' ? doctors[index] : patients[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
