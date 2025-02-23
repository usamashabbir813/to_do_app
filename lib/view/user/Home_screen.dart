import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Utils/Date_Time_screen.dart';
import 'package:to_do_app/Utils/loadingutile_screen.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/controller/adtolist.dart';
import "package:to_do_app/view/user/Adtolist_screen.dart";
import 'package:to_do_app/view/user/profile_screen.dart';
import 'package:to_do_app/view/user/title_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Random _random = Random();
  final arguments = Get.arguments;
  Adtocontroller adtocontroller = Get.put(Adtocontroller());

  Color _getRandomColor() {
    List<Color> colors = [
      AppColors.skin,
      AppColors.darkgreen,
      AppColors.dartblue
    ];
    return colors[_random.nextInt(colors.length)];
  }

  final String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Container(
            color: AppColors.green,
            height: 300.h,
            width: double.infinity,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('userprofile')
                    .doc(userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (!snapshot.hasData ||
                      snapshot.data!['name'] == '') {
                    return Text('Todo is not added');
                  } else {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => ProfileScreen(), arguments: {
                          'name': snapshot.data!['name'],
                          'image': snapshot.data!['image'],
                          'userId': snapshot.data!['userid'],
                          'email': snapshot.data!['email'],
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60.r,
                            backgroundColor: Color(0xff70968f),
                            backgroundImage:
                                NetworkImage(snapshot.data!['image']),
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
                      ),
                    );
                  }
                }),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 270.w,
              top: 10.h,
            ),
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
            stream: FirebaseFirestore.instance
                .collection('todo')
                .where('userid', isEqualTo: userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingUtil.shimmerTile(itemcount: 6);
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Text('Todo is not added');
              } else {
                return Expanded(
                  child: ListView.builder(
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
                                  onTap: () async {
                                    await adtocontroller.delete(
                                      snapshot.data!.docs[index]['docid'],
                                    );
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
                                      fontSize: 12,
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
                        );
                      }),
                );
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
}
