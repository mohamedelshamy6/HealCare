import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTFF extends StatefulWidget {
  final String hintText;
  final TextInputType kbType;
  final TextEditingController? controller;
  final Color? color;
  final int? maxInputLength;
  final int? maxLines;
  final double? borderRadius;
  final Widget? suffixIcon, prefixIcon;
  final bool? enableFocusedBorder;
  final TextStyle? hintTextStyle;
  final String? Function(String?)? validate;
  final Color? cursorColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final FocusNode? focusNode;

  const CustomTFF({
    super.key,
    required this.hintText,
    required this.kbType,
    this.controller,
    this.validate,
    this.color,
    this.maxInputLength,
    this.hintTextStyle,
    this.enableFocusedBorder,
    this.borderRadius,
    this.maxLines,
    this.suffixIcon,
    this.prefixIcon,
    this.horizontalPadding,
    this.verticalPadding,
    this.cursorColor,
    this.focusNode,
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
          widget.maxInputLength ??
              (widget.hintText.contains('password') ||
                      widget.hintText.contains('Email')
                  ? 50
                  : 15),
        ),
      ],
      focusNode: widget.focusNode,
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
      maxLines: widget.maxLines ?? 1,
      style: AppTextStyles.poppinsBlack(16, FontWeight.w400),
      textAlignVertical: TextAlignVertical.center,
      cursorColor: widget.cursorColor ?? AppColors.mainBlack,
      controller: widget.controller,
      decoration: InputDecoration(
        hintFadeDuration: const Duration(milliseconds: 100),
        suffixIcon: widget.suffixIcon ?? tFFIconPosition(),
        prefixIcon: widget.prefixIcon,
        suffixIconColor: AppColors.mainBlack,
        fillColor: widget.color ?? Colors.white,
        filled: true,
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding ?? 16.w,
            vertical:
                widget.verticalPadding ?? 8.h), ////////////////////////////
        hintStyle: widget.hintTextStyle ??
            AppTextStyles.poppinsBlack(15, FontWeight.w400),
        // errorStyle: AppTextStyles.cairo12RegularTFFErrorColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          borderSide: widget.enableFocusedBorder == false
              ? BorderSide.none
              : borderSide,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          borderSide: borderSide.copyWith(color: AppColors.tFFErrorColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
          borderSide: borderSide.copyWith(color: AppColors.tFFErrorColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.r),
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
