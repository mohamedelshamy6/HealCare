import 'package:get_it/get_it.dart';
import 'package:heal_care/core/networking/supabase_web_socket_services.dart';
import 'package:heal_care/features/patient_booking/data/repos/appointment_repositories.dart';
import 'package:heal_care/features/patient_booking/data/repos/rate_repositories.dart';
import 'package:heal_care/features/patient_home/data/repos/appointenent_schedual_repositorie.dart';
import 'package:heal_care/features/patient_home/data/repos/book_appointment_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/auth/data/repos/doctors_repo.dart';
import '../../features/auth/data/repos/login_repo.dart';
import '../../features/auth/data/repos/patients_repo.dart';
import '../../features/auth/data/repos/signup_repo.dart';
import '../networking/api_services.dart';
import '../networking/dio_handler.dart';

class DependencyInjection {
  static final getIt = GetIt.instance;

  Future<void> setupGetIt() async {
    // Dio & ApiService
    getIt.registerLazySingleton<ApiServices>(() => DioHandler());
    getIt.registerLazySingleton<SupabaseClient>(() => SupabaseClient(
          'https://hftivyxotfavjvrukbts.supabase.co',
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhmdGl2eXhvdGZhdmp2cnVrYnRzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI5NDEwNDIsImV4cCI6MjA0ODUxNzA0Mn0.lV9hHj2M12KpWO1mINsfmw-uOH43ki99pTp16Xk23XQ',
        ));
    getIt.registerLazySingleton<SupabaseWebSocketService>(
        () => SupabaseWebSocketService(getIt<SupabaseClient>()));

    // Repositories
    getIt.registerLazySingleton<LoginRepo>(
        () => LoginRepo(getIt<ApiServices>()));
    getIt.registerLazySingleton<SignUpRepo>(
        () => SignUpRepo(getIt<ApiServices>()));
    getIt.registerLazySingleton<DoctorsRepo>(
        () => DoctorsRepo(getIt<ApiServices>()));
    getIt.registerLazySingleton<PatientsRepo>(
        () => PatientsRepo(getIt<ApiServices>()));
    getIt.registerLazySingleton<AppointenentSchedualRepositorie>(() =>
        AppointenentSchedualRepositorie(apiServices: getIt<ApiServices>()));
    getIt.registerLazySingleton<BookAppointmentRepository>(
        () => BookAppointmentRepository(getIt<ApiServices>()));
    getIt.registerLazySingleton<AppointmentRepositories>(
        () => AppointmentRepositories(getIt<ApiServices>()));
    getIt.registerLazySingleton<RateRepositories>(
        () => RateRepositories(getIt<ApiServices>()));
  }
}
