import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/core/networking/supabase_web_socket_services.dart';
import 'package:heal_care/features/auth/data/models/doctors_model.dart';
import 'package:heal_care/features/auth/data/repos/patients_repo.dart';
import 'package:heal_care/features/auth/logic/cubit/auth_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/doctors_cubit.dart';
import 'package:heal_care/features/auth/logic/cubit/patients_cubit.dart';
import 'package:heal_care/features/chat/data/models/get_conversations_model.dart';
import 'package:heal_care/features/chat/data/repos/create_conversition_repository.dart';
import 'package:heal_care/features/chat/data/repos/get_all_messages_for_aspecific_conversation_repo.dart';
import 'package:heal_care/features/chat/data/repos/get_conversation_repo.dart';
import 'package:heal_care/features/chat/data/repos/send_message_in_conversation.dart';
import 'package:heal_care/features/chat/logic/cubit/chat_cubit.dart';
import 'package:heal_care/features/chat/views/screens/doctor_chat.dart';
import 'package:heal_care/features/chat/views/screens/patient_chat.dart';
import 'package:heal_care/features/doctor_booking/data/models/doctor_booking_model.dart';
import 'package:heal_care/features/doctor_booking/data/repos/cancel_appointment_model.dart';
import 'package:heal_care/features/doctor_booking/logic/cubit/doctorbooking_cubit.dart';
import 'package:heal_care/features/doctor_booking/views/screens/doctor_booking.dart';
import 'package:heal_care/features/doctor_profile/views/screens/doctor_profile.dart';
import 'package:heal_care/features/notification/cubit/notification_cubit.dart';
import 'package:heal_care/features/notification/data/repos/notification_repository.dart';
import 'package:heal_care/features/notification/views/screens/notifications_patients_screen.dart';
import 'package:heal_care/features/patient_booking/logic/cubit/appointementcubit_cubit.dart';
import 'package:heal_care/features/patient_booking/views/screens/patient_booking_screen.dart';
import 'package:heal_care/features/patient_home/data/repos/add_payment_repo.dart';
import 'package:heal_care/features/patient_home/data/repos/appointenent_schedual_repositorie.dart';
import 'package:heal_care/features/patient_home/data/repos/book_appointment_repository.dart';
import 'package:heal_care/features/patient_home/logic/cubit/appointenent_schedual_cubit.dart';
import 'package:heal_care/features/patient_profile/views/screens/patient_profile.dart';
import 'package:heal_care/features/patient_profile/logic/profile_cubit.dart';
import '../../features/doctor_profile/views/screens/doctor_edit_profile.dart';
import '../../features/chat/views/screens/chat_bot.dart';
import '../../features/patient_profile/views/screens/patient_edit_profile.dart';
import '../../features/chat/views/screens/inside_chat_screen.dart';
import '../../features/doctor_details/views/screens/details_screen.dart';
import '../../features/patient_home/view/screens/book_doctor_appointment.dart';
import '../../features/patient_home/view/screens/payment_success.dart';
import '../../features/auth/view/screens/doctor_continue_signup.dart';
import '../../features/auth/view/screens/patient_continue_signup.dart';
import '../../features/notification/views/screens/notifications_doctor_screen.dart';
import '../../features/patient_favorite/views/screens/patient_favorites_screen.dart';
import '../../features/patient_home/view/screens/e_wallet_history.dart';
import '../../features/bottom_navigation_bar/logic/bottom_navigation_bar_cubit.dart';
import '../../features/bottom_navigation_bar/view/screens/custom_bottom_navigation_bar.dart';
import '../../features/doctor_booking/logic/tabbar_cubit/tabbar_cubit.dart';
import '../../features/patient_home/view/screens/all_doctors.dart';
import '../../features/auth/view/screens/sign_up_screen.dart';
import '../../features/patient_home/view/screens/booking_payment.dart';
import '../../features/reset_password/view/screens/forget_password.dart';
import '../../features/reset_password/view/screens/reset_password.dart';
import '../../features/reset_password/view/screens/verification_code_screen.dart';
import '../../features/patient_home/view/screens/patient_home_screen.dart';
import '../../features/auth/view/screens/choose_screen.dart';
import '../../features/auth/view/screens/login_screen.dart';
import '../../features/splash/view/screens/splash.dart';
import '../dependency_injection/dependency_injection.dart';
import 'routes.dart';

class CustomPageRoute extends MaterialPageRoute {
  CustomPageRoute({required super.builder});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 750);
}

