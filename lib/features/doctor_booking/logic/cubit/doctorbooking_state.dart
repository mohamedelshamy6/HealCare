part of 'doctorbooking_cubit.dart';

sealed class DoctorbookingState {}

final class DoctorbookingInitial extends DoctorbookingState {}

final class DoctorbookingLoading extends DoctorbookingState {}

final class DoctorbookingSuccess extends DoctorbookingState {
  final List<DoctorBookingModel> doctorBooking;
  DoctorbookingSuccess(this.doctorBooking);
}

final class DoctorbookingFailure extends DoctorbookingState {
  final String message;
  DoctorbookingFailure(this.message);
}

final class DoctorbookingCancelAppointmentSuccess extends DoctorbookingState {
  final String message;
  DoctorbookingCancelAppointmentSuccess({required this.message});
}

final class DoctorbookingCancelAppointmentFailure extends DoctorbookingState {
  final String message;
  DoctorbookingCancelAppointmentFailure({required this.message});
}

final class DoctorbookingCancelAppointmentLoading extends DoctorbookingState {}


