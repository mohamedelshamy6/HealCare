import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/features/patient_booking/data/repos/rate_repositories.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  RateCubit(this.rateRepositories) : super(RateInitial());
  final RateRepositories rateRepositories;

  Future<void> rateDoctor({
    required String path,
    required dynamic body,
  }) async {
    emit(RateLoading());
    final result = await rateRepositories.rateDoctor(path: path, body: body);
    result.fold(
      (error) => emit(RateError(error)),
      (_) => emit(RateSuccess()),
    );
  }
}