import 'dart:async';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:talent_pro/AppHelper/helper.dart';
import 'package:talent_pro/Route/route.dart';
import 'package:talent_pro/URL/api_client.dart';
import 'package:talent_pro/URL/url.dart';
import 'package:talent_pro/Widgets/show_message.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../main.dart';

class HomeController extends GetxController{
  RxBool Loading=false.obs;
  Api_Client api_client=Api_Client();
  RefreshController refreshController=RefreshController();


  @override
  void onInit() {
    super.onInit();
    getAllProduct();
  }

  @override
  void onClose() {
    super.onClose();
    api_client.close();
  }



  Future getAllProduct() async {
    Loading.value=true;
    update();
    await api_client.Request(
        url: URL.Product_list,
        onSuccess: (Map data){

        },
        onError: (data){
        }
    );
    refreshController.refreshCompleted();
    Loading.value=false;
    update();
  }

  void onRefresh() {
    Loading.value=true;
    update();
    getAllProduct();
  }
}
