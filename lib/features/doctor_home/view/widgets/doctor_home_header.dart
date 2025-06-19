import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';

class DoctorHomeHeader extends StatefulWidget {
  final DoctorsModel? cachedDoctor;

  const DoctorHomeHeader({
    super.key,
    this.cachedDoctor,
  });

  @override
  State<DoctorHomeHeader> createState() => _DoctorHomeHeaderState();
}

class _DoctorHomeHeaderState extends State<DoctorHomeHeader> {
  DoctorsModel? cachedDoctor;

  @override
  void initState() {
    super.initState();
    _loadCachedData();
    context.read<DoctorsCubit>().getAllDoctors();
  }

  Future<void> _loadCachedData() async {
    final doctor = await UserCacheHelper.getCachedDoctorData();
    if (doctor != null) {
      setState(() {
        cachedDoctor = doctor;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundImage: cachedDoctor?.image != null
                  ? NetworkImage(cachedDoctor!.image!)
                  : null,
              child: cachedDoctor?.image == null ? Icon(Icons.person) : null,
            ),
            horizontalSpace(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome Back',
                  style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                ),
                Text(
                  cachedDoctor?.name ?? 'Dr. Mena Wasef',
                  style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.notificationsDoctorScreen,
              arguments: 'doctor',
            );
          },
          child: SvgPicture.asset(Assets.iconsNotificationIconBlueDot),
        ),
      ],
    );
  }
}
