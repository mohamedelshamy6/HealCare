import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTFF extends StatefulWidget {
  final String hintText;
  final TextInputType kbType;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  const CustomTFF({
    super.key,
    required this.hintText,
    required this.kbType,
    this.controller,
    this.validate,
  });

  @override
  State<CustomTFF> createState() => _CustomTFFState();
}

class _CustomTFFState extends State<CustomTFF> {
  bool showPassword = false;
  String content = '';

  @override
  Widget build(BuildContext context) {
    var borderSide = const BorderSide(
      // color: AppColors.tFFEnabledBorderColor,
      width: 1,
    );
    return TextFormField(
      inputFormatters: [
        LengthLimitingTextInputFormatter(
          widget.hintText.contains('password') ||
                  widget.hintText.contains('email')
              ? 50
              : 15,
        ),
      ],
      enableInteractiveSelection: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.kbType,
      validator: widget.validate,
      obscureText: widget.hintText.contains('password')
          ? showPassword
              ? false
              : true
          : false,
      obscuringCharacter: '●',
      enabled: true,
      // style: AppTextStyles.cairo12ExtraBoldTFFContentColor,
      textAlignVertical: TextAlignVertical.center,
      // cursorColor: AppColors.tFFContentColor,
      textAlign: content.isEmpty ? TextAlign.right : TextAlign.left,
      controller: widget.controller,
      onChanged: (value) {
        setState(() {
          content = value;
        });
      },
      decoration: InputDecoration(
        hintFadeDuration: const Duration(milliseconds: 100),
        prefixIcon: content.isNotEmpty ? tFFIconPosition() : null,
        suffixIcon: content.isEmpty ? tFFIconPosition() : null,
        prefixIconColor: AppColors.mainColor,
        suffixIconColor: AppColors.mainColor,
        // fillColor: content.isEmpty
        //     ? AppColors.tFFEmptyColor
        //     : AppColors.tFFFilledColor,
        filled: true,
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        // hintStyle: AppTextStyles.cairo12MediumTFFContentColor,
        // errorStyle: AppTextStyles.cairo12RegularTFFErrorColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: borderSide,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: borderSide.copyWith(color: AppColors.tFFErrorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: borderSide.copyWith(color: AppColors.tFFErrorColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget? tFFIconPosition() {
    return widget.hintText.contains('password')
        ? IconButton(
            style: const ButtonStyle(
              splashFactory: NoSplash.splashFactory,
            ),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              size: 20.r,
            ),
          )
        : null;
  }
}
