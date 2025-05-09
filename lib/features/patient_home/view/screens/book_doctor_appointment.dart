import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/widgets/custom_date_picker.dart';
import '../../data/models/doctors_model.dart';

import '../../../../core/helpers/app_images.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/doctor_status_container.dart';
import '../widgets/visit_hours.dart';

class BookDoctorAppointment extends StatelessWidget {
  final DoctorsModel doctorsModel;
  const BookDoctorAppointment({
    super.key,
    required this.doctorsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              children: [
                CustomAppHeader(
                  horizSpace: MediaQuery.sizeOf(context).width < 400 ? 24 : 40,
                  canBack: true,
                  title: 'Book Appointment',
                ),
                verticalSpace(24),
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
                          image: AssetImage(doctorsModel.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 10.r,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: CircleAvatar(
                          radius: 6.r,
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(16),
                Text(
                  doctorsModel.name,
                  style: AppTextStyles.poppinsBlack(
                    20,
                    FontWeight.w500,
                  ),
                ),
                verticalSpace(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.iconsHeartRate,
                      width: 16.w,
                      height: 10.h,
                    ),
                    horizontalSpace(4),
                    Text(
                      doctorsModel.job.contains(' - ')
                          ? doctorsModel.job.split('-').first
                          : doctorsModel.job.split('|').first,
                      style: AppTextStyles.poppinsGrey(
                        12,
                        FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                verticalSpace(20),
                DoctorStatusContainer(),
                verticalSpace(32),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'About Doctor',
                    style: AppTextStyles.poppinsBlack(16, FontWeight.w600),
                  ),
                ),
                verticalSpace(8),
                Text(
                  '${doctorsModel.name} is the top most Cardiologist specialist in Nanyang Hospotalat London. She is available for private consultation.',
                  style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
                ),
                verticalSpace(24),
                Row(
                  children: [
                    Text(
                      'Schedules',
                      style: AppTextStyles.poppinsBlack(16, FontWeight.w600),
                    ),
                    Spacer(),
                    Text(
                      'August',
                      style: AppTextStyles.poppinsGrey(12, FontWeight.w500),
                    ),
                    horizontalSpace(4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12.r,
                    ),
                  ],
                ),
                verticalSpace(24),
                CustomDatePicker(),
                verticalSpace(24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Visit Hour',
                    style: AppTextStyles.poppinsBlack(16, FontWeight.w600),
                  ),
                ),
                verticalSpace(18),
                VisitHours(),
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
