import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/view/user/update_screen.dart';

class TitleScreen extends StatefulWidget {
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 60.h, left: 10.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    size: 34.h,
                    AppIcon.arrowback,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(
                  width: 330.w,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(UpdateScreen(), arguments: {
                      'title': arguments['title'],
                      'description': arguments['description'],
                      'docid': arguments['docid'],
                    });
                  },
                  child: Icon(
                    size: 34.h,
                    AppIcon.eddit,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 200.w),
            child: Text(
              arguments['title'],
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp,
                  fontFamily: "font1"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Divider(
              thickness: 2,
              color: AppColors.green,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 11.w, right: 11.w, top: 20.h),
            child: Text(
              textAlign: TextAlign.center,
              arguments['description'],
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  color: AppColors.black,
                  fontFamily: "font1"),
            ),
          ),
        ],
      ),
    );
  }
}
