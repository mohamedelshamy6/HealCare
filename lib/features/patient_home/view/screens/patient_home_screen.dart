import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/patient_home/view/screens/all_doctors.dart';
import 'package:heal_care/features/patient_home/view/widgets/find_doctor_container.dart';
import 'package:heal_care/features/patient_home/view/widgets/patient_home_header.dart';
import 'package:heal_care/features/patient_home/view/widgets/patiant_home_shimmer.dart';
import 'package:heal_care/features/patient_home/view/widgets/home_banner.dart';
import 'package:heal_care/features/patient_home/view/widgets/home_categories.dart';
import 'package:heal_care/features/patient_home/view/widgets/title_with_see_all.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<DoctorsCubit, DoctorsState>(
          builder: (context, state) {
            if (state is DoctorsLoading) {
              return const PatientHomeShimmer();
            } else if (state is DoctorsSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(24),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: const PatientHomeHeader(),
                    ),
                    verticalSpace(32),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Text(
                        'Upcoming Appointments',
                        style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
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
                                    doctorsModel: state.doctorsModel,
                                  ),
                                ),
                              );
                            },
                          ),
                          verticalSpace(8),
                          if (state.doctorsModel.isEmpty)
                            const Center(child: Text('No doctors available'))
                          else
                            FindDoctorsContainer(
                                doctorsModel: state.doctorsModel),
                          verticalSpace(16),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is DoctorsFailure) {
              return Center(
                child: Text(
                  'Error: ${state.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(child: Text('Press refresh to load doctors'));
          },
        ),
      ),
    );
  }
}
