import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<T> itemList;
  final String hint, label;
  const CustomDropdown(
      {super.key,
      required this.itemList,
      required this.hint,
      required this.label});

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.poppinsGrey(14, FontWeight.w400),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppColors.dropDownColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<T>(
            borderRadius: BorderRadius.circular(8),
            value: selectedValue,
            hint: Text(
              widget.hint,
              style: AppTextStyles.poppinsGrey(13, FontWeight.w400),
            ),
            isExpanded: true,
            underline: SizedBox(),
            icon: Icon(Icons.arrow_drop_down),
            items: widget.itemList.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  value.toString(),
                  style: AppTextStyles.poppinsBlack(14, FontWeight.w300),
                ),
              );
            }).toList(),
            onChanged: (T? newValue) {
              setState(() {
                selectedValue = newValue;
              });
            },
          ),
        ),
      ],
    );
  }
}
