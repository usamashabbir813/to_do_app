import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';

class AddToTitleScreen extends StatefulWidget {
  const AddToTitleScreen({super.key});

  @override
  State<AddToTitleScreen> createState() => _AddToTitleScreenState();
}

class _AddToTitleScreenState extends State<AddToTitleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 67.h, right: 327.w, left: 14.w),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                AppIcon.arrowback,
                size: 34.h,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 23.w, right: 176.w, top: 30.h),
            child: Text(
              'Tittle of your Task',
              style: TextStyle(
                  fontFamily: 'font1',
                  fontSize: 20.h,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 35, left: 35),
            child: Divider(
              color: AppColors.green,
              thickness: 2,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 35.w, right: 35.w, top: 20.h),
            child: Text(
              "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncove",
              style: TextStyle(
                  fontFamily: 'font1',
                  fontSize: 14.h,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
