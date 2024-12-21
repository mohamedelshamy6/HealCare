part of 'tabbar_cubit.dart';

@immutable
sealed class TabbarState {}

final class TabbarInitial extends TabbarState {}
final class TabbarSuccess extends TabbarState {}
