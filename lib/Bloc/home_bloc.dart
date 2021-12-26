import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talent_pro/Model/products.dart';
import 'package:talent_pro/URL/api_client.dart';
import 'package:talent_pro/URL/app_constant.dart';
import 'package:talent_pro/URL/url.dart';
import 'package:talent_pro/Widgets/show_message.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  Products? products;
  RxBool Loading=false.obs;

  Api_Client api_client=Api_Client();
  RefreshController refreshController=RefreshController();

  HomeBloc() : super(HomeInitial()) {
    getAllProduct();
  }

  Future getAllProduct() async {
    emit(ProductLoading());
    await api_client.Request(
        url: URL.Product_list,
        onSuccess: (Map data){
          products=Products.fromJson(data);
        },
        onError: (data){
        }
    );
    refreshController.refreshCompleted();
    emit(ProductGet(products));
  }

  Future deleteProduct(String id) async {
    Loading(true);
    await api_client.Request(
        url: URL.Product_Delete+id,
        onSuccess: (Map data){
          SuccessMessage(message: data[AppConstant.message]);
          getAllProduct();
        },
        onError: (data){
        }
    );
    Loading(false);
  }
}
