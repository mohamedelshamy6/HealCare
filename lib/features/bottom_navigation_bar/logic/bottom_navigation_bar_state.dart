part of 'bottom_navigation_bar_cubit.dart';

@immutable
sealed class BottomNavigationBarState {}

final class BottomNavigationBarInitial extends BottomNavigationBarState {}
final class IndexChanged extends BottomNavigationBarState {}
