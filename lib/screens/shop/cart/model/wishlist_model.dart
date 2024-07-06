import '../../shop_dashboard/model/product_list_response.dart';

class ProductWishlistRes {
  bool status;
  List<ProductItemData> data;
  String message;

  ProductWishlistRes({
    this.status = false,
    this.data = const <ProductItemData>[],
    this.message = "",
  });

  factory ProductWishlistRes.fromJson(Map<String, dynamic> json) {
    return ProductWishlistRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<ProductItemData>.from(json['data'].map((x) => ProductItemData.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}
