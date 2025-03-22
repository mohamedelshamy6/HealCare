part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoginSuccess extends AuthState {
  final LoginModel? loginModel;
  LoginSuccess({this.loginModel});
}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final String? error;
  LoginFailure({this.error});
}

final class GoogleLoginSuccess extends AuthState {
  final LoginModel? loginModel;
  GoogleLoginSuccess({this.loginModel});
}

final class GoogleLoginLoading extends AuthState {}

final class GoogleLoginFailure extends AuthState {
  final String? error;
  GoogleLoginFailure({this.error});
}

final class SignUpSuccess extends AuthState {
  final SignUpModel? signUpModel;
  SignUpSuccess({this.signUpModel});
}

final class SignUpLoading extends AuthState {}

final class SignUpFailure extends AuthState {
  final String? error;
  SignUpFailure({this.error});
}
