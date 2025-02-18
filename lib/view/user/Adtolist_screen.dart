import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/constants/App_image.dart';
import 'package:to_do_app/view/user/Home_screen.dart';
import 'package:to_do_app/widget/Button/comon_button.dart';
import 'package:to_do_app/widget/Fields/comon_text_field.dart';

class AdTolistDoScreen extends StatefulWidget {
  const AdTolistDoScreen({super.key});

  @override
  State<AdTolistDoScreen> createState() => _AdTolistDoScreenState();
}

class _AdTolistDoScreenState extends State<AdTolistDoScreen> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController TitleController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 60.h,
                  right: 324.w,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    size: 34.h,
                    AppIcon.arrowback,
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 79.h,
              ),
              Text(
                "Add New ToDo",
                style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    fontFamily: "font1"),
              ),
              SizedBox(
                height: 21.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 50.w),
                child: Image.asset(AppImage.forgot),
              ),
              SizedBox(
                height: 15.h,
              ),
              Text(
                textAlign: TextAlign.center,
                "Add What your want to do later on..",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp,
                    color: AppColors.green,
                    fontFamily: "font1"),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 35.w, right: 35.w),
                child: ComonTextField(
                  hintText: "Title",
                  controller: TitleController,
                  validator: (value) {
                    if (value == '' || value == null) {
                      return 'Please enter your title';
                    }
                    return null;
                  },
                  textStyle: TextStyle(
                      fontFamily: 'font1',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ComonTextField(
                hintText: "Description",
                controller: DescriptionController,
                validator: (value) {
                  if (value == '' || value == null) {
                    return 'Please enter your Description';
                  }
                  return null;
                },
                textStyle: TextStyle(
                    fontFamily: 'font1',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 40.h,
              ),
              ComonButton(
                  isLoading: isLoading, title: 'Add to list ', onTap: addto),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future addto() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        User? user = FirebaseAuth.instance.currentUser;
        DocumentReference docRef =
            FirebaseFirestore.instance.collection('todo').doc();
        await docRef.set({
          'docid': docRef.id,
          'title': TitleController.text,
          'description': DescriptionController.text,
          'time': DateTime.now().toString(),
          "userid": user!.uid.toString()
        });
        setState(() {
          isLoading = false;
        });
        Get.to(HomeScreen());
      } catch (e) {
        Get.snackbar('error', e.toString());
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
