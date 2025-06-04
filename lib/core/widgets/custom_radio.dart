import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heal_care/core/theme/app_colors.dart';

class CustomRadio<T> extends StatefulWidget {
  final T value;
  final T? groupValue;
  final bool? isDisabled;
  final void Function(T) onChanged;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.isDisabled = false,
  });

  @override
  State<CustomRadio<T>> createState() => _CustomRadioState<T>();
}

class _CustomRadioState<T> extends State<CustomRadio<T>> {
  @override
  Widget build(BuildContext context) {
    bool selected = widget.value == widget.groupValue;

    return Padding(
      padding: EdgeInsets.all(8.r),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () =>
            !widget.isDisabled! ? widget.onChanged(widget.value) : null,
        child: Container(
          width: 24.w,
          height: 24.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? Colors.white : Colors.grey[200],
            border: widget.isDisabled!
                ? Border.all(color: Colors.grey[500]!, width: 1.5)
                : selected
                    ? Border.all(color: AppColors.mainColor, width: 2)
                    : Border.all(color: AppColors.mainColor, width: 2),
          ),
          child: Center(
            child: widget.isDisabled!
                ? Icon(Icons.close, size: 18.r, color: Colors.grey[500])
                : selected
                    ? const Icon(
                        Icons.circle,
                        size: 12,
                        color: AppColors.mainColor,
                      )
                    : null,
          ),
        ),
      ),
    );
  }
}
