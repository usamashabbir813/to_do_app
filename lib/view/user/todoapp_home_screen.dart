import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Utils/Date_Time_screen.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/view/user/Add_to_do_screen.dart';
import 'package:to_do_app/view/user/add_to_title_screen.dart';

class TodoappHomeScreen extends StatefulWidget {
  const TodoappHomeScreen({super.key});

  @override
  State<TodoappHomeScreen> createState() => _TodoappHomeScreenState();
}

class _TodoappHomeScreenState extends State<TodoappHomeScreen> {
  final Random _random = Random();
  List<Color> color = [AppColors.darkgreen, AppColors.skin, AppColors.dartblue];
  Color _getRandomColor() {
    List<Color> colors = [
      AppColors.darkgreen,
      AppColors.skin,
      AppColors.dartblue
    ];

    return colors[_random.nextInt(colors.length)];
  }

  final List<Map<String, dynamic>> data = [
    {"title": "Usama", "des": 'description is this', "time": "6:40 pm"},
    {"title": "Usama", "des": 'description is this', "time": "8:30 pm"},
    {"title": "Usama", "des": 'description is this', "time": "3:48 pm"},
  ];

  final List<Color> colors = [
    AppColors.darkgreen,
    AppColors.skin,
    AppColors.dartblue
  ];
  final List<String> items = List.generate(20, (index) => 'Item ${index + 1}');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Container(
            height: 290.h,
            width: double.infinity.w,
            decoration: BoxDecoration(color: AppColors.green),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 90.h),
                    child: CircleAvatar(
                      radius: 50.r,
                      backgroundImage: AssetImage('assets/handsome .png'),
                      backgroundColor: AppColors.green,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  'Welcome Fisayomi',
                  style: TextStyle(
                      fontFamily: 'font1',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 0.w, right: 233.w, top: 25.h),
            child: Text(
              'Todo Tasks.',
              style: TextStyle(
                  fontFamily: 'font1',
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 0.h,
          ),
          FutureBuilder(
            future: FirebaseFirestore.instance.collection('todo').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text('Error${(snapshot.error)}');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(AddToTitleScreen());
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 5.h),
                          child: Card(
                            color: _getRandomColor(),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              child: ListTile(
                                title: Text(
                                  snapshot.data!.docs[index]['title'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: Text(
                                  snapshot.data!.docs[index]['description'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: Text(
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w700),
                                    DateTimeUtil.formatTime(
                                      snapshot.data!.docs[index]['time'],
                                    )),
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: AppColors.green,
          child: Center(
            child: Icon(
              AppIcon.add,
              color: AppColors.white,
            ),
          ),
          onPressed: () {
            Get.to(AddToDoScreen());
          }),
    );
  }
}
