import 'package:equatable/equatable.dart';

class Products{
  Products({
      this.status, 
      this.message, 
      this.data,});

  Products.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductData.fromJson(v));
      });
    }
  }
  bool? status;
  String? message;
  List<ProductData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ProductData {
  ProductData({
      this.id, 
      this.name, 
      this.details, 
      this.price, 
  });

  ProductData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    price = double.parse(json['price'].toString());
  }
  int? id;
  String? name;
  String? details;
  double? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['details'] = details;
    map['price'] = price;
    return map;
  }

}