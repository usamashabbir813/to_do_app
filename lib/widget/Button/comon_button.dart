import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do_app/constants/App_color.dart';

class ComonButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;

  const ComonButton({super.key, required this.title, required this.onTap});

  @override
  State<ComonButton> createState() => _ComonButtonState();
}

class _ComonButtonState extends State<ComonButton> {
  bool isLoading = false;
  bool hasError = false;
  void handleClick() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });
    try {
      await Future.delayed(Duration(seconds: 2));
      widget.onTap();
    } catch (e) {
      setState(() {
        hasError = true;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : handleClick,
      child: Container(
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Center(
                child: Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.white),
                ),
              ),
        height: 50.h,
        width: 220.w,
        decoration:
            BoxDecoration(color: hasError ? AppColors.red : AppColors.green),
      ),
    );
  }
}
