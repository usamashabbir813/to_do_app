import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';
import 'package:to_do_app/controller/adtolist.dart';
import 'package:to_do_app/widget/Button/comon_button.dart';
import 'package:to_do_app/widget/Fields/updatetextfield.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  Adtocontroller adtocontroller = Get.put(Adtocontroller());

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments ?? {};
    titleController.text = arguments['title'] ?? '';
    descriptionController.text = arguments['description'] ?? '';
  }

  bool isLoadingg = false;

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 60.h,
                  right: 350.w,
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
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Updatetextfield(
                  controller: titleController,
                  textStyle: TextStyle(
                    fontFamily: 'font1',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Divider(
                  thickness: 2,
                  color: AppColors.green,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Updatetextfield(
                  controller: descriptionController,
                ),
              ),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 30.h),
              child: Obx(
                () => ComonButton(
                  title: "Update",
                  isLoading: adtocontroller.isLoading.value,
                  onTap: () async {
                    final String docId = arguments['docid'];
                    adtocontroller.updates(
                        titleController, descriptionController, docId);
                  },
                ),
              ))
        ],
      ),
    );
  }
}
