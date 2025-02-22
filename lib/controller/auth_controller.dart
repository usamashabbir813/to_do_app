import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/Model/user_model.dart';
import 'package:to_do_app/Utils/snackbar_screen.dart';
import 'package:to_do_app/view/auth/Sign_in_screen.dart';
import 'package:to_do_app/view/user/Home_screen.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  Future signup(
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController nameController,
      TextEditingController createpasswordcontroller) async {
    try {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;

        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        String userId = userCredential.user!.uid;

        UserModel userModel = UserModel(
          userId: userId,
          name: nameController.text,
          email: emailController.text,
          profileImage: '',
        );

        await FirebaseFirestore.instance
            .collection('userprofile')
            .doc(userId)
            .set(userModel.toFirestore());

        Get.offAll(() => HomeScreen());
        SnackbarUtil.showSuccess('Registration successful');
      }
    } catch (e) {
      SnackbarUtil.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future signin(
      GlobalKey<FormState> formKey,
      TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;

        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);

        Get.offAll(() => HomeScreen());
        SnackbarUtil.showSuccess('Sign-in successful');
      }
    } catch (e) {
      SnackbarUtil.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future forgetPassword(GlobalKey<FormState> formKey,
      TextEditingController emailController) async {
    try {
      if (formKey.currentState!.validate()) {
        isLoading.value = true;

        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);

        Get.to(() => SignInScreen());
        SnackbarUtil.showSuccess('Password reset link has been sent');
      }
    } catch (e) {
      SnackbarUtil.showError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future Logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => SignInScreen());
    } catch (e) {
      SnackbarUtil.showError("Logout failed".toString());
    }
  }
}
