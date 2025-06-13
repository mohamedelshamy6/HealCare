import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/patient_home/view/screens/all_doctors.dart';
import 'package:heal_care/features/patient_home/view/widgets/find_doctor_container.dart';
import 'package:heal_care/features/patient_home/view/widgets/patient_home_header.dart';
import 'package:heal_care/features/patient_home/view/widgets/patiant_home_shimmer.dart';
import 'package:heal_care/features/patient_home/view/widgets/home_banner.dart';
import 'package:heal_care/features/patient_home/view/widgets/home_categories.dart';
import 'package:heal_care/features/patient_home/view/widgets/title_with_see_all.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen>
    with WidgetsBindingObserver {
  bool _hasInitializedData = false;
  PatientsModel? cachedPatient;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadCachedData();
    context.read<DoctorsCubit>().getAllDoctors();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Refresh data when app comes back to foreground
      context.read<DoctorsCubit>().getAllDoctors();
    }
  }

  // This method will be called when navigating back to this screen
  void refreshData() {
    context.read<DoctorsCubit>().getAllDoctors();
  }

  Future<void> _loadCachedData() async {
    final patient = await UserCacheHelper.getCachedPatientData();
    if (patient != null) {
      setState(() {
        cachedPatient = patient;
      });
    }
  }

  void _loadInitialData() {
    if (!_hasInitializedData) {
      _hasInitializedData = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final cubit = context.read<DoctorsCubit>();
        // Only load if we don't already have data or if we're in initial state
        if (cubit.doctorsModel.isEmpty) {
          cubit.getAllDoctors();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<DoctorsCubit, DoctorsState>(
          listener: (context, state) {
            if (state is DoctorsFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error loading doctors: ${state.error}'),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is PatientToogleFavouritesError) {
              // Only show error if it's not just a response format issue
              if (!state.error
                      .toLowerCase()
                      .contains('unexpected response format') &&
                  !state.error.toLowerCase().contains('format')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Failed to update favorite: ${state.error}'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
          buildWhen: (previous, current) {
            return current is DoctorsLoading ||
                current is DoctorsSuccess ||
                current is DoctorsFailure ||
                current is PatientToogleFavouritesSuccess;
          },
          builder: (context, state) {
            final cubit = context.read<DoctorsCubit>();
            final hasExistingData = cubit.doctorsModel.isNotEmpty;

            if (state is DoctorsLoading && !hasExistingData) {
              return const PatientHomeShimmer();
            } else if (state is DoctorsSuccess ||
                state is PatientToogleFavouritesSuccess ||
                hasExistingData) {
              // Use existing data if available, otherwise use state data
              final doctorsToShow = hasExistingData
                  ? cubit.doctorsModel
                  : (state is DoctorsSuccess
                      ? state.doctorsModel
                      : <DoctorsModel>[]);

              return RefreshIndicator(
                onRefresh: () => cubit.getAllDoctors(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(24),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: PatientHomeHeader(cachedPatient: cachedPatient),
                      ),
                      verticalSpace(32),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Text(
                          'Upcoming Appointments',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w700),
                        ),
                      ),
                      const PatientHomeBanner(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TitleWithSeeAll(title: 'Categories'),
                            verticalSpace(8),
                            const HomeCategories(),
                            verticalSpace(24),
                            TitleWithSeeAll(
                              title: 'Find Doctors',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AllDoctorsScreen(
                                      doctorsModel: doctorsToShow,
                                    ),
                                  ),
                                );
                              },
                            ),
                            verticalSpace(8),
                            if (doctorsToShow.isEmpty)
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32.h),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.local_hospital_outlined,
                                        size: 48.r,
                                        color: Colors.grey,
                                      ),
                                      verticalSpace(16),
                                      Text(
                                        'No doctors available',
                                        style: AppTextStyles.poppinsGrey(
                                            14, FontWeight.w500),
                                      ),
                                      verticalSpace(8),
                                      ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<DoctorsCubit>()
                                              .getAllDoctors();
                                        },
                                        child: Text('Retry'),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              FindDoctorsContainer(),
                            verticalSpace(16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state is DoctorsFailure) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64.r,
                        color: Colors.red,
                      ),
                      verticalSpace(16),
                      Text(
                        'Error loading doctors',
                        style: AppTextStyles.poppinsBlack(18, FontWeight.w600),
                      ),
                      verticalSpace(8),
                      Text(
                        state.error,
                        style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(24),
                      ElevatedButton(
                        onPressed: () {
                          context.read<DoctorsCubit>().getAllDoctors();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                ),
              );
            }

            // Initial state - show loading or prompt to load
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_hospital_outlined,
                      size: 64.r,
                      color: Colors.grey,
                    ),
                    verticalSpace(16),
                    Text(
                      'Welcome to HealthCare',
                      style: AppTextStyles.poppinsBlack(18, FontWeight.w600),
                    ),
                    verticalSpace(8),
                    Text(
                      'Load doctors to get started',
                      style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                    ),
                    verticalSpace(24),
                    ElevatedButton(
                      onPressed: () {
                        context.read<DoctorsCubit>().getAllDoctors();
                      },
                      child: Text('Load Doctors'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
