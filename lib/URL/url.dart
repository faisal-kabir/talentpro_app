import 'package:flutter/foundation.dart';
import 'package:talent_pro/URL/app_constant.dart';

import '../main.dart';

class URL {
  static String Main_Url = 'http://127.0.0.1:8000/';
  static String device_type='android';

  static String Product_list=Main_Url + 'api/get';
  static String Product_Update=Main_Url + 'api/update/';
  static String Product_Store=Main_Url + 'api/store';
  static String Product_Delete=Main_Url + 'api/delete/';
}
