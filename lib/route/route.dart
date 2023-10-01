// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_element, constant_identifier_names, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../views/screens/splash_screen.dart';


const String splash = "/splash_screen";
const String signIn = "/sign-in-screen";
const String resetPassword = "/reset_password.dart";
const String userForm = "/user-form-screen";
const String privacyPolicy = "/privacy-policy-screen";
const String home_screen = '/home-screen';
const String see_all_topplace = '/see-all-topplace';
const String see_all_hill = '/see-all-hill';
const String see_all_sea = '/see-all-sea';
const String see_all_park ="/see-all-park";
const String supportScreen = '/support-screen';
const String privacyScreen = '/privacy-screen';
const String faqScreen = '/faq-screen';
const String howToUseScreen = '/how-to-use-screen';
const String settingsScreen = '/settings-screen';
const String profileScreen = '/profile-screen';
const String searchScreen = '/search-screen';
const String seeAllScreen = '/seeAll-screen';
const String detailsScreen = '/details-screen';
const String navAddLastStep = '/navAddLastStep-screen';



// control our page  route flow
late User _user;
List<GetPage> getPages = [
  GetPage(name: splash, page: () =>SplashScreen()),
  // GetPage(name: signIn, page: () => LoginScreen()),
  // GetPage(name: resetPassword, page: () => ResetPassword()),
  // GetPage(name: see_all_hill, page: () => SeeAllHillPlace()),
  // GetPage(name: see_all_topplace, page: () => AllTopPlace()),
  // GetPage(name: see_all_sea, page: () => AllSeaPlace()),
  // GetPage(name: see_all_park, page: () => SeeAllPark()),
  // GetPage(name: supportScreen, page: () => Support()),
  // // GetPage(name: userForm, page: () => UserForm()),
  // GetPage(name: privacyPolicy, page: () => Privacy()),
  // GetPage(
  //   name: home_screen,
  //   page: () => HomeScreens(),
  // ),
  // GetPage(
  //   name: supportScreen,
  //   page: () => Support(),
  // ),
  // GetPage(
  //   name: privacyScreen,
  //   page: () => Privacy(),
  // ),
  // GetPage(
  //   name: faqScreen,
  //   page: () =>FAQScreen(),
  // ),
  // GetPage(
  //   name: howToUseScreen,
  //   page: () => HowToUse(),
  // ),
  //   GetPage(
  //   name: settingsScreen,
  //   page: () => Settings(),
  // ),
  // GetPage(
  //   name: seeAllScreen,
  //   page: () {
  //     SeeAllHillPlace _seeAll = Get.arguments;
  //     return _seeAll;
  //   },
  // ),

  // // !----------admin-----------------
  // GetPage(name: adminHome, page: ()=>AdminHomeScreens()),
  // GetPage(name: adminNavController, page: ()=>AdminNavController()),

  // GetPage(
  //   name: navAddLastStep,
  //   page: () {
  //     NavAddLastStep _addLastStep = Get.arguments;
  //     return _addLastStep;
  //   },
  // ),
];