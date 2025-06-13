import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/get_conversations_model.dart';
import '../../../doctor_home/data/models/patient_model.dart';
import '../../../patient_home/data/models/doctors_models.dart';

class ChatItem extends StatelessWidget {
  final Object model;
  final String type;
  const ChatItem({super.key, required this.model, required this.type});

  @override
  Widget build(BuildContext context) {
    if (model is GetConversationsModel) {
      final conversation = model as GetConversationsModel;
      return Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        color: Colors.transparent,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundImage:
                  NetworkImage(conversation.counterpartImage ?? ''),
            ),
            horizontalSpace(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          conversation.counterpartName ?? 'There is no name',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      horizontalSpace(4),
                      Text(
                        conversation.lastMessageSentAt ??
                            'there is no last seen message',
                        style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                      ),
                    ],
                  ),
                  verticalSpace(5.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessageContent ?? '',
                          style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Container(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Fallback for old model types
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      color: Colors.transparent,
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.r,
            backgroundImage: AssetImage(type == 'patient'
                ? (model as DoctorssModel).image
                : (model as PatientModel).image),
          ),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        type == 'patient'
                            ? (model as DoctorssModel).name
                            : (model as PatientModel).name,
                        style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    horizontalSpace(4),
                    Text(
                      '5:02 PM',
                      style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                    ),
                  ],
                ),
                verticalSpace(5.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Of course, we just added that to your order. Thanks for letting us know!',
                        style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Container(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
