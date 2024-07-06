import 'package:get/get.dart';

import '../../shop_dashboard/model/product_list_response.dart';

class ProductDetailRes {
  ProductItemData data;
  bool status;
  List<ProductItemData> relatedProduct;
  String message;

  ProductDetailRes({
    required this.data,
    this.status = false,
    this.relatedProduct = const <ProductItemData>[],
    this.message = "",
  });

  factory ProductDetailRes.fromJson(Map<String, dynamic> json) {
    return ProductDetailRes(
      data: json['data'] is Map ? ProductItemData.fromJson(json['data']) : ProductItemData(inWishlist: false.obs),
      status: json['status'] is bool ? json['status'] : false,
      relatedProduct: json['data'] is List ? List<ProductItemData>.from(json['data'].map((x) => ProductItemData.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'status': status,
      'relatedProduct': relatedProduct.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}
