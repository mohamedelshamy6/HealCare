import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/get_conversations_model.dart';
import '../../../doctor_home/data/models/patient_model.dart';

class ChatItem extends StatelessWidget {
  final Object model;
  final String type;
  const ChatItem({super.key, required this.model, required this.type});

  String _formatTime(String? timeString) {
    if (timeString == null) return '';
    try {
      final time = DateTime.parse(timeString);
      return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '';
    }
  }

  Future<Widget> _loadFallbackImage(GetConversationsModel conversation) async {
    // First try to get doctor data
    final doctor = await UserCacheHelper.getCachedDoctorData();
    if (doctor != null && doctor.id == conversation.lastMessageSenderId) {
      if (doctor.image != null && doctor.image!.isNotEmpty) {
        return Image.network(
          doctor.image!,
          width: 50.r,
          height: 50.r,
          fit: BoxFit.cover,
        );
      }
    }

    // If not a doctor or no image, try patient data
    final patient = await UserCacheHelper.getCachedPatientData();
    if (patient != null && patient.id == conversation.lastMessageSenderId) {
      if (patient.image != null && patient.image!.isNotEmpty) {
        return Image.network(
          patient.image!,
          width: 50.r,
          height: 50.r,
          fit: BoxFit.cover,
        );
      }
    }

    // If no image found in cache, return default icon
    return _buildDefaultIcon();
  }

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
              backgroundColor: AppColors.mainColor.withOpacity(0.1),
              child: (conversation.senderUserImage?.isNotEmpty == true)
                  ? ClipOval(
                      child: Image.network(
                        conversation.senderUserImage!,
                        width: 50.r,
                        height: 50.r,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return FutureBuilder<Widget>(
                            future: _loadFallbackImage(conversation),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return _buildDefaultIcon();
                              }
                              return snapshot.data ?? _buildDefaultIcon();
                            },
                          );
                        },
                      ),
                    )
                  : _buildDefaultIcon(),
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
                          conversation.senderUsername ?? '',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w700),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      horizontalSpace(4),
                      Text(
                        _formatTime(conversation.lastMessageSentAt),
                        style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                      ),
                    ],
                  ),
                  verticalSpace(5.5),
                  if (conversation.lastMessageContent?.isNotEmpty == true)
                    Text(
                      conversation.lastMessageContent!,
                      style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
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
            backgroundColor: AppColors.mainColor.withOpacity(0.1),
            child: type == 'patient'
                ? (model as DoctorsModel).image!.isNotEmpty
                    ? ClipOval(
                        child: Image.asset(
                          (model as DoctorsModel).image!,
                          width: 50.r,
                          height: 50.r,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            size: 30.r,
                            color: AppColors.mainColor,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 30.r,
                        color: AppColors.mainColor,
                      )
                : (model as PatientModel).image.isNotEmpty
                    ? ClipOval(
                        child: Image.asset(
                          (model as PatientModel).image,
                          width: 50.r,
                          height: 50.r,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            Icons.person,
                            size: 30.r,
                            color: AppColors.mainColor,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: 30.r,
                        color: AppColors.mainColor,
                      ),
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
                          ? (model as DoctorsModel).name ?? 'Unknown Doctor'
                          : (model as PatientModel).name ?? 'Unknown Patient',
                      style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )),
                    horizontalSpace(4),
                    Text(
                      '5:02 PM',
                      style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                    ),
                  ],
                ),
                verticalSpace(5.5),
                Text(
                  'Last message',
                  style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultIcon() {
    return Icon(
      Icons.person,
      size: 30.r,
      color: AppColors.mainColor,
    );
  }
}
