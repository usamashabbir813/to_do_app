import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Utils/Date_Time_screen.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/constants/App_image.dart';
import 'package:to_do_app/view/user/Adtolist_screen.dart';
import 'package:to_do_app/view/user/profile_screen.dart';
import 'package:to_do_app/view/user/title_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Random _random = Random();

  Color _getRandomColor() {
    List<Color> colors = [
      AppColors.skin,
      AppColors.darkgreen,
      AppColors.dartblue
    ];
    return colors[_random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: AppColors.green,
                height: 300.h,
                width: double.infinity,
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('userinfo')
                      .doc('0JzUt9AK0HeggxPgosNN')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (!snapshot.hasData ||
                        snapshot.data!['profile image'] == '') {
                      return Text('Todo is not added');
                    } else {
                      return Column(
                        children: [
                          Positioned(
                            bottom: 120.h,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(ProfileScreen());
                              },
                              child: CircleAvatar(
                                radius: 60.r,
                                backgroundColor: AppColors.green,
                                backgroundImage: NetworkImage(
                                    snapshot.data!['profile image']),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Text(
                              "Welcome ${snapshot.data!['name']}",
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                fontFamily: "font1",
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 230.w, top: 10.h),
            child: Text(
              "Todo Tasks.",
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
                fontFamily: "font1",
              ),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('todo').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text('Todo is not added');
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                        ),
                        child: Card(
                          color: _getRandomColor(),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                            child: ListTile(
                                onTap: () {
                                  Get.to(TitleScreen(), arguments: {
                                    'title': snapshot.data!.docs[index]
                                        ['title'],
                                    'description': snapshot.data!.docs[index]
                                        ['description'],
                                    'docid': snapshot.data!.docs[index]
                                        ['docid'],
                                  });
                                },
                                leading: GestureDetector(
                                  onTap: () {
                                    delete(snapshot.data!.docs[index].id);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.red,
                                    child: Icon(
                                      AppIcon.delete,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  snapshot.data!.docs[index]['title'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "font1",
                                      fontWeight: FontWeight.w700),
                                ),
                                subtitle: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  snapshot.data!.docs[index]['description'],
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: "font1",
                                      fontWeight: FontWeight.w700),
                                ),
                                trailing: Text(
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "font1",
                                        fontWeight: FontWeight.w700),
                                    DateTimeUtil.formatTime(
                                      snapshot.data!.docs[index]['time'],
                                    ))),
                          ),
                        ),
                      );
                    });
              }
            },
          ),
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
            Get.to(AdTolistDoScreen());
          }),
    );
  }

  Future delete(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('todo').doc(docId).delete();
    } catch (e) {
      Get.snackbar("error", e.toString());
    }
  }
}