class AppRoutes {
  //* Generates a route based on the route name.
  Route? generateRoute(RouteSettings routeSettings) {
    var args = routeSettings.arguments;
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.choose:
        return MaterialPageRoute(
          builder: (context) => const ChooseScreen(),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              DependencyInjection.getIt(),
              DependencyInjection.getIt(),
              DependencyInjection.getIt(),
            ),
            child: LoginScreen(type: args as String),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(type: args as String),
        );
      case Routes.forgetPassword:
        return MaterialPageRoute(
          builder: (context) => const ForgetPasswordScreen(),
        );
      case Routes.codeVerification:
        return MaterialPageRoute(
          builder: (context) => const VerificationCodeScreen(),
        );
      case Routes.setNewPassword:
        return MaterialPageRoute(
          builder: (context) => const ResetPassword(),
        );
      case Routes.patientHome:
        return MaterialPageRoute(
          builder: (context) => PatientHomeScreen(),
        );
      case Routes.allDoctorsScreen:
        return MaterialPageRoute(
          builder: (context) => AllDoctorsScreen(
            doctorsModel: args as List<DoctorsModel>,
          ),
        );

      case Routes.bottomNavBar:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<BottomNavigationBarCubit>(
                create: (context) => BottomNavigationBarCubit(),
              ),
              BlocProvider<TabbarCubit>(
                create: (context) => TabbarCubit(),
              ),
              BlocProvider(
                create: (context) => DoctorsCubit(
                  toogleFavouritesRepo: DependencyInjection.getIt(),
                  doctorsRepo: DependencyInjection.getIt(),
                  patientFavouritesRepo: DependencyInjection.getIt(),
                )..getAllDoctors(),
              ),
              BlocProvider(
                create: (context) => AppointementcubitCubit(
                  DependencyInjection.getIt(),
                  context.read<DoctorsCubit>(),
                  context.read<PatientsCubit>(),
                )..fetchAppointments(),
              ),
              BlocProvider(
                create: (context) => PatientsCubit(
                  patientsRepo: DependencyInjection.getIt(),
                ),
              ),
              BlocProvider(
                create: (context) => NotificationCubit(
                  DependencyInjection.getIt<NotificationRepository>(),
                ),
              ),
              BlocProvider(
                create: (context) => DoctorbookingCubit(
                  DependencyInjection.getIt(),
                  context.read<PatientsCubit>(),
                  DependencyInjection.getIt<PatientsRepo>(),
                  DependencyInjection.getIt<CancelAppointmentRepo>(),
                ),
              ),
              BlocProvider<ProfileCubit>(
                create: (context) => ProfileCubit(
                  DependencyInjection.getIt(),
                  DependencyInjection.getIt(),
                ),
              ),
              BlocProvider(
                create: (context) => ChatCubit(
                  DependencyInjection.getIt<CreateConversitionRepository>(),
                  DependencyInjection.getIt<GetConversationRepo>(),
                  DependencyInjection.getIt<
                      GetAllMessagesForAspecificConversationRepo>(),
                  DependencyInjection.getIt<SendMessageInConversation>(),
                  DependencyInjection.getIt<DoctorsCubit>(),
                  DependencyInjection.getIt<PatientsCubit>(),
                  DependencyInjection.getIt<SupabaseWebSocketService>(),
                ),
              ),
            ],
            child: CustomBottomNavigationBar(type: args as String),
          ),
        );
      case Routes.bookDoctorAppointment:
        return MaterialPageRoute(
          builder: (context) => BookDoctorAppointment(
            doctorsModel: args as DoctorsModel? ?? DoctorsModel(),
          ),
        );

      case Routes.bookingPayment:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AppointenentSchedualCubit(
                    DependencyInjection.getIt<
                        AppointenentSchedualRepositorie>(),
                    DependencyInjection.getIt<BookAppointmentRepository>(),
                    DependencyInjection.getIt<AddPaymentRepo>()),
              ),
              BlocProvider(
                create: (context) => ChatCubit(
                  DependencyInjection.getIt<CreateConversitionRepository>(),
                  DependencyInjection.getIt<GetConversationRepo>(),
                  DependencyInjection.getIt<
                      GetAllMessagesForAspecificConversationRepo>(),
                  DependencyInjection.getIt<SendMessageInConversation>(),
                  DependencyInjection.getIt<DoctorsCubit>(),
                  DependencyInjection.getIt<PatientsCubit>(),
                  DependencyInjection.getIt<SupabaseWebSocketService>(),
                ),
              ),
            ],
            child: BookingPayment(
              data: args as Map<String, dynamic>,
            ),
          ),
        );
      case Routes.paymentSuccess:
        return MaterialPageRoute(
          builder: (context) => PaymentSuccess(
            doctorsModel: args as DoctorsModel,
          ),
        );
      case Routes.notificationsDoctorScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<DoctorsCubit>(
                create: (context) => DoctorsCubit(
                  toogleFavouritesRepo: DependencyInjection.getIt(),
                  doctorsRepo: DependencyInjection.getIt(),
                  patientFavouritesRepo: DependencyInjection.getIt(),
                ),
              ),
              BlocProvider<NotificationCubit>(
                create: (context) => NotificationCubit(
                  DependencyInjection.getIt(),
                ),
              ),
            ],
            child: NotificationsDoctorScreen(),
          ),
        );
      case Routes.notificationsPatientScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PatientsCubit>(
            create: (context) => PatientsCubit(
              patientsRepo: DependencyInjection.getIt(),
            ),
            child: NotificationsPatientsScreen(
              type: args as String,
            ),
          ),
        );
      case Routes.patientFavoriteScreen:
        return MaterialPageRoute(
          builder: (context) => PatientFavoritesScreen(),
        );
      case Routes.doctorBooking:
        return MaterialPageRoute(
          builder: (context) => DoctorBooking(),
        );
      case Routes.doctorContinueSignUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(DependencyInjection.getIt(),
                DependencyInjection.getIt(), DependencyInjection.getIt()),
            child: DoctorContinueSignupScreen(
              email: (args as List<String>)[0],
              password: (args)[1],
              name: (args)[2],
            ),
          ),
        );
      case Routes.patientContinueSignUpScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              DependencyInjection.getIt(),
              DependencyInjection.getIt(),
              DependencyInjection.getIt(),
            ),
            child: PatientContinueSignupScreen(
              email: (args as List<String>)[0],
              password: (args)[1],
              name: (args)[2],
            ),
          ),
        );
      case Routes.insideChat:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: context.read<ChatCubit>(),
            child: InsideChatScreen(
              chatIndex: (args as List)[0] as String,
              model: args[1] == 'patient'
                  ? args[2] as DoctorsModel
                  : args[2] as GetConversationsModel,
            ),
          ),
        );
      case Routes.patientProfile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProfileCubit(
              DependencyInjection.getIt(),
              DependencyInjection.getIt(),
            ),
            child: PatientProfile(),
          ),
        );
      case Routes.doctorProfile:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ProfileCubit(
              DependencyInjection.getIt(),
              DependencyInjection.getIt(),
            ),
            child: DoctorProfile(),
          ),
        );
      case Routes.detailsScreen:
        return MaterialPageRoute(
          builder: (context) {
            final arg = routeSettings.arguments as Map<String, dynamic>;
            return DetailsScreen(
              doctorBookingModel:
                  arg['doctorBookingModel'] as DoctorBookingModel,
              selectedIndex: arg['selectedIndex'] as int,
            );
          },
        );
      case Routes.patientEditProfile:
        return MaterialPageRoute(
          builder: (context) => PatientEditProfile(),
        );
      case Routes.eWalletHistory:
        return MaterialPageRoute(
          builder: (context) => EWalletHistory(),
        );
      case Routes.doctorEditProfile:
        return MaterialPageRoute(
          builder: (context) => DoctorEditProfile(),
        );
      case Routes.chatBot:
        return MaterialPageRoute(
          builder: (context) => ChatBotScreen(
            chatIndex: args as String,
            model: args as dynamic,
          ),
        );
      case Routes.patientChat:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ChatCubit(
                  DependencyInjection.getIt<CreateConversitionRepository>(),
                  DependencyInjection.getIt<GetConversationRepo>(),
                  DependencyInjection.getIt<
                      GetAllMessagesForAspecificConversationRepo>(),
                  DependencyInjection.getIt<SendMessageInConversation>(),
                  DependencyInjection.getIt<DoctorsCubit>(),
                  DependencyInjection.getIt<PatientsCubit>(),
                  DependencyInjection.getIt<SupabaseWebSocketService>(),
                ),
              ),
            ],
            child: PatientChat(type: args as String),
          ),
        );
      case Routes.doctorChat:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ChatCubit(
                  DependencyInjection.getIt<CreateConversitionRepository>(),
                  DependencyInjection.getIt<GetConversationRepo>(),
                  DependencyInjection.getIt<
                      GetAllMessagesForAspecificConversationRepo>(),
                  DependencyInjection.getIt<SendMessageInConversation>(),
                  DependencyInjection.getIt<DoctorsCubit>(),
                  DependencyInjection.getIt<PatientsCubit>(),
                  DependencyInjection.getIt<SupabaseWebSocketService>(),
                ),
              ),
            ],
            child: DoctorChat(type: args as String),
          ),
        );
      case Routes.patientBookingScreen:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider<DoctorsCubit>(
                create: (context) => DoctorsCubit(
                  toogleFavouritesRepo: DependencyInjection.getIt(),
                  doctorsRepo: DependencyInjection.getIt(),
                  patientFavouritesRepo: DependencyInjection.getIt(),
                )..getAllDoctors(),
              ),
              BlocProvider<PatientsCubit>(
                create: (context) => PatientsCubit(
                  patientsRepo: DependencyInjection.getIt(),
                ),
              ),
            ],
            child: const PatientBookingScreen(),
          ),
        );
    }
    return null;
  }
}
