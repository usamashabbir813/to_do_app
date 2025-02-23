import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Utils/snackbar_screen.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/controller/user_info_controller.dart';
import 'package:to_do_app/view/auth/Sign_in_screen.dart';
import 'package:to_do_app/widget/Fields/comon_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController Namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final UserInfoController userInfoController = Get.put(UserInfoController());
  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments ?? {};
    Namecontroller.text = arguments['name'] ?? '';
    emailcontroller.text = arguments['email'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 320.w, right: 20.w, top: 50.h),
                    child: GestureDetector(
                      onTap: () {
                        userInfoController.updateUSerInfo(Namecontroller);
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: 'font1',
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  CircleAvatar(
                    radius: 60.r,
                    backgroundColor: AppColors.white,
                    backgroundImage: NetworkImage(arguments['image']),
                  ),
                ],
              ),
              height: 300.h,
              width: double.infinity.w,
              decoration: BoxDecoration(color: AppColors.green),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 290.w, top: 10.h),
              child: Text(
                'Edit Profile',
                style: TextStyle(
                    color: AppColors.green,
                    fontFamily: 'font1',
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            ComonTextField(
              hintText: '',
              controller: Namecontroller,
              suffixIcon: Icon(AppIcon.eddit),
              textStyle: TextStyle(
                  fontFamily: 'font1',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10.h,
            ),
            ComonTextField(
              hintText: '',
              controller: emailcontroller,
              readOnly: true,
              textStyle: TextStyle(
                  fontFamily: 'font1',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 325.w, top: 10.h),
              child: Text(
                'More',
                style: TextStyle(
                    color: AppColors.green,
                    fontFamily: 'font1',
                    fontWeight: FontWeight.w500,
                    fontSize: 13),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 45.w,
              ),
              child: Row(
                children: [
                  Icon(
                    AppIcon.privacy,
                    size: 18.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                        color: AppColors.black,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 45.w,
              ),
              child: Row(
                children: [
                  Icon(
                    AppIcon.Terms,
                    size: 20.h,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'Terms & Conditions',
                    style: TextStyle(
                        color: AppColors.black,
                        fontFamily: 'font1',
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22.h,
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 45.w,
              ),
              child: GestureDetector(
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    Get.to(SignInScreen());
                  } catch (e) {
                    SnackbarUtil.showError('Error signing out');
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      AppIcon.Logout,
                      color: AppColors.red,
                      size: 25.h,
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                      'Logout ',
                      style: TextStyle(
                          color: AppColors.red,
                          fontFamily: 'font1',
                          fontWeight: FontWeight.w500,
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
