import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/view/auth/Sign_in_screen.dart';
import 'package:to_do_app/widget/Button/comon_button.dart';
import 'package:to_do_app/widget/Fields/comon_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController Namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController createpasswordcontroller =
      TextEditingController();
  final TextEditingController confirmpasswordcontroller =
      TextEditingController();
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
                  if (_formKey.currentState!.validate()) {
                    Get.to(() => SignInScreen());
                  }
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
              'Welcome Onboard',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'font1',
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 18.h,
            ),
            Text(
              textAlign: TextAlign.center,
              'Let’s help you meet up your task',
              style: TextStyle(
                  fontSize: 13.sp,
                  fontFamily: 'font1',
                  fontWeight: FontWeight.w500,
                  color: AppColors.green),
            ),
            SizedBox(
              height: 39.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.w, right: 0.w),
              child: Column(
                children: [
                  ComonTextField(
                    hintText: 'Enter your Full Name',
                    controller: Namecontroller,
                    validator: (value) {
                      if (value == '' || value == null) {
                        return 'Please enter your Name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  ComonTextField(
                      hintText: 'Enter your Email address ',
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: emailcontroller),
                  SizedBox(
                    height: 26.h,
                  ),
                  ComonTextField(
                      hintText: 'Create a Password',
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                      controller: createpasswordcontroller),
                  SizedBox(
                    height: 26.h,
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
                    height: 85.h,
                  ),
                  ComonButton(
                    title: 'Sign Up ',
                    isLoading: isLoadingg,
                    onTap: () async {
                      try {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoadingg = true;
                          });
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailcontroller.text,
                                  password: confirmpasswordcontroller.text);
                          Get.to(() => SignInScreen());
                          setState(() {
                            isLoadingg = false;
                          });
                        }
                      } catch (e) {
                        print(e.toString());
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
                        'Already have an account ?',
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
                          Get.to(() => SignInScreen());
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontFamily: 'font1',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
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
