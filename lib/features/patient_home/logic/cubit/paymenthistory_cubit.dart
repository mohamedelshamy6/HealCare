import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/features/auth/data/models/patients_model.dart';
import 'package:heal_care/features/auth/data/repos/patients_repo.dart';
import 'package:heal_care/features/patient_home/data/models/payment_history_model.dart';
import 'package:heal_care/features/patient_home/data/repos/payment_history_repo.dart';

part 'paymenthistory_state.dart';

class PaymenthistoryCubit extends Cubit<PaymenthistoryState> {
  PaymenthistoryCubit(this.paymentHistoryRepo, this.patientsRepo)
      : super(PaymenthistoryInitial());

  final PaymentHistoryRepo paymentHistoryRepo;
  final PatientsRepo patientsRepo;
  List<PatientsModel> patients = [];

  Future<void> fetchPaymentHistory(String path, dynamic userId) async {
    emit(PaymentHistoryLoading());
    final data = {
      "user_id": userId,
    };

    final result = await paymentHistoryRepo.getPaymentHistory(path, data);
    result.fold(
      (error) => emit(PaymentHistoryError(error)),
      (paymentHistory) => emit(PaymentHistorySuccess(paymentHistory)),
    );
  }
}
