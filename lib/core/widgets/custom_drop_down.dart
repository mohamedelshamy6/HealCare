import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

// ignore: must_be_immutable
class CustomDropdown<T> extends StatefulWidget {
  final List<T> itemList;
  final String hint, label;
  T? selectedValue;
  final bool? isValueNull;
  final Function(String value) onItemChanged;

  CustomDropdown({
    super.key,
    required this.itemList,
    required this.hint,
    required this.label,
    this.selectedValue,
    required this.onItemChanged,
    required this.isValueNull,
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
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
            border: widget.isValueNull == null || widget.isValueNull!
                ? null
                : Border.all(color: AppColors.tFFErrorColor),
          ),
          child: DropdownButton<T>(
            borderRadius: BorderRadius.circular(8),
            value: widget.selectedValue,
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
                widget.selectedValue = newValue;
              });
              widget.onItemChanged(newValue.toString());
            },
          ),
        ),
      ],
    );
  }
}
