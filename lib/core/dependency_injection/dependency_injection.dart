import 'package:get_it/get_it.dart';
import 'package:heal_care/core/networking/supabase_web_socket_services.dart';
import 'package:heal_care/features/auth/data/repos/patient_favourites_repo.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/chat/data/repos/create_conversition_repository.dart';
import 'package:heal_care/features/chat/logic/cubit/chat_cubit.dart';
import 'package:heal_care/features/doctor_booking/data/repos/doctor_booking_repositories.dart';
import 'package:heal_care/features/doctor_booking/logic/cubit/doctorbooking_cubit.dart';
import 'package:heal_care/features/doctor_booking/logic/tabbar_cubit/tabbar_cubit.dart';
import 'package:heal_care/features/notification/data/repos/notification_repository.dart';
import 'package:heal_care/features/notification/cubit/notification_cubit.dart';
import 'package:heal_care/features/patient_booking/data/repos/appointment_repositories.dart';
import 'package:heal_care/features/patient_booking/data/repos/rate_repositories.dart';
import 'package:heal_care/features/patient_home/data/repos/add_payment_repo.dart';
import 'package:heal_care/features/patient_home/data/repos/appointenent_schedual_repositorie.dart';
import 'package:heal_care/features/patient_home/data/repos/book_appointment_repository.dart';
import 'package:heal_care/features/patient_home/data/repos/payment_history_repo.dart';
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
    getIt.registerLazySingleton<PatientFavouritesRepo>(
        () => PatientFavouritesRepo(getIt<ApiServices>()));
    getIt.registerLazySingleton<PatientsRepo>(
        () => PatientsRepo(getIt<ApiServices>()));
    getIt.registerLazySingleton<AppointenentSchedualRepositorie>(() =>
        AppointenentSchedualRepositorie(apiServices: getIt<ApiServices>()));
    getIt.registerLazySingleton<BookAppointmentRepository>(
        () => BookAppointmentRepository(getIt<ApiServices>()));
    getIt.registerLazySingleton<AppointmentRepositories>(
        () => AppointmentRepositories(getIt<ApiServices>()));
    getIt.registerLazySingleton<AddPaymentRepo>(
        () => AddPaymentRepo(getIt<ApiServices>()));
    getIt.registerLazySingleton<RateRepositories>(
        () => RateRepositories(getIt<ApiServices>()));
    getIt.registerLazySingleton<DoctorBookingRepositories>(
        () => DoctorBookingRepositories(getIt<ApiServices>()));
    getIt.registerLazySingleton<NotificationRepository>(
        () => NotificationRepository(getIt<ApiServices>()));
    getIt.registerLazySingleton<PaymentHistoryRepo>(
        () => PaymentHistoryRepo(getIt<ApiServices>()));

    getIt.registerLazySingleton<CreateConversitionRepository>(
        () => CreateConversitionRepository(getIt<ApiServices>()));

    // Cubits
    getIt.registerLazySingleton<DoctorsCubit>(() => DoctorsCubit(
        doctorsRepo: getIt<DoctorsRepo>(),
        patientFavouritesRepo: getIt<PatientFavouritesRepo>()));
    getIt.registerLazySingleton<PatientsCubit>(
        () => PatientsCubit(patientsRepo: getIt<PatientsRepo>()));
    getIt.registerLazySingleton<TabbarCubit>(() => TabbarCubit());
    getIt.registerFactory<DoctorbookingCubit>(() => DoctorbookingCubit(
          getIt<DoctorBookingRepositories>(),
          getIt<PatientsCubit>(),
          getIt<PatientsRepo>(),
        ));
    getIt.registerLazySingleton<NotificationCubit>(
        () => NotificationCubit(getIt<NotificationRepository>()));
    getIt.registerLazySingleton<ChatCubit>(() => ChatCubit(
          getIt<CreateConversitionRepository>(),
          getIt<DoctorsCubit>(),
          getIt<PatientsCubit>(),
        ));
  }
}
