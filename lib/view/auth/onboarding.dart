import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/view/auth/signup_screen.dart';
import 'package:to_do_app/widget/Button/comon_button.dart';

import '../../constants/App_color.dart';
import '../../constants/App_image.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(child: Image.asset(AppImage.splash)),
          SizedBox(
            height: 43.h,
          ),
          Text(
            'Get things done with TODo',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'font1'),
          ),
          SizedBox(
            height: 18.h,
          ),
          Text(
            textAlign: TextAlign.center,
            'Lorem ipsum dolor sit amet,\n consectetur adipisicing. Maxime, \n tempore! Animi nemo aut atque, \n deleniti nihil dolorem repellendus.',
            style: TextStyle(
                fontSize: 13, fontWeight: FontWeight.w500, fontFamily: 'font1'),
          ),
          SizedBox(
            height: 56.h,
          ),
          ComonButton(
            title: 'Get Started ',
            onTap: () {
              Get.to(SignupScreen());
            },
          ),
          SizedBox(
            height: 65,
          ),
        ],
      ),
    );
  }
}
