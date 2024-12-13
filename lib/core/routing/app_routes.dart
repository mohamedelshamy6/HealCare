import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/bottom_navigation_bar/logic/bottom_navigation_bar_cubit.dart';
import '../../features/bottom_navigation_bar/view/screens/custom_bottom_navigation_bar.dart';
import '../../features/doctor_home/logic/tabbar_cubit/tabbar_cubit.dart';
import '../../features/patient_home/view/screens/all_doctors.dart';
import '../../features/auth/view/screens/sign_up_screen.dart';
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
    }
    return null;
  }
}
