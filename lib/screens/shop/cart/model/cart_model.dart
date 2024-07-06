import 'package:get/get.dart';

class CartModel {
  String? image;
  String? name;
  String? title;
  String? subtitle;
  double? price;
  double? originalPrice;
  String? size;
  // int qty = 1;
  RxInt qty = 1.obs;
  RxString dropDownValue = "320gm".obs;
  CartModel({
    this.image,
    this.name,
    this.title,
    this.price,
    this.originalPrice,
    this.size,
    // this.qty = 1,
  });
}
