import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String uid;
  String email;
  String phoneNumber;
  String address;

  UserModel({
    required this.name,
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'email': email,
        'phone_number': phoneNumber,
        'address': address,
      };

  static UserModel fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      name: snap['name'],
      uid: snap['uid'],
      email: snap['email'],
      phoneNumber: snap['phone_number'],
      address: snap['address'],
    );
  }
}
