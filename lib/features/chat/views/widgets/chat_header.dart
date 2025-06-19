import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heal_care/features/patient_home/data/models/doctors_models.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../data/models/get_conversations_model.dart';
import '../../../doctor_home/data/models/patient_model.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({
    super.key,
    required this.model,
  });

  final Object model;

  @override
  Widget build(BuildContext context) {
    String name = '';
    String image = '';
    String specialization = '';

    if (model is GetConversationsModel) {
      final conversation = model as GetConversationsModel;
      name = conversation.senderUsername ?? 'there is no user name';
      image = conversation.senderUserImage ?? '';
    } else if (model is DoctorssModel) {
      final doctor = model as DoctorssModel;
      name = doctor.name;
      image = doctor.image;
      specialization = doctor.job;
    } else if (model is PatientModel) {
      final patient = model as PatientModel;
      name = patient.name;
      image = patient.image;
    }

    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.r,
            color: AppColors.mainColor,
          ),
        ),
        horizontalSpace(8),
        CircleAvatar(
          radius: 20.r,
          backgroundImage: NetworkImage(image),
        ),
        horizontalSpace(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
            ),
            if (specialization.isNotEmpty)
              Text(
                specialization,
                style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
              ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Assets.iconsCallIconBlue),
        ),
      ],
    );
  }
}
