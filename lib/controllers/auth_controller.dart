// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_tour_app/constant/constant.dart';
import 'package:flutter_tour_app/models/user_model.dart';
import 'package:flutter_tour_app/views/auth/login_screen.dart';
import 'package:flutter_tour_app/views/screens/home_screen.dart';

class AuthController extends GetxController {
  //for button loading indicator
  var isLoading = false.obs;

  Future userRegistration({
    required String name,
    required String email,
    required String password,
    required String number,
    required String address,
  }) async {
    try {
      if (name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          number.isNotEmpty &&
          address.isNotEmpty) {
        UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        var authCredential = userCredential.user;
        if (authCredential!.uid.isNotEmpty) {
          Fluttertoast.showToast(msg: 'Registration Successfull');
          Get.to(() => HomeScreen());
        } else {
          Fluttertoast.showToast(msg: 'Something is wrong!');
        }
        UserModel userModel = UserModel(
          name: name,
          uid: userCredential.user!.uid,
          email: email,
          phoneNumber: number,
          address: address,
        );
        //save user info in firebase
        await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());
      } else {
        Fluttertoast.showToast(msg: 'Please enter all the field');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        Fluttertoast.showToast(msg: 'Please write right email');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error is: $e');
    }
  }

  //for user login
  Future userLogin({required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        var authCredential = userCredential.user;
        if (authCredential!.uid.isNotEmpty) {
          Fluttertoast.showToast(msg: 'Login Successfull');

          Get.to(() => HomeScreen());
        } else {
          Fluttertoast.showToast(msg: 'Something is wrong!');
        }
      } else {
        Fluttertoast.showToast(msg: "Please enter all the field");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error is: $e');
    }
  }

  //for logout
  signOut() async {
    await firebaseAuth.signOut();
    Fluttertoast.showToast(msg: 'Log out');
    Get.offAll(() => SignInScreen());
  }
}
