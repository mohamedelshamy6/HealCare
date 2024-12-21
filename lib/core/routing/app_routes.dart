import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heal_care/features/chat/views/screens/inside_chat_screen.dart';
import 'package:heal_care/features/doctor_booking/data/models/all_booking_model.dart';
import 'package:heal_care/features/doctor_details/views/screens/details_screen.dart';
import 'package:heal_care/features/patient_home/view/screens/book_doctor_appointment.dart';
import 'package:heal_care/features/patient_home/view/screens/payment_success.dart';
import '../../features/auth/view/screens/doctor_continue_signup.dart';
import '../../features/auth/view/screens/patient_continue_signup.dart';
import '../../features/notification/views/screens/notifications_screen.dart';
import '../../features/patient_favorite/views/screens/patient_favorites_screen.dart';
import '../../features/bottom_navigation_bar/logic/bottom_navigation_bar_cubit.dart';
import '../../features/bottom_navigation_bar/view/screens/custom_bottom_navigation_bar.dart';
import '../../features/doctor_booking/logic/tabbar_cubit/tabbar_cubit.dart';
import '../../features/patient_home/data/models/doctors_model.dart';
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
          builder: (context) => LoginScreen(type: args as String),
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
          builder: (context) => AllDoctorsScreen(),
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
            ],
            child: CustomBottomNavigationBar(type: args as String),
          ),
        );
      case Routes.bookDoctorAppointment:
        return MaterialPageRoute(
          builder: (context) => BookDoctorAppointment(
            doctorsModel: args as DoctorsModel,
          ),
        );
      case Routes.bookingPayment:
        return MaterialPageRoute(
          builder: (context) => BookingPayment(
            doctorsModel: args as DoctorsModel,
          ),
        );
      case Routes.paymentSuccess:
        return MaterialPageRoute(
          builder: (context) => PaymentSuccess(
            doctorsModel: args as DoctorsModel,
          ),
        );
      case Routes.notificationsScreen:
        return MaterialPageRoute(
          builder: (context) => NotificationsScreen(),
        );
      case Routes.patientFavoriteScreen:
        return MaterialPageRoute(
          builder: (context) => PatientFavoritesScreen(),
        );
      case Routes.doctorContinueSignUpScreen:
        return MaterialPageRoute(
          builder: (context) => DoctorContinueSignupScreen(),
        );
      case Routes.patientContinueSignUpScreen:
        return MaterialPageRoute(
          builder: (context) => PatientContinueSignupScreen(),
        );
      case Routes.insideChat:
        return MaterialPageRoute(
          builder: (context) => InsideChatScreen(),
        );
    case Routes.detailsScreen:
  return MaterialPageRoute(
    builder: (context) {
      final arg = routeSettings.arguments as Map<String, dynamic>; // Cast to Map
      return DetailsScreen(
        allBookingModel: arg['allBookingModel'] as AllBookingModel, // Access model
        selectedIndex: arg['selectedIndex'] as int, // Access index
      );
    },
  );
    }
    return null;
  }
}
