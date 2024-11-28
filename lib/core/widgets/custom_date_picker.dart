import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

// import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomDatePicker extends StatelessWidget {
  final void Function(DateTime)? onDateChange;
  final DatePickerController? controller;
  const CustomDatePicker({
    super.key,
    this.onDateChange,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      initialSelectedDate: DateTime.now(),
      onDateChange: onDateChange,
      controller: controller,
      daysCount: 30,
      DateTime.now(),
      dateTextStyle: AppTextStyles.interBlack(14, FontWeight.w600),
      dayTextStyle: AppTextStyles.interBlack(14, FontWeight.w600),
      // selectionColor: AppColors.mainRed,
      // deactivatedColor: AppColors.mainGrey,
    );
  }
}
