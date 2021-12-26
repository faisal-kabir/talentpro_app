import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talent_pro/Model/products.dart';
import 'package:talent_pro/URL/api_client.dart';
import 'package:talent_pro/URL/app_constant.dart';
import 'package:talent_pro/URL/url.dart';
import 'package:talent_pro/Widgets/show_message.dart';

part 'product_state.dart';

class ProductBloc extends Cubit<ProductState> {
  ProductData? product;
  Api_Client api_client=Api_Client();
  bool isUpdate=false;
  RxBool Loading=false.obs;

  TextEditingController name=TextEditingController();
  TextEditingController details=TextEditingController();
  TextEditingController price=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey();

  ProductBloc() : super(ProductInitial()) {
    var arguments = Get.arguments;
    if(arguments!=null){
      product=arguments;
      isUpdate=true;
      name.text=product!.name!;
      details.text=product!.details!;
      price.text=product!.price!.toString();
    }
  }

  Future submitProduct() async {
    if(!formKey.currentState!.validate()){
      return;
    }
    Loading.value=true;
    emit(ProductLoading());
    await api_client.Request(
        url: isUpdate ? '${URL.Product_Update}${product!.id}' : URL.Product_Store,
        method: Method.POST,
        body: {
          AppConstant.name:name.text,
          AppConstant.details:details.text,
          AppConstant.price:price.text,
        },
        onSuccess: (Map data){
          SuccessMessage(message: data[AppConstant.message],then: (){
            Get.back(result: true);
          });
        },
        onError: (data){
        }
    );
    Loading.value=false;
    emit(ProductUploaded());
  }
}
