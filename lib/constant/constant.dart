// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Page
List pages = [
  // NavHomeScreen(),
  // PackageAddPage(),
  // SelfTourScreen(),
];
//Firebase
var firebaseAuth = FirebaseAuth.instance;
var firestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;

//Firebase collection name
const allPackages = "all-data";
const usersCollection = "users";