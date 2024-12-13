import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/helpers/app_images.dart';

part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarCubit extends Cubit<BottomNavigationBarState> {
  BottomNavigationBarCubit() : super(BottomNavigationBarInitial());
  int selectedIndex = 2;
  List<String> patientBotNavBarItemsLabel = [
    'Booking',
    'Chat',
    '',
    'Notification',
    'Profile'
  ];
  List<String> doctorBotNavBarItemsLabel = [
    'Booking',
    'Chat',
    '',
    'E-Wallet',
    'Profile'
  ];
  List<String> patientBotNavBarItemsActiveIcon = [
    Assets.iconsBookingIconBlue,
    Assets.iconsChatIconBlue,
    '',
    Assets.iconsNotificationIconBlue,
    Assets.iconsProfileIconBlue,
  ];
  List<String> patientBotNavBarItemsInActiveIcon = [
    Assets.iconsBookingIconGrey,
    Assets.iconsChatIconGrey,
    '',
    Assets.iconsNotificationIconGrey,
    Assets.iconsProfileIconGrey,
  ];
  List<String> doctorBotNavBarItemsActiveIcon = [
    Assets.iconsBookingIconBlue,
    Assets.iconsChatIconBlue,
    '',
    Assets.iconsDoctorEWalletIconBlue,
    Assets.iconsProfileIconBlue,
  ];
  List<String> doctorBotNavBarItemsInActiveIcon = [
    Assets.iconsBookingIconGrey,
    Assets.iconsChatIconGrey,
    '',
    Assets.iconsDoctorEWalletIconGrey,
    Assets.iconsProfileIconGrey,
  ];
  void indexChanged(int index) {
    selectedIndex = index;
    emit(IndexChanged());
  }
}
