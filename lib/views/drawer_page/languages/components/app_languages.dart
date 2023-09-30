import 'package:get/get.dart';

import '../bangla.dart';
import '../english.dart';

class AppLanguages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': english,
        'bn_BD': bangla,
      };
}