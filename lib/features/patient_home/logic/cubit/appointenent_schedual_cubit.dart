

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/features/patient_home/data/models/appointement_schedual_model.dart';
import 'package:heal_care/features/patient_home/data/repos/appointenent_schedual_repositorie.dart';

part 'appointenent_schedual_state.dart';

class AppointenentSchedualCubit extends Cubit<AppointenentSchedualState> {
  AppointenentSchedualCubit() : super(AppointenentSchedualInitial());
}
