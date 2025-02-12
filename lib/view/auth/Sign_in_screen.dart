import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/constants/App_image.dart';
import 'package:to_do_app/view/auth/Forget_screen.dart';
import 'package:to_do_app/view/auth/signup_screen.dart';
import 'package:to_do_app/view/user/Add_to_do_screen.dart';
import 'package:to_do_app/widget/Button/comon_button.dart';
import 'package:to_do_app/widget/Fields/comon_text_field.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController confirmpasswordcontroller =
      TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();

  bool isLoadingg = false;

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
              'Welcome Back!',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'font1',
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 18.h,
            ),
            Image.asset(AppImage.Welcome),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.w, right: 0.w),
              child: Column(
                children: [
                  ComonTextField(
                      hintText: 'Enter your Email address ',
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                      controller: emailcontroller),
                  SizedBox(
                    height: 30.h,
                  ),
                  ComonTextField(
                      hintText: 'Confirm your Password',
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                      controller: confirmpasswordcontroller),
                  SizedBox(
                    height: 25.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      {
                        Get.to(() => ForgetScreen());
                      }
                    },
                    child: Text(
                      'Forgot Password ?',
                      style: TextStyle(
                          fontFamily: 'font1',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.green),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  ComonButton(
                    isLoading: isLoadingg,
                    title: 'Sign In ',
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoadingg = true;
                        });
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailcontroller.text,
                            password: confirmpasswordcontroller.text);
                        Get.to(() => AddToDoScreen());

                        setState(() {
                          isLoadingg = false;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an account ?',
                        style: TextStyle(
                            fontFamily: 'font1',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          {
                            Get.to(() => SignupScreen());
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              fontFamily: 'font1',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
