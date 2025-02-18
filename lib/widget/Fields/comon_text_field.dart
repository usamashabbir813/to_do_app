import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/constants/App_color.dart';

class ComonTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isEnabled;
  final bool readOnly; // Add readOnly as a parameter
  final showShadow = false;
  final String? Function(String?)? validator;

  const ComonTextField({
    required this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onChanged,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.isEnabled = true,
    this.readOnly = false, // Default is false, but can be changed
    Key? key,
    this.validator,
    required TextStyle textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47.h,
      width: 340.w,
      child: TextFormField(
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onChanged: onChanged,
        enabled: isEnabled,
        readOnly: readOnly, // Control if the field is editable or not
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColors.white, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColors.white, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(color: AppColors.white, width: 2),
          ),
          contentPadding: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
