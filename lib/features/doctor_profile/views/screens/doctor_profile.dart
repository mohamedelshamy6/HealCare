
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/features/doctor_profile/views/screens/doctor_edit_profile.dart';
import '../../../../core/routing/routes.dart';
import '../widgets/doctor_profile_header.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../data/models/information_model.dart';
import 'package:heal_care/features/patient_profile/logic/profile_cubit.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';

import '../../../../core/theme/app_text_styles.dart';
import '../widgets/information_row.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = DependencyInjection.getIt<ProfileCubit>();
    _checkUserAndLoadProfile();
  }

  void _checkUserAndLoadProfile() {
    final userId = CacheHelper().getData(key: 'userId') ??
        CacheHelper().getData(key: 'doctor_Id');
    final userRole = CacheHelper().getData(key: 'role');

    if (userId == null || userRole == null) {
      HelperMethods.showCustomSnackBarError(
          context, 'Please log in to view your profile');
    } else {
      // Force refresh when loading the profile to ensure we have the latest data
      _profileCubit.getProfileDataForDoctors(forceRefresh: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingForDoctors) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileSuccessForDoctors &&
                  state.doctor != null) {
                final doctor = state.doctor!;
                log(doctor.toString());
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomAppHeader(canBack: false, title: 'Profile'),
                        verticalSpace(16),
                        Center(
                          child: DoctorProfileHeader(
                            name: doctor.name ?? '',
                            image: doctor.image ?? '',
                          ),
                        ),
                        verticalSpace(24),
                        Row(
                          children: [
                            Text(
                              'Your Information',
                              style: AppTextStyles.poppinsBlack(
                                  14, FontWeight.w500),
                            ),
                            Spacer(),
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              child: Text(
                                'Edit',
                                style: AppTextStyles.poppinsMainColor(
                                    12, FontWeight.w400),
                              ),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => BlocProvider.value(
                                    value: _profileCubit,
                                    child: DoctorEditProfile(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(16),
                        Flexible(
                          fit: FlexFit.loose,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final info = _getDoctorInfo(doctor, index);
                              return InformationRow(
                                icon: info.icon,
                                label: info.label,
                                value: info.value,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                verticalSpace(8),
                            itemCount: 4,
                          ),
                        ),
                        verticalSpace(48),
                        Text(
                          'Working Hours',
                          style: AppTextStyles.poppinsMainColor(
                              16, FontWeight.w600),
                        ),
                        verticalSpace(16),
                        Image.asset(Assets.imagesDoctorWorkingHours),
                        verticalSpace(24),
                        Text(
                          'Biography',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w500),
                        ),
                        verticalSpace(8),
                        Text(
                          doctor.bio ?? 'No biography available',
                          style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                        ),
                        verticalSpace(24),
                        Text(
                          'Education',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w500),
                        ),
                        verticalSpace(8),
                        Text(
                          doctor.education ??
                              'No education information available',
                          style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                        ),
                        verticalSpace(8),
                        Divider(height: 0),
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          child: ListTile(
                            trailing: Icon(
                              Icons.logout,
                              color: AppColors.tFFErrorColor,
                            ),
                            title: Text(
                              'Logout',
                              style: AppTextStyles.poppinsMainColor(
                                      16, FontWeight.w500)
                                  .copyWith(color: AppColors.tFFErrorColor),
                            ),
                          ),
                          onTap: () {
                            HelperMethods.showLogoutAlertDialog(
                              context,
                              () async {
                                await UserCacheHelper.clearUserCache();
                                CacheHelper().removeData(key: 'role');
                                CacheHelper()
                                    .deleteSecuredData(key: 'accessToken');
                                CacheHelper().removeData(key: 'doctorId');
                                CacheHelper().removeData(key: 'userId');
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                  Routes.choose,
                                  (route) => false,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              } else if (state is ProfileErrorForDoctors) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return const Center(child: Text('No data available'));
            },
          ),
        ),
      ),
    );
  }

  InformationModel _getDoctorInfo(DoctorsModel doctor, int index) {
    log('Getting doctor info at index $index'); 
    log('Doctor data: ${doctor.toJson()}'); 

    switch (index) {
      case 0:
        final info = InformationModel(
          icon: Assets.iconsAgeIconBlue,
          label: 'Specialization',
          value: doctor.specialization ?? 'Not available',
        );
        log('Specialization info: $info'); 
        return info;
      case 1:
        final info = InformationModel(
          icon: Assets.iconsEmailIconBlue,
          label: 'Email',
          value: doctor.email ?? 'Not available',
        );
        log('Email info: $info'); 
        return info;
      case 2:
        final info = InformationModel(
          icon: Assets.iconsGenderIconBlue,
          label: 'Gender',
          value: doctor.gender ?? 'Not available',
        );
        log('Gender info: $info'); 
        return info;
      case 3:
        final info = InformationModel(
          icon: Assets.iconsLocationIconBlue,
          label: 'Address',
          value: doctor.address ?? 'Not available',
        );
        log('Address info: $info'); 
        return info;
      default:
        return InformationModel(
          icon: Assets.iconsEmailIconBlue,
          label: 'Unknown',
          value: 'Not available',
        );
    }
  }
}
