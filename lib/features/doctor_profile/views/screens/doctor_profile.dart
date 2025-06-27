import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_colors.dart' show AppColors;
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/doctor_profile/data/models/information_model.dart';
import 'package:heal_care/features/doctor_profile/views/screens/doctor_edit_profile.dart';
import 'package:heal_care/features/doctor_profile/views/widgets/doctor_profile_header.dart';
import 'package:heal_care/features/doctor_profile/views/widgets/information_row.dart';
import 'package:heal_care/features/doctor_profile/views/widgets/working_hours_widget.dart';
import 'package:heal_care/features/patient_profile/logic/profile_cubit.dart';

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
    _loadDoctorProfile();
  }

  void _loadDoctorProfile() async {
    final doctor = await UserCacheHelper.getCachedDoctorData();
    if (doctor != null) {
      _profileCubit.getProfileDataForDoctors(forceRefresh: true);
      _profileCubit.fetchDoctorSchedule(doctor.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _profileCubit,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProfileCubit, ProfileState>(
            buildWhen: (previous, current) =>
                current is ProfileLoadingForDoctors ||
                current is ProfileSuccessForDoctors ||
                current is ProfileErrorForDoctors,
            builder: (context, state) {
              if (state is ProfileSuccessForDoctors && state.doctor != null) {
                final doctor = state.doctor!;
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
                        ListView.separated(
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
                        verticalSpace(32),
                        BlocBuilder<ProfileCubit, ProfileState>(
                          bloc: _profileCubit,
                          builder: (context, state) {
                            if (state is DoctorScheduleLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (state is DoctorScheduleSuccess) {
                              return WorkingHoursWidget(
                                  schedule: state.schedule.days);
                            }
                            return const SizedBox.shrink();
                          },
                        ),
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
                        verticalSpace(24),
                        Text(
                          'Experience',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w500),
                        ),
                        verticalSpace(8),
                        Text(
                          doctor.experience ??
                              'No experience information available',
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
                                await UserCacheHelper.clear();
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
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  InformationModel _getDoctorInfo(DoctorsModel doctor, int index) {
    switch (index) {
      case 0:
        return InformationModel(
          icon: Assets.iconsAgeIconBlue,
          label: 'Specialization',
          value: doctor.specialization ?? 'Not available',
        );
      case 1:
        return InformationModel(
          icon: Assets.iconsEmailIconBlue,
          label: 'Email',
          value: doctor.email ?? 'Not available',
        );
      case 2:
        return InformationModel(
          icon: Assets.iconsGenderIconBlue,
          label: 'Gender',
          value: doctor.gender ?? 'Not available',
        );
      case 3:
        return InformationModel(
          icon: Assets.iconsLocationIconBlue,
          label: 'Address',
          value: doctor.address ?? 'Not available',
        );
      default:
        return InformationModel(
          icon: Assets.iconsEmailIconBlue,
          label: 'Unknown',
          value: 'Not available',
        );
    }
  }
}
