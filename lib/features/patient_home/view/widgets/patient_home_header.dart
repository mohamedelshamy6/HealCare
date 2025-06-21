import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';

class PatientHomeHeader extends StatefulWidget {
  const PatientHomeHeader({super.key});

  @override
  State<PatientHomeHeader> createState() => _PatientHomeHeaderState();
}

class _PatientHomeHeaderState extends State<PatientHomeHeader>
    with WidgetsBindingObserver {
  PatientsModel? cachedPatient;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    _loadCachedData();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _isMounted = false;
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _loadCachedData();
    }
  }

  Future<void> _loadCachedData() async {
    final patient = await UserCacheHelper.getCachedPatientData();
    if (_isMounted && patient != null) {
      setState(() {
        cachedPatient = patient;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24.r,
          backgroundImage: cachedPatient?.image != null
              ? NetworkImage(cachedPatient!.image!)
              : null,
          child: cachedPatient?.image == null ? Icon(Icons.person) : null,
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
            ),
            Text(
              cachedPatient?.name ?? '',
              style: AppTextStyles.poppinsBlack(16, FontWeight.w500),
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.eWalletHistory);
              },
              child: SvgPicture.asset(
                Assets.iconsWalletIcon,
                width: 22.w,
                height: 22.h,
              ),
            ),
            horizontalSpace(16),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.patientFavoriteScreen);
              },
              child: Image.asset(
                Assets.iconsFavoriteIconDarkblueOutlined,
                width: 22.w,
                height: 22.h,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
