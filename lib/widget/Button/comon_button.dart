import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/constants/App_color.dart';

class ComonButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool? isLoading;
  const ComonButton({
    this.isLoading = false,
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Center(
          child: isLoading == true
              ? CircularProgressIndicator(
                  color: AppColors.white,
                )
              : Text(
                  title,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white),
                ),
        ),
        height: 50.h,
        width: 220.w,
        decoration: BoxDecoration(color: AppColors.green),
      ),
    );
  }
}
