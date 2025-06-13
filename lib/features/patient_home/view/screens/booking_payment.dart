import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';
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
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/chat/data/repos/create_conversition_repository.dart';
import 'package:heal_care/features/chat/data/repos/get_conversation_repo.dart';
import 'package:heal_care/features/chat/data/repos/send_message_in_conversation.dart';
import 'package:heal_care/features/chat/logic/cubit/chat_cubit.dart';
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

    // Validate patient ID before proceeding
    if (finalPatientId == null) {
      HelperMethods.showCustomSnackBarError(
          context, "Patient ID not found. Please log in again.");
      return;
    }

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

    // Function to handle payment failure
    Future<void> handlePaymentFailure() async {
      try {
        // Add payment record with failure status
        final paymentData = {
          "doctor": doctor.id,
          "patient": finalPatientId,
          "price": "200",
          "payment_status": "failure"
        };

        await appointmentCubit.addPayment(
            data: paymentData,
            path: "${AppConstants.baseRestUrl}rpc/add_payment_history");

        HelperMethods.showCustomSnackBarError(
            context, 'Payment failed. Please try again.');

        log("Payment failed and recorded");
      } catch (e) {
        log("Failed to record payment failure: $e");
        HelperMethods.showCustomSnackBarError(
            context, 'Payment failed and could not be recorded.');
      }
    }

    // Function to handle successful payment operations
    Future<void> handlePaymentSuccess() async {
      try {
        // Book the appointment
        await appointmentCubit.bookAppointment(
          data: appointmentData,
          path: "${AppConstants.baseRestUrl}appointments",
        );

        // Add payment record with success status
        final paymentData = {
          "doctor": doctor.id,
          "patient": finalPatientId,
          "price": "200",
          "payment_status": "success"
        };

        await appointmentCubit.addPayment(
            data: paymentData,
            path: "${AppConstants.baseRestUrl}rpc/add_payment_history");

        // Create a conversation between doctor and patient
        await context.read<ChatCubit>().createConversation(
              doctorId: doctor.id ?? '',
              patientId: finalPatientId,
            );

        // Navigate to success page
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.paymentSuccess,
            (route) => false,
            arguments: doctor,
          );

          HelperMethods.showCustomSnackBarSuccess(
              context, 'Payment successful!');
        }
      } catch (e) {
        log("Payment success handling error: $e");
        // If anything fails during success handling, record as failure
        await handlePaymentFailure();
      }
    }

    if (selectedMethod == PaymentMethodType.creditCard) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaymentView(
            onPaymentSuccess: () async {
              await handlePaymentSuccess();
            },
            onPaymentError: () async {
              await handlePaymentFailure();
            },
            price: 200,
          ),
        ),
      );
      return;
    }

    // InstaPay logic
    const instaPayUrl =
        "instapay://payment?amount=200&to=instapay@healcare.com";
    const fallbackUrl =
        "https://instapay.eg/pay?to=instapay@healcare.com&amount=200";
    final uri = Uri.parse(instaPayUrl);
    final fallbackUri = Uri.parse(fallbackUrl);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      }

      // For InstaPay, show confirmation dialog to verify payment success
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Payment Confirmation'),
          content: Text('Did you complete the InstaPay payment successfully?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await handlePaymentFailure();
              },
              child: Text('No, Failed'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await handlePaymentSuccess();
              },
              child: Text('Yes, Successful'),
            ),
          ],
        ),
      );
    } catch (e) {
      log("InstaPay launch error: $e");
      await handlePaymentFailure();
    }
  }

  @override
  Widget build(BuildContext context) {
    final doctor = widget.data['doctor'] as DoctorsModel;

    return BlocProvider(
      create: (context) => ChatCubit(
        DependencyInjection.getIt<CreateConversitionRepository>(),
        DependencyInjection.getIt<GetConversationRepo>(),
        DependencyInjection.getIt<SendMessageInConversation>(),
        context.read<DoctorsCubit>(),
        context.read<PatientsCubit>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomAppHeader(
                  horizSpace: MediaQuery.sizeOf(context).width < 400 ? 24 : 40,
                  canBack: true,
                  title: 'Booking Payment',
                ),
                verticalSpace(24),
                PaymentHeader(doctorsModel: doctor),
                verticalSpace(24),
                ScheduleDate(
                  appointmentDate: widget.data['appointment_date'],
                  appointmentTime: widget.data['appointment_time'],
                ),
                verticalSpace(24),
                PaymentMethod(
                  selectedMethod: selectedMethod,
                  onChanged: (method) {
                    setState(() {
                      selectedMethod = method;
                    });
                  },
                ),
                verticalSpace(24),
                SummarySection(),
                verticalSpace(24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: CustomButton(
                    buttonAction: makePayment,
                    buttonText: 'Pay Now',
                    borderRadius: 12.r,
                    textStyle: AppTextStyles.poppinsWhite(16, FontWeight.w500),
                    height: 48.h,
                  ),
                ),
                verticalSpace(24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
