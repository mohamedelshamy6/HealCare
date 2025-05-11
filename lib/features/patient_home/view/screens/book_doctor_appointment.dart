import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/app_images.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/core/widgets/custom_date_picker.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/patient_home/logic/cubit/appointenent_schedual_cubit.dart';
import 'package:heal_care/features/patient_home/data/repos/appointenent_schedual_repositorie.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';
import '../widgets/doctor_status_container.dart';
import '../widgets/visit_hours.dart';
import 'package:intl/intl.dart';

class BookDoctorAppointment extends StatelessWidget {
  final DoctorsModel doctorsModel;
  const BookDoctorAppointment({super.key, required this.doctorsModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointenentSchedualCubit(
        DependencyInjection.getIt<AppointenentSchedualRepositorie>(),
      )..fetchSchedule(
          "${AppConstants.baseRestUrl}/rpc/get_doctor_availability",
          doctorsModel.id ?? '',
        ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              children: [
                CustomAppHeader(
                  horizSpace: MediaQuery.sizeOf(context).width < 400 ? 24 : 40,
                  canBack: true,
                  title: 'Book Appointment',
                ),
                verticalSpace(24),
                _DoctorProfileSection(doctorsModel: doctorsModel),
                verticalSpace(24),
                BlocBuilder<AppointenentSchedualCubit,
                    AppointenentSchedualState>(
                  builder: (context, state) {
                    if (state is AppointmentScheduleLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is AppointenentSchedualSuccess) {
                      final schedule = state.schedule;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Schedules',
                              style: AppTextStyles.poppinsBlack(
                                  16, FontWeight.w600)),
                          verticalSpace(16),
                          CustomDatePicker(
                            onDateChange: (selectedDate) {
                              final formatted =
                                  DateFormat('yyyy-MM-dd').format(selectedDate);
                              context
                                  .read<AppointenentSchedualCubit>()
                                  .selectDay(formatted);
                            },
                            daysCount: schedule.days.length,
                          ),
                          verticalSpace(24),
                          Text('Visit Hour',
                              style: AppTextStyles.poppinsBlack(
                                  16, FontWeight.w600)),
                          verticalSpace(18),
                          VisitHours(
                            times: context
                                .watch<AppointenentSchedualCubit>()
                                .selectedDaySlots,
                          ),
                        ],
                      );
                    } else if (state is AppointenentSchedualError) {
                      return Text(state.error,
                          style: TextStyle(color: Colors.red));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                verticalSpace(32),
                CustomButton(
                  buttonAction: () {
                    Navigator.pushNamed(
                      context,
                      Routes.bookingPayment,
                      arguments: doctorsModel,
                    );
                  },
                  buttonText: 'Book Appointment',
                  borderRadius: 8,
                  height: 48.h,
                  textStyle: AppTextStyles.poppinsWhite(14, FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DoctorProfileSection extends StatelessWidget {
  final DoctorsModel doctorsModel;
  const _DoctorProfileSection({required this.doctorsModel});

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
                color: Colors.pink[200]!.withOpacity(0.35),
                borderRadius: BorderRadius.circular(25.r),
                image: DecorationImage(
                  image: AssetImage(doctorsModel.image.toString()),
                  fit: BoxFit.fill,
                ),
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
          '${doctorsModel.name} is a top Cardiologist specialist. Available for private consultation.',
          style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
        ),
      ],
    );
  }
}
