import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/constants/App_image.dart';
import 'package:to_do_app/view/user/todoapp_home_screen.dart';
import 'package:to_do_app/widget/Button/comon_button.dart';
import 'package:to_do_app/widget/Fields/comon_text_field.dart';

class AddToDoScreen extends StatefulWidget {
  const AddToDoScreen({super.key});

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = true;
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController descriptioncontroller = TextEditingController();
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
              'Add New ToDo',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'font1',
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 18.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 95.w, right: 45.w),
              child: Image.asset(AppImage.forgot),
            ),
            SizedBox(
              height: 41.h,
            ),
            Text(
              'Add What your want to do later on..',
              style: TextStyle(
                  fontFamily: 'font1',
                  fontSize: 13.w,
                  fontWeight: FontWeight.w600,
                  color: AppColors.green),
            ),
            SizedBox(
              height: 41.h,
            ),
            ComonTextField(
                hintText: 'Title',
                validator: (value) {
                  if (value == '' || value == null) {
                    return 'Please enter your Title';
                  }
                  return null;
                },
                controller: titlecontroller),
            SizedBox(
              height: 20.h,
            ),
            ComonTextField(
                hintText: 'Description',
                validator: (value) {
                  if (value == '' || value == null) {
                    return 'Please enter your Description';
                  }
                  return null;
                },
                controller: descriptioncontroller),
            SizedBox(
              height: 41.h,
            ),
            ComonButton(
                isLoading: isloading,
                title: 'Add to list ',
                onTap: () async {
                  try {
                    setState(() {
                      isloading = true;
                    });
                    DocumentReference docRef =
                        FirebaseFirestore.instance.collection("todo").doc();
                    await docRef.set({
                      "docId": docRef.id,
                      'title': titlecontroller.text.toString(),
                      'description': descriptioncontroller.text.toString(),
                    });
                    setState(() {
                      isloading = false;
                    });
                    Get.back();
                    Get.snackbar("sucess", "field add");
                  } on FirebaseException catch (e) {
                    Get.snackbar("error", e.toString());
                    setState(() {
                      isloading = false;
                    });
                  }
                  if (_formKey.currentState!.validate()) {
                    Get.to(TodoappHomeScreen());
                  }
                  isloading = isloading;
                })
          ],
        ),
      ),
    );
  }
}
