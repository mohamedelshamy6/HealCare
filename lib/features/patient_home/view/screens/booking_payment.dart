import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/patient_home/view/widgets/summary_section.dart';
import 'package:pay_with_paymob/pay_with_paymob.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../widgets/payment_header.dart';
import '../widgets/payment_method.dart';
import '../widgets/schedule_date.dart';
import 'package:heal_care/core/utils/payment_method_type.dart';

class BookingPayment extends StatefulWidget {
  final DoctorsModel doctorsModel;

  const BookingPayment({super.key, required this.doctorsModel});

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

  void makePayment() async {
    if (selectedMethod == null) {
      HelperMethods.showCustomSnackBarError(
        context,
        "Please select a payment method",
      );
      return;
    }

    if (selectedMethod == PaymentMethodType.creditCard) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PaymentView(
            onPaymentSuccess: () {
              log('Payment successful!');
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.paymentSuccess,
                (route) => false,
                arguments: widget.doctorsModel,
              );
              HelperMethods.showCustomSnackBarSuccess(
                context,
                'Payment successful!',
              );
            },
            onPaymentError: () {
              log('Payment error!');
              HelperMethods.showCustomSnackBarError(
                context,
                'Payment failed. Please try again.',
              );
            },
            price: 200,
          ),
        ),
      );
      return;
    }

    if (selectedMethod == PaymentMethodType.instaPay) {
      const String instaPayUrl =
          "instapay://payment?amount=200&to=instapay@healcare.com";
      const String fallbackUrl =
          "https://instapay.eg/pay?to=instapay@healcare.com&amount=200";

      final Uri uri = Uri.parse(instaPayUrl);
      final Uri fallbackUri = Uri.parse(fallbackUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      }
      return;
    }

    setState(() => isLoading = true);
    HelperMethods.showLoadingAlertDialog(context);

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.of(context).pop();
      setState(() => isLoading = false);

      Navigator.of(context).pushNamedAndRemoveUntil(
        Routes.paymentSuccess,
        (route) => false,
        arguments: widget.doctorsModel,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Text('USD 200',
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
              PaymentHeader(doctorsModel: widget.doctorsModel),
              verticalSpace(8),
              ScheduleDate(),
              verticalSpace(12),
              PaymentMethod(
                selectedMethod: selectedMethod,
                onChanged: (method) {
                  setState(() {
                    selectedMethod = method;
                  });
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
