part of 'rate_cubit.dart';

sealed class RateState {}

final class RateInitial extends RateState {}

final class RateLoading extends RateState {}

final class RateSuccess extends RateState {}

final class RateError extends RateState {
  final String error;
  RateError(this.error);
}
