part of 'paymenthistory_cubit.dart';

sealed class PaymenthistoryState {}

final class PaymenthistoryInitial extends PaymenthistoryState {}

final class PaymentHistoryLoading extends PaymenthistoryState {}

final class PaymentHistorySuccess extends PaymenthistoryState {
  final List<PaymentsHistoryModel> paymentHistory;

  PaymentHistorySuccess(this.paymentHistory);
}

final class PaymentHistoryError extends PaymenthistoryState {
  final String error;

  PaymentHistoryError(this.error);
}
