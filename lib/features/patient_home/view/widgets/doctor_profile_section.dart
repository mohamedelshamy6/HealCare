import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/patient_home/view/widgets/doctor_status_container.dart';

class DoctorProfileSection extends StatelessWidget {
  final DoctorsModel doctorsModel;
  const DoctorProfileSection({super.key, required this.doctorsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              height: 92.h,
              width: 90.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.white,
                border: Border.all(
                  width: 2,
                  color: const Color(0xFFE5E5E5),
                ),
              ),
              child: CachedNetworkImage(
                imageUrl: "${doctorsModel.image}",
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                    Icon(Icons.person, size: 40.r, color: Colors.grey),
              ),
            ),
            CircleAvatar(
              radius: 10.r,
              backgroundColor: Colors.white,
              child: CircleAvatar(radius: 6.r, backgroundColor: Colors.green),
            ),
          ],
        ),
        verticalSpace(16),
        Text(doctorsModel.name ?? '',
            style: AppTextStyles.poppinsBlack(20, FontWeight.w500)),
        verticalSpace(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.iconsHeartRate, width: 16.w, height: 10.h),
            horizontalSpace(4),
            Text(
              doctorsModel.experience?.split(RegExp('[-|]')).first ?? '',
              style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
            ),
          ],
        ),
        verticalSpace(20),
        const DoctorStatusContainer(),
        verticalSpace(32),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('About Doctor',
              style: AppTextStyles.poppinsBlack(16, FontWeight.w600)),
        ),
        verticalSpace(8),
        Text(
          '${doctorsModel.name} is a ${doctorsModel.bio} .',
          style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
        ),
      ],
    );
  }
}
