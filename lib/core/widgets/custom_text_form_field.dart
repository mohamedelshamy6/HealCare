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
                  widget.hintText.contains('Email')
              ? 50
              : 15,
        ),
      ],
      enableInteractiveSelection: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: widget.kbType,
      validator: widget.validate,
      obscureText: widget.hintText.contains('password') ||
              widget.hintText.contains('Password')
          ? showPassword
              ? false
              : true
          : false,
      obscuringCharacter: '●',
      enabled: true,
      style: AppTextStyles.poppinsBlack(16, FontWeight.w400),
      textAlignVertical: TextAlignVertical.center,
      cursorColor: AppColors.mainBlack,
      controller: widget.controller,
      decoration: InputDecoration(
        hintFadeDuration: const Duration(milliseconds: 100),
        suffixIcon: tFFIconPosition(),
        suffixIconColor: AppColors.mainBlack,
        fillColor: Colors.white,
        filled: true,
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        hintStyle: AppTextStyles.poppinsBlack(15, FontWeight.w400),
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
    return widget.hintText.contains('password') ||
            widget.hintText.contains('Password')
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
