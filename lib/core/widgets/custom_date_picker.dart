import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';

class CustomDatePicker extends StatefulWidget {
  final void Function(DateTime)? onDateChange;
  final int daysCount;

  const CustomDatePicker({
    super.key,
    this.onDateChange,
    this.daysCount = 30,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDate;
  late List<DateTime> _dates;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _dates = List.generate(
      widget.daysCount,
      (index) => DateTime.now().add(Duration(days: index)),
    ).where((date) => date.weekday != DateTime.friday).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      width: MediaQuery.of(context).size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _dates.length,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final date = _dates[index];
          final isSelected = date.day == _selectedDate.day &&
              date.month == _selectedDate.month &&
              date.year == _selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() => _selectedDate = date);
              widget.onDateChange?.call(date);
            },
            child: Container(
              width: 60.w,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.mainColor : AppColors.mainWhite,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.E().format(date), // Mon, Tue, ...
                    style: isSelected
                        ? AppTextStyles.poppinsBlack(14, FontWeight.w600)
                        : AppTextStyles.poppinsGrey(14, FontWeight.w600),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    date.day.toString(),
                    style: isSelected
                        ? AppTextStyles.poppinsBlack(14, FontWeight.w600)
                        : AppTextStyles.poppinsGrey(14, FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
