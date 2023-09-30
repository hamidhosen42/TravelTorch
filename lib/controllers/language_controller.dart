import 'package:get/get.dart';

class LanguageControler extends GetxController {
  var selectedLanguage = "".obs;

  changeLanguage(value) {
    selectedLanguage.value = value;
  }
}
