import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Utils/snackbar_screen.dart';
import 'package:to_do_app/view/user/Home_screen.dart';

class Adtocontroller extends GetxController {
  RxBool isLoading = false.obs;

  Future Adtolist(
    GlobalKey<FormState> formKey,
    TextEditingController titleController,
    TextEditingController descriptionController,
  ) async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        User? user = FirebaseAuth.instance.currentUser;
        DocumentReference docRef =
            FirebaseFirestore.instance.collection('todo').doc();
        await docRef.set({
          'docid': docRef.id,
          'email': user?.email,
          'password': hashCode,
          'title': titleController.text,
          'description': descriptionController.text,
          'time': DateTime.now().toString(),
          "userid": user!.uid.toString(),
          'profile': '',
        });
        isLoading.value = false;
        Get.to(HomeScreen());
      } catch (e) {
        SnackbarUtil.showError('Error');
        isLoading.value = false;
      }
    }
  }

  Future updates(TextEditingController titleController,
      TextEditingController descriptionController, String docId) async {
    try {
      isLoading.value = true;

      await FirebaseFirestore.instance.collection('todo').doc(docId).update({
        'title': titleController.text,
        'description': descriptionController.text,
      });

      isLoading.value = false;
      Get.offAll(HomeScreen());
    } catch (e) {
      SnackbarUtil.showError('Error');
      isLoading.value = false;
    }
  }

  Future delete(String docId) async {
    try {
      await FirebaseFirestore.instance.collection('todo').doc(docId).delete();
    } catch (e) {
      SnackbarUtil.showError('Error');
    }
  }
}
