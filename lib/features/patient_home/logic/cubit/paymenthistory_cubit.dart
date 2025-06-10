import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/features/patient_home/data/models/payment_history_model.dart';
import 'package:heal_care/features/patient_home/data/repos/payment_history_repo.dart';

part 'paymenthistory_state.dart';

class PaymenthistoryCubit extends Cubit<PaymenthistoryState> {
  PaymenthistoryCubit(this.paymentHistoryRepo) : super(PaymenthistoryInitial());

  final PaymentHistoryRepo paymentHistoryRepo;

  Future<void> fetchPaymentHistory(String path, dynamic patientId) async {
    emit(PaymentHistoryLoading());
    final data = {
      "user_id": patientId,
    };

    final result = await paymentHistoryRepo.getPaymentHistory(path, data);
    result.fold(
      (error) => emit(PaymentHistoryError(error)),
      (paymentHistory) => emit(PaymentHistorySuccess(paymentHistory)),
    );
  }

}
