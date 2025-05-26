import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/core/widgets/custom_date_picker.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/patient_home/data/repos/book_appointment_repository.dart';
import 'package:heal_care/features/patient_home/logic/cubit/appointenent_schedual_cubit.dart';
import 'package:heal_care/features/patient_home/data/repos/appointenent_schedual_repositorie.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';
import 'package:heal_care/features/patient_home/view/widgets/doctor_profile_section.dart';
import 'package:heal_care/features/patient_home/view/widgets/shimmer_custom_date_picker.dart';
import 'package:heal_care/features/patient_home/view/widgets/shimmer_visithours.dart';
import '../widgets/visit_hours.dart';
import 'package:intl/intl.dart';

class BookDoctorAppointment extends StatelessWidget {
  final DoctorsModel doctorsModel;
  final PatientsModel? patientsModel;
  const BookDoctorAppointment(
      {super.key, required this.doctorsModel, this.patientsModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppointenentSchedualCubit(
        DependencyInjection.getIt<AppointenentSchedualRepositorie>(),
        DependencyInjection.getIt<BookAppointmentRepository>(),
      )..fetchSchedule(
          "${AppConstants.baseRestUrl}/rpc/get_doctor_availability",
          doctorsModel.id ?? '',
        ),
      child: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                children: [
                  CustomAppHeader(
                    seenAll: false,
                    horizSpace:
                        MediaQuery.sizeOf(context).width < 400 ? 24 : 40,
                    canBack: true,
                    title: 'Book Appointment',
                  ),
                  verticalSpace(24),
                  DoctorProfileSection(doctorsModel: doctorsModel),
                  verticalSpace(24),
                  BlocBuilder<AppointenentSchedualCubit,
                      AppointenentSchedualState>(
                    builder: (context, state) {
                      if (state is AppointmentScheduleLoading) {
                        return Column(
                          children: [
                            ShimmerDatePicker(),
                            verticalSpace(24),
                            ShimmerVisitHours(),
                          ],
                        );
                      } else if (state is AppointenentSchedualSuccess) {
                        final schedule = state.schedule;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Schedules',
                                style: AppTextStyles.poppinsBlack(
                                    16, FontWeight.w600)),
                            verticalSpace(16),
                            if (schedule.days.isEmpty)
                              Text('No schedule available',
                                  style: AppTextStyles.poppinsGrey(
                                      14, FontWeight.w400)),
                            CustomDatePicker(
                              onDateChange: (selectedDate) {
                                final formatted = DateFormat('yyyy-MM-dd')
                                    .format(selectedDate);
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
                            if (context
                                .watch<AppointenentSchedualCubit>()
                                .selectedDaySlots
                                .isEmpty)
                              Text('No slots available',
                                  style: AppTextStyles.poppinsGrey(
                                      14, FontWeight.w400)),
                            VisitHours(
                              times: context
                                  .watch<AppointenentSchedualCubit>()
                                  .selectedDaySlots,
                              onTimeSelected: (selectedTime) {
                                context
                                    .read<AppointenentSchedualCubit>()
                                    .selectTime(selectedTime);
                              },
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
                  BlocListener<AppointenentSchedualCubit,
                      AppointenentSchedualState>(
                    listener: (context, state) {
                      if (state is AppointmentBookingSuccess) {
                        Navigator.pop(context);
                        HelperMethods.showCustomSnackBarSuccess(
                          context,
                          'Appointment booked successfully',
                        );
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.bookingPayment,
                          (route) => false,
                          arguments: doctorsModel,
                        );
                      } else if (state is AppointmentBookingError) {
                        HelperMethods.showCustomSnackBarError(
                            context, state.error);
                        log(state.error);
                      } else if (state is AppointmentBookingLoading) {
                        HelperMethods.showLoadingAlertDialog(context);
                      }
                    },
                    child: CustomButton(
                      buttonAction: () {
                        final cubit = context.read<AppointenentSchedualCubit>();
                        final selectedDay = cubit.selectedDay;
                        final selectedTime = cubit.selectedTime;

                        if (selectedDay == null || selectedTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please select date and time')),
                          );
                          return;
                        }

                        final id =
                            CacheHelper().getData(key: 'patient_Id').toString();

                        log(id.toString());

                        final Map<String, dynamic> appointmentData = {
                          "doctor_id": doctorsModel.id,
                          "patient_id": id,
                          "appointment_date": selectedDay,
                          "appointment_time": selectedTime,
                        };

                        log('appointment_time : $selectedTime');

                        cubit.bookAppointment(
                          data: appointmentData,
                          path: "${AppConstants.baseRestUrl}appointments",
                        );
                      },
                      buttonText: 'Book Appointment',
                      borderRadius: 8,
                      height: 48.h,
                      textStyle:
                          AppTextStyles.poppinsWhite(14, FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
