import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/core/helpers/helper_methods.dart';
import 'package:heal_care/features/auth/data/repos/patients_repo.dart';
import 'package:heal_care/features/patient_home/data/repos/payment_history_repo.dart';
import 'package:heal_care/features/patient_home/logic/cubit/paymenthistory_cubit.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_app_header.dart';
import '../../../../core/helpers/app_images.dart';

class EWalletHistory extends StatelessWidget {
  const EWalletHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymenthistoryCubit(
        DependencyInjection.getIt<PaymentHistoryRepo>(),
        DependencyInjection.getIt<PatientsRepo>(),
      )..fetchPaymentHistory(
          '${AppConstants.baseRestUrl}rpc/get_payment_history',
          CacheHelper().getData(key: 'patient_Id') ??
              CacheHelper().getData(key: 'userId') ??
              'No Id for Patient',
        ),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAppHeader(
                    canBack: true,
                    title: 'Payment History',
                    horizSpace:
                        MediaQuery.sizeOf(context).width < 400 ? 28 : 42,
                  ),
                  verticalSpace(20),
                  BlocBuilder<PaymenthistoryCubit, PaymenthistoryState>(
                    builder: (context, state) {
                      if (state is PaymentHistoryLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is PaymentHistorySuccess) {
                        if (state.paymentHistory.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  Assets.iconsPayMoneyIconBlue,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                                verticalSpace(16),
                                Text(
                                  'No payment history found',
                                  style: AppTextStyles.poppinsGrey(
                                      16, FontWeight.w500),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final payment = state.paymentHistory[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(12.r),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Assets.iconsPayMoneyIconBlue,
                                    width: 20.w,
                                    height: 20.h,
                                  ),
                                  horizontalSpace(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rental Income',
                                          style: AppTextStyles.poppinsBlack(
                                              14, FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        verticalSpace(4),
                                        Text(
                                          HelperMethods.formatDate(payment.createdAt),
                                          style: AppTextStyles.poppinsGrey(
                                              12, FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  horizontalSpace(8),
                                  Text(
                                    '${payment.price ?? 0} EGP',
                                    style: AppTextStyles.poppinsBlack(
                                            14, FontWeight.w500)
                                        .copyWith(
                                      color: payment.status == 'success'
                                          ? Color(0xff50c474)
                                          : Color(0xffff4757),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8.h),
                          itemCount: state.paymentHistory.length,
                        );
                      } else if (state is PaymentHistoryError) {
                        return Center(
                          child: Text(
                            " ${state.error}",
                            style:
                                AppTextStyles.poppinsGrey(16, FontWeight.w400),
                          ),
                        );
                      }

                      return Center(
                        child: Text(
                          'Loading payment history...',
                          style: AppTextStyles.poppinsGrey(16, FontWeight.w400),
                        ),
                      );
                    },
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
