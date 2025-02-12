import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/constants/App_image.dart';
import 'package:to_do_app/view/auth/Sign_in_screen.dart';
import 'package:to_do_app/widget/Button/comon_button.dart';
import 'package:to_do_app/widget/Fields/comon_text_field.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController forgotpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Form(
        key: _formKey,
        child: Column(
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
            SizedBox(
              height: 79.h,
            ),
            Text(
              'Forgot Password',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'font1',
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 45.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 95.w, right: 45.w),
              child: Image.asset(AppImage.forgot),
            ),
            SizedBox(
              height: 41.h,
            ),
            ComonTextField(
                hintText: 'Forgot Password',
                validator: (value) {
                  if (value == '' || value == null) {
                    return 'Please enter your Password';
                  }
                  return null;
                },
                controller: forgotpassword),
            SizedBox(
              height: 57.h,
            ),
            ComonButton(
                title: 'Forgot',
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: forgotpassword.text);
                    Get.to(() => SignInScreen());
                  }
                })
          ],
        ),
      ),
    );
  }
}
