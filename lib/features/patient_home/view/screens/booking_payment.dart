import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/core/helpers/spacing.dart';
import 'package:heal_care/core/routing/routes.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/core/utils/payment_method_type.dart';
import 'package:heal_care/core/widgets/custom_app_header.dart';
import 'package:heal_care/core/widgets/custom_button.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/patient_home/logic/cubit/appointenent_schedual_cubit.dart';
import 'package:heal_care/features/patient_home/view/widgets/payment_header.dart';
import 'package:heal_care/features/patient_home/view/widgets/payment_method.dart';
import 'package:heal_care/features/patient_home/view/widgets/schedule_date.dart';
import 'package:heal_care/features/patient_home/view/widgets/summary_section.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingPayment extends StatefulWidget {
  final Map<String, dynamic> data;

  const BookingPayment({super.key, required this.data});

  @override
  State<BookingPayment> createState() => _BookingPaymentState();
}

class _BookingPaymentState extends State<BookingPayment> {
  PaymentMethodType? selectedMethod;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    PaymentData.initialize(
      apiKey: AppConstants.apiKey,
      iframeId: AppConstants.iFrameId,
      integrationCardId: AppConstants.onlineCardIdIntegrationId,
      integrationMobileWalletId: AppConstants.mobileWalletIntegrationId,
      userData: UserData(
        email: "userss@email.com",
        phone: "0123456789",
        name: "FirstName",
        lastName: "LastName",
      ),
      style: Style(
        primaryColor: AppColors.mainColor,
        scaffoldColor: Colors.white,
        appBarBackgroundColor: AppColors.mainColor,
        appBarForegroundColor: Colors.white,
      ),
    );
  }

  late AppointenentSchedualCubit appointmentCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appointmentCubit = context.read<AppointenentSchedualCubit>();
  }

  void makePayment() async {
    final DoctorsModel doctor = widget.data['doctor'];
    final String date = widget.data['appointment_date'];
    final String time = widget.data['appointment_time'];

    final String patientId =
        (CacheHelper().getData(key: 'patient_Id').toString());
    final String? userId = CacheHelper().getData(key: 'userId');

    String? patientIdCheck() {
      if (patientId.isNotEmpty && patientId != "null") {
        return patientId;
      } else if (userId != null && userId.isNotEmpty && userId != "null") {
        return userId;
      }
      return null;
    }

    final String? finalPatientId = patientIdCheck();

    final appointmentData = {
      "doctor_id": doctor.id,
      "patient_id": finalPatientId,
      "appointment_date": date,
      "appointment_time": time,
    };
    log("Appointment Data: $appointmentData");

    if (selectedMethod == null) {
      HelperMethods.showCustomSnackBarError(
          context, "Please select a payment method");
      return;
    }

    if (selectedMethod == PaymentMethodType.creditCard) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaymentView(
            onPaymentSuccess: () async {
              await appointmentCubit.bookAppointment(
                data: appointmentData,
                path: "${AppConstants.baseRestUrl}appointments",
              );

              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.paymentSuccess,
                (route) => false,
                arguments: doctor,
              );
              HelperMethods.showCustomSnackBarSuccess(
                  context, 'Payment successful!');
            },
            onPaymentError: () {
              HelperMethods.showCustomSnackBarError(
                  context, 'Payment failed. Please try again.');
            },
            price: 200,
          ),
        ),
      );
      return;
    }

    // InstaPay fallback logic
    const instaPayUrl =
        "instapay://payment?amount=200&to=instapay@healcare.com";
    const fallbackUrl =
        "https://instapay.eg/pay?to=instapay@healcare.com&amount=200";
    final uri = Uri.parse(instaPayUrl);
    final fallbackUri = Uri.parse(fallbackUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
    }

    // Proceed with booking the appointment after payment
    await appointmentCubit.bookAppointment(
      data: appointmentData,
      path: "${AppConstants.baseRestUrl}appointments",
    );

    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.paymentSuccess,
      (route) => false,
      arguments: doctor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.data['doctor'] as DoctorsModel;

    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.r),
        color: Colors.white,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total',
                    style: AppTextStyles.poppinsGrey(12, FontWeight.w500)),
                verticalSpace(8),
                Text('EGP 200',
                    style: AppTextStyles.poppinsBlack(16, FontWeight.w700)),
              ],
            ),
            const Spacer(),
            CustomButton(
              borderRadius: 8.r,
              height: 48.h,
              width: 164.w,
              buttonText: 'Pay',
              buttonAction: makePayment,
              textStyle: AppTextStyles.poppinsWhite(14, FontWeight.w700),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24.w, top: 16.h),
                child: CustomAppHeader(
                  canBack: true,
                  seenAll: false,
                  title: 'Payment',
                  horizSpace: MediaQuery.sizeOf(context).width < 400 ? 56 : 72,
                ),
              ),
              verticalSpace(8),
              PaymentHeader(doctorsModel: doctor),
              verticalSpace(8),
              ScheduleDate(
                appointmentDate:
                    HelperMethods.formatDate(widget.data['appointment_date']),
                appointmentTime:
                    HelperMethods.formatTime(widget.data['appointment_time']),
                onEdit: () {
                  Navigator.of(context).pushNamed(
                    Routes.bookDoctorAppointment,
                    arguments: doctor,
                  );
                },
              ),
              verticalSpace(12),
              PaymentMethod(
                selectedMethod: selectedMethod,
                onChanged: (method) {
                  setState(() => selectedMethod = method);
                },
              ),
              verticalSpace(8),
              SummarySection(),
              verticalSpace(16),
            ],
          ),
        ),
      ),
    );
  }
}
