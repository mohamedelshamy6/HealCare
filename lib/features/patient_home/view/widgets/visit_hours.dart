import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/patient_home/data/models/appointement_schedual_model.dart';
import 'dart:developer' as developer;

class VisitHours extends StatefulWidget {
  final List<TimeSlot> times;
  final void Function(String)? onTimeSelected;

  const VisitHours({super.key, required this.times, this.onTimeSelected});

  @override
  State<VisitHours> createState() => _VisitHoursState();
}

class _VisitHoursState extends State<VisitHours> {
  String? selectedTime;

  String formatTime(String time) {
    try {
      final parts = time.split(':');
      if (parts.length != 2) return time;

      int hour = int.tryParse(parts[0]) ?? 0;
      final minute = parts[1];

      if (hour == 0) {
        return '12:$minute AM';
      } else if (hour < 12) {
        return '$hour:$minute AM';
      } else if (hour == 12) {
        return '12:$minute PM';
      } else {
        return '${hour - 12}:$minute PM';
      }
    } catch (e) {
      developer.log('Error formatting time: $time, error: $e');
      return time;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.times.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 8.w,
      runSpacing: 12.h,
      children: widget.times.map((slot) {
        final isSelected = selectedTime == slot.time;
        final isBooked = slot.isBooked;

        Color bgColor = isBooked
            ? Colors.transparent
            : isSelected
                ? AppColors.mainColor
                : Colors.white;

        TextStyle textStyle = isBooked
            ? AppTextStyles.poppinsGrey(12, FontWeight.w500)
            : isSelected
                ? AppTextStyles.poppinsWhite(12, FontWeight.w500)
                : AppTextStyles.poppinsBlack(12, FontWeight.w500);

        return GestureDetector(
          onTap: isBooked
              ? null
              : () {
                  setState(() {
                    selectedTime = slot.time;
                  });
                  if (widget.onTimeSelected != null) {
                    widget.onTimeSelected!(slot.time);
                  }
                },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: bgColor,
            ),
            child: Text(formatTime(slot.time), style: textStyle),
          ),
        );
      }).toList(),
    );
  }
}
