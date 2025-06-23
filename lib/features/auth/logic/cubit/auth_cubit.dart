import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../data/models/login_model.dart';
import '../../data/models/sign_up_model.dart';
import '../../data/repos/login_repo.dart';
import '../../data/repos/signup_repo.dart';
import '../../data/repos/doctor_availability_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.loginRepo, this.signUpRepo, this.doctorAvailabilityRepo)
      : super(AuthInitial());
  late LoginRepo loginRepo;
  late SignUpRepo signUpRepo;
  late DoctorAvailabilityRepo doctorAvailabilityRepo;

  Future<void> login(String path, dynamic data) async {
    emit(LoginLoading());
    final loginModel = await loginRepo.login(
      path,
      data,
    );
    loginModel.fold((error) {
      emit(LoginFailure(error: error));
    }, (loginModel) {
      emit(LoginSuccess(loginModel: loginModel));
    });
  }
  // Future<void> googleLogin(String path, dynamic data) async {
  //   emit(GoogleLoginLoading());
  //   final loginModel = await loginRepo.googleLogin(
  //     path,
  //     data,
  //   );
  //   loginModel.fold((error) {
  //     emit(GoogleLoginFailure(error: error));
  //   }, (loginModel) {
  //     emit(GoogleLoginSuccess(loginModel: loginModel));
  //   });
  // }

  Future<void> signUp(String path, dynamic data) async {
    emit(SignUpLoading());
    final signUpModel = await signUpRepo.signUp(
      path,
      data,
    );
    signUpModel.fold(
      ((error) {
        emit(SignUpFailure(error: error));
      }),
      ((signUpModel) {
        emit(SignUpSuccess(signUpModel: signUpModel));
      }),
    );
  }

  Future<void> addDoctorAvailability(String path, dynamic data) async {
    emit(DoctorAvailabilityLoading());
    final result = await doctorAvailabilityRepo.addDoctorAvailability(
      path,
      data,
    );
    result.fold(
      ((error) {
        emit(DoctorAvailabilityFailure(error: error));
      }),
      ((response) {
        emit(DoctorAvailabilitySuccess(response: response));
      }),
    );
  }
}
