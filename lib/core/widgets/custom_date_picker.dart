import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class CustomDatePicker extends StatelessWidget {
  final void Function(DateTime)? onDateChange;
  final DatePickerController? controller;
  final int daysCount;

  const CustomDatePicker({
    super.key,
    this.onDateChange,
    this.controller,
    this.daysCount = 30,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        onDateChange: onDateChange,
        controller: controller,
        daysCount: daysCount,
        dateTextStyle: AppTextStyles.poppinsGrey(14, FontWeight.w600),
        dayTextStyle: AppTextStyles.poppinsBlack(14, FontWeight.w600),
        selectionColor: AppColors.mainColor,
        deactivatedColor: AppColors.mainWhite,
      ),
    );
  }
}
