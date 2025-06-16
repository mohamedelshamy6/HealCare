import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/features/patient_profile/views/screens/patient_edit_profile.dart';
import '../../../../core/helpers/cache_helper.dart';
import '../../../../core/helpers/helper_methods.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../data/models/information_model.dart';
import 'package:heal_care/features/patient_profile/logic/profile_cubit.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/information_row.dart';
import '../widgets/profile_header.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({super.key});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    _profileCubit = DependencyInjection.getIt<ProfileCubit>();
    _checkUserAndLoadProfile();
  }

  void _checkUserAndLoadProfile() {
    final userId = CacheHelper().getData(key: 'userId') ??
        CacheHelper().getData(key: 'patient_Id');
    final userRole = CacheHelper().getData(key: 'role');

    if (userId == null || userRole == null) {
      HelperMethods.showCustomSnackBarError(
          context, 'Please log in to view your profile');
    } else {
      _profileCubit.getProfileDataForPatients();
    }
  }


  @override
  void dispose() {
    _profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingForPatients) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProfileSuccessForPatients &&
                  state.patient != null) {
                final patient = state.patient!;
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
                          child: ProfileHeader(
                            name: patient.name ?? '',
                            image: patient.image ?? '',
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
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider.value(
                                      value: _profileCubit,
                                      child: PatientEditProfile(),
                                    ),
                                  ),
                                );
                              },
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
                              final info = _getPatientInfo(patient, index);
                              return InformationRow(
                                icon: info.icon,
                                label: info.label,
                                value: info.value,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                verticalSpace(8),
                            itemCount: 7,
                          ),
                        ),
                        verticalSpace(24),
                        Text(
                          'Medical Information',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w500),
                        ),
                        verticalSpace(8),
                        Text(
                          patient.medicalHistory ??
                              'No medical history available',
                          style: AppTextStyles.poppinsGrey(12, FontWeight.w400),
                        ),
                        verticalSpace(32),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          width: double.infinity,
                          color: AppColors.lighterBlue,
                          child: Center(
                            child: Text(
                              'Files',
                              style: AppTextStyles.poppinsBlack(
                                  16, FontWeight.w400),
                            ),
                          ),
                        ),
                        verticalSpace(16),
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
                                CacheHelper().removeData(key: 'patient_Id');
                                CacheHelper()
                                    .deleteSecuredData(key: 'accessToken');
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
              } else if (state is ProfileErrorForPatients) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return const Center(child: Text('No data available'));
            },
          ),
        ),
      ),
    );
  }

  InformationModel _getPatientInfo(PatientsModel patient, int index) {
    log('Getting patient info at index $index'); // Debug print
    log('Patient data: ${patient.toJson()}'); // Debug print
    switch (index) {
      case 0:
        final info = InformationModel(
          icon: Assets.iconsEmailIconBlue,
          label: 'Email',
          value: patient.email ?? 'Not available',
        );
        log('Email info: $info');
        return info; // Debug print
      case 1:
        final info = InformationModel(
          icon: Assets.iconsGenderIconBlue,
          label: 'Gender',
          value: patient.gender ?? 'Not available',
        );
        log('Gender info: $info');
        return info; // Debug print
      case 2:
        final info = InformationModel(
          icon: Assets.iconsAgeIconBlue,
          label: 'Age',
          value: '${patient.age ?? 'Not available'}',
        );
        log('Age info: $info'); 
        return info;// Debug print
      case 3:
        final info = InformationModel(
          icon: Assets.iconsBloodtypeIconBlue,
          label: 'Blood Type',
          value: patient.bloodType ?? 'Not available',
        );
        log('Blood Type info: $info'); 
        return info;// Debug print
      case 4:
        final info = InformationModel(
          icon: Assets.iconsWeightIconBlue,
          label: 'Weight',
          value: '${patient.weight ?? 'Not available'} kg',
        );
        log('Weight info: $info');
        return info; // Debug print
      case 5:
        final info = InformationModel(
          icon: Assets.iconsHeightIconBlue,
          label: 'Height',
          value: '${patient.height ?? 'Not available'} cm',
        );
        log('Height info: $info'); 
        return info;// Debug print
      case 6:
        final info = InformationModel(
          icon: Assets.iconsLocationIconBlue,
          label: 'Address',
          value: patient.address ?? 'Not available',
        );
        log('Address info: $info');
        return info; // Debug print
      default:
        final info = InformationModel(
          icon: Assets.iconsEmailIconBlue,
          label: 'Unknown',
          value: 'Not available',
        );
        log('Unknown info: $info'); // Debug print
        return info;
    }
  }
}
