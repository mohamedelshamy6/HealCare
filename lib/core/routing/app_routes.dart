import 'package:flutter/material.dart';
import 'package:heal_care/features/auth/view/screens/sign_up_screen.dart';
import 'package:heal_care/features/reset_password/view/screens/forget_password.dart';
import 'package:heal_care/features/reset_password/view/screens/reset_password.dart';
import 'package:heal_care/features/reset_password/view/screens/verification_code_screen.dart';
import '../../features/auth/view/screens/doctor_continue_signup.dart';
import '../../features/auth/view/screens/patient_continue_signup.dart';
import '../../features/auth/view/screens/sign_up_screen.dart';
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

      case Routes.patientContinueSignUpScreen:
        return MaterialPageRoute(
          builder: (context) => PatientContinueSignupScreen(),
        );
      case Routes.doctorContinueSignUpScreen:
        return MaterialPageRoute(
          builder: (context) => DoctorContinueSignupScreen(),
        );
    }
    return null;
  }
}
