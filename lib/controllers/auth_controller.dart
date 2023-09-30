import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../constants/constant.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;

  //text editing controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //user login
  Future<UserCredential?> loginMethod() async {
    UserCredential? userCredential;
    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message.toString());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    return userCredential;
  }
}
