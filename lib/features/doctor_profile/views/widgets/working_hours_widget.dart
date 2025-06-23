import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:intl/intl.dart';

import '../../../patient_home/data/models/appointement_schedual_model.dart';

class WorkingHoursWidget extends StatelessWidget {
  final Map<String, List<TimeSlot>> schedule;

  const WorkingHoursWidget({super.key, required this.schedule});

  String _formatTime(String time24) {
    final time = TimeOfDay(hour: int.parse(time24.split(':')[0]), minute: 0);
    final format = DateFormat('h a');
    final dateTime = DateTime(2023, 1, 1, time.hour, time.minute);
    return format.format(dateTime).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    if (schedule.isEmpty) return const SizedBox.shrink();
    final allTimes =
        schedule.values.expand((slots) => slots.map((e) => e.time)).toList();
    allTimes.sort();
    final startTime = allTimes.first;
    final endTime = allTimes.last;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Working hours',
          style: AppTextStyles.poppinsMainColor(16, FontWeight.w700),
        ),
        16.verticalSpace,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black)),
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Saturday to Thursday',
                style: AppTextStyles.poppinsGrey(14, FontWeight.w500),
              ),
              Text(
                '${_formatTime(startTime)} - ${_formatTime(endTime)}',
                style: AppTextStyles.poppinsBlack(14, FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
