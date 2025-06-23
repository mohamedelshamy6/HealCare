import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/helpers/user_cache_helper.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/doctor_booking/logic/cubit/doctorbooking_cubit.dart';
import 'package:heal_care/features/doctor_home/view/widgets/doctor_home_header.dart';
import 'package:heal_care/features/doctor_home/view/widgets/doctor_home_loading_shimmer.dart';
import 'package:heal_care/features/doctor_home/view/widgets/home_list_view.dart';

class DoctorHomeScreen extends StatelessWidget {
  const DoctorHomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 44.h),
        child: FutureBuilder<DoctorsModel?>(
          future: UserCacheHelper.getCachedDoctorData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('No doctor found.'));
            }

            final doctorId = snapshot.data!.id;

            final patientState = context.read<PatientsCubit>().state;
            if (patientState is PatientsSuccess) {
              context.read<DoctorbookingCubit>().fetchAppointments(doctorId!);
            }

            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: DoctorHomeHeader()),
                SliverToBoxAdapter(child: verticalSpace(24)),
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20.h,
                        child: Text(
                          'Start your journey',
                          style: AppTextStyles.poppinsBlack(14, FontWeight.w600),
                        ),
                      ),
                      Image.asset(
                        Assets.imagesDoctorHomeBanner,
                        height: 178.h,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: verticalSpace(25)),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Patients Visits',
                            style: AppTextStyles.poppinsBlack(16, FontWeight.w600),
                          ),
                          Text(
                            '1 OCT - 30 OCT',
                            style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.mainColor.withOpacity(.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 32.h,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              children: [
                                Text(
                                  'This Month',
                                  style: AppTextStyles.poppinsMainColor(10, FontWeight.w500),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.mainColor,
                                  size: 20.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(child: verticalSpace(24)),
                SliverToBoxAdapter(
                  child: Image.asset(
                    Assets.imagesDataChart,
                    height: 166.h,
                    fit: BoxFit.contain,
                  ),
                ),
                SliverToBoxAdapter(child: verticalSpace(40)),
                SliverToBoxAdapter(
                  child: Text(
                    'Recently Appointment',
                    style: AppTextStyles.poppinsBlack(16, FontWeight.w700),
                  ),
                ),
                SliverToBoxAdapter(child: verticalSpace(16)),
                BlocListener<PatientsCubit, PatientsState>(
                  listener: (context, patientState) {
                    if (patientState is PatientsSuccess) {
                      context.read<DoctorbookingCubit>().fetchAppointments(doctorId!);
                    }
                  },
                  child: BlocBuilder<DoctorbookingCubit, DoctorbookingState>(
                    builder: (context, bookingState) {
                      if (bookingState is DoctorbookingLoading) {
                        return const SliverToBoxAdapter(
                          child: DoctorHomeLoadingShimmer(),
                        );
                      } else if (bookingState is DoctorbookingFailure) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text('Failed to load appointments: ${bookingState.message}'),
                          ),
                        );
                      } else if (bookingState is DoctorbookingSuccess) {
                        final appointments = bookingState.doctorBooking;
                        if (appointments.isEmpty) {
                          return const SliverToBoxAdapter(
                            child: Center(child: Text('No Appointments Found')),
                          );
                        }
                        return HomeListView(appointments: appointments);
                      } else {
                        return const SliverToBoxAdapter(child: SizedBox());
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
