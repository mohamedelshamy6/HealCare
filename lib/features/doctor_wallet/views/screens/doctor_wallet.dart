import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:heal_care/core/dependency_injection/dependency_injection.dart';
import 'package:heal_care/core/helpers/app_constants.dart';
import 'package:heal_care/core/helpers/cache_helper.dart';
import 'package:heal_care/features/auth/data/repos/patients_repo.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/doctor_wallet/views/widgets/payment_history_shimmer.dart';
import 'package:heal_care/features/patient_home/data/repos/payment_history_repo.dart';
import 'package:heal_care/features/patient_home/logic/cubit/paymenthistory_cubit.dart';
import '../../../../core/helpers/app_images.dart';
import '../../../../core/helpers/spacing.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/wallet_item.dart';

class DoctorWallet extends StatelessWidget {
  const DoctorWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymenthistoryCubit(
        DependencyInjection.getIt<PaymentHistoryRepo>(),
        DependencyInjection.getIt<PatientsRepo>(),
      )..fetchPaymentHistory(
          '${AppConstants.baseRestUrl}rpc/get_payment_history',
          CacheHelper().getData(key: 'doctor_Id') ??
              CacheHelper().getData(key: 'userId') ??
              'No Id for Doctor',
        ),
      child: BlocListener<PatientsCubit, PatientsState>(
        listener: (context, state) {
          if (state is PatientsSuccess) {
            context.read<PaymenthistoryCubit>().fetchPaymentHistory(
                  '${AppConstants.baseRestUrl}rpc/get_payment_history',
                  CacheHelper().getData(key: 'doctor_Id') ??
                      CacheHelper().getData(key: 'userId') ??
                      'No Id for Doctor',
                );
          }
        },
        child: BlocBuilder<PaymenthistoryCubit, PaymenthistoryState>(
          builder: (context, state) {
            if (state is PaymentHistoryLoading) {
              return PaymentHistoryForDoctorShimmer();
            } else if (state is PaymentHistoryError) {
              return Center(
                child: Text(
                  'Error: ${state.error}',
                  style: AppTextStyles.poppinsGrey(16, FontWeight.w500),
                ),
              );
            } else if (state is PaymentHistorySuccess) {
              double totalBalance = 0.0;
              for (var payment in state.paymentHistory) {
                if (payment.status == 'success' && payment.price != null) {
                  totalBalance += double.tryParse(payment.price!) ?? 0.0;
                }
              }

              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 48.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(Assets.imagesWalletFrame),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Wallet Balance',
                          style:
                              AppTextStyles.poppinsWhite(16, FontWeight.w600),
                        ),
                        verticalSpace(8),
                        Text(
                          '${totalBalance.toStringAsFixed(2)} EGP',
                          style:
                              AppTextStyles.poppinsWhite(40, FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(18),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Recently Transactions',
                          style:
                              AppTextStyles.poppinsBlack(16, FontWeight.w700),
                        ),
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: SvgPicture.asset(
                                  Assets.iconsFilterIconWhite)),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(8),
                  Expanded(
                    child: state.paymentHistory.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: 64,
                                  color: Colors.grey,
                                ),
                                verticalSpace(16),
                                Text(
                                  'No transactions yet',
                                  style: AppTextStyles.poppinsGrey(
                                      16, FontWeight.w500),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            itemCount: state.paymentHistory.length,
                            itemBuilder: (context, index) {
                              final payment = state.paymentHistory[index];
                              return WalletItem(
                                patientName:
                                    payment.patient_name ?? 'Unknown Patient',
                                price: '${payment.price ?? '0'} EGP',
                                time: _formatTime(payment.createdAt ?? ''),
                                status: payment.status ?? 'unknown',
                              );
                            }),
                  )
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  String _formatTime(String dateString) {
    try {
      final DateTime date = DateTime.parse(dateString);
      final int hour = date.hour;
      final int minute = date.minute;
      final String period = hour >= 12 ? 'PM' : 'AM';
      final int displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

      return '${displayHour}:${minute.toString().padLeft(2, '0')} $period';
    } catch (e) {
      return 'Unknown time';
    }
  }
}
