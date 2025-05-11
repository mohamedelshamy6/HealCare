import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/theme/app_colors.dart';
import 'package:heal_care/core/theme/app_text_styles.dart';
import 'package:heal_care/features/patient_home/data/models/appointement_schedual_model.dart';

class VisitHours extends StatefulWidget {
  final List<TimeSlot> times;
  const VisitHours({super.key, required this.times});

  @override
  State<VisitHours> createState() => _VisitHoursState();
}

class _VisitHoursState extends State<VisitHours> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 12.h,
      children: List.generate(widget.times.length, (index) {
        final slot = widget.times[index];
        final isSelected = selectedIndex == index;
        final isBooked = slot.isBooked;

        // تحديد ألوان الخلفية والنص
        Color bgColor;
        TextStyle textStyle;

        if (isBooked) {
          bgColor = Colors.transparent;
          textStyle = AppTextStyles.poppinsGrey(12, FontWeight.w500);
        } else if (isSelected) {
          bgColor = AppColors.mainColor;
          textStyle = AppTextStyles.poppinsWhite(12, FontWeight.w500);
        } else {
          bgColor = Colors.white;
          textStyle = AppTextStyles.poppinsBlack(12, FontWeight.w500);
        }

        final parsedTime = TimeOfDay(
          hour: int.parse(slot.time.split(":")[0]),
          minute: int.parse(slot.time.split(":")[1]),
        );
        final formattedTime = parsedTime.format(context);

        return GestureDetector(
          onTap: isBooked
              ? null
              : () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: bgColor,
            ),
            child: Text(formattedTime, style: textStyle),
          ),
        );
      }),
    );
  }
}
