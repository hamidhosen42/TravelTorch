import 'package:travel_agency/constant/constant.dart';

class FirestoreServices {
  //for get for you section data
  static getForYouPackage() {
    return firestore
        .collection(allPackages)
        .where('forYou', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .get();
  }

  //for get top place section data
  static getTopPlacePackage() {
    return firestore
        .collection(allPackages)
        .where('topPlaces', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .get();
  }

  //for get economy section data
  static getEconomyPackage() {
    return firestore
        .collection(allPackages)
        .where('economy', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .get();
  }

  //for get luxury section data
  static getLuxuryPackage() {
    return firestore
        .collection(allPackages)
        .where('luxury', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .get();
  }

  //for get user information
  static getUserInfo({required uid}) {
    return firestore.collection(usersCollection).doc(uid).snapshots();
  }

  //for get login user uploaded packages
  static getUserUploadedPackages({required uid}) {
    return firestore
        .collection(allPackages)
        .where('approved', isEqualTo: true)
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

    //for delete package:
 static deletePackage({required docId}) {
   return firestore.collection('all-data').doc(docId).delete();
  }
}
