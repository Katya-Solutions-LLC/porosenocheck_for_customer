import '../../cart/model/cart_list_model.dart';

class OrderListModel {
  bool status;
  List<CartListData> data;
  String message;

  OrderListModel({
    this.status = false,
    this.data = const <CartListData>[],
    this.message = "",
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) {
    return OrderListModel(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<CartListData>.from(json['data'].map((x) => CartListData.fromJson(x))) : [],
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
