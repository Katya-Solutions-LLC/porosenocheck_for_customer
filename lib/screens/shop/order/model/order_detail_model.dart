import 'package:get/get.dart';
import 'package:porosenocheck/utils/common_base.dart';

import '../../cart/model/cart_list_model.dart';
import '../../product/model/product_review_response.dart';
import '../../shop_dashboard/model/product_list_response.dart';

class OrderDetailModel {
  bool status;
  OrderListData data;
  String message;

  OrderDetailModel({
    this.status = false,
    required this.data,
    this.message = "",
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailModel(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is Map
          ? OrderListData.fromJson(json['data'])
          : OrderListData(orderDetails: OrderDetails(productDetails: CartListData(qty: 0.obs, productVariation: VariationData(inCart: false.obs), productReviewData: ProductReviewDataModel()))),
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class OrderListData {
  int id;
  String orderCode;
  int userId;
  String deliveryStatus;
  String paymentStatus;
  num subTotalAmount;
  num totalTaxAmount;
  num logisticCharge;
  num totalAmount;
  String paymentMethod;
  String orderDate;
  String logisticName;
  String expectedDeliveryDate;
  String deliveryDays;
  String deliveryTime;
  String userName;
  String addressLine1;
  String addressLine2;
  String phoneNo;
  String alternativePhoneNo;
  String city;
  String state;
  String country;
  String postalCode;
  OrderDetails orderDetails;

  // local
  String get orderingDate => orderDate.dateInddMMMyyyyHHmmAmPmFormat;

  OrderListData({
    this.id = -1,
    this.orderCode = "",
    this.userId = -1,
    this.deliveryStatus = "",
    this.paymentStatus = "",
    this.subTotalAmount = -1,
    this.totalTaxAmount = -1,
    this.logisticCharge = -1,
    this.totalAmount = -1,
    this.paymentMethod = "",
    this.orderDate = "",
    this.logisticName = "",
    this.expectedDeliveryDate = "",
    this.deliveryDays = "",
    this.deliveryTime = "",
    this.userName = "",
    this.addressLine1 = "",
    this.addressLine2 = "",
    this.phoneNo = "",
    this.alternativePhoneNo = "",
    this.city = "",
    this.state = "",
    this.country = "",
    this.postalCode = "",
    required this.orderDetails,
  });

  factory OrderListData.fromJson(Map<String, dynamic> json) {
    return OrderListData(
      id: json['id'] is int ? json['id'] : -1,
      orderCode: json['order_code'] is String
          ? json['order_code']
          : json['order_code'] is int
              ? json['order_code'].toString()
              : "",
      userId: json['user_id'] is int ? json['user_id'] : -1,
      deliveryStatus: json['delivery_status'] is String ? json['delivery_status'] : "",
      paymentStatus: json['payment_status'] is String ? json['payment_status'] : "",
      subTotalAmount: json['sub_total_amount'] is num ? json['sub_total_amount'] : -1,
      totalTaxAmount: json['total_tax_amount'] is num ? json['total_tax_amount'] : -1,
      logisticCharge: json['logistic_charge'] is num ? json['logistic_charge'] : -1,
      totalAmount: json['total_amount'] is num ? json['total_amount'] : -1,
      paymentMethod: json['payment_method'] is String ? json['payment_method'] : "",
      orderDate: json['order_date'] is String ? json['order_date'] : "",
      logisticName: json['logistic_name'] is String ? json['logistic_name'] : "",
      expectedDeliveryDate: json['expected_delivery_date'] is String ? json['expected_delivery_date'] : "",
      deliveryDays: json['delivery_days'] is String ? json['delivery_days'] : "",
      deliveryTime: json['delivery_time'] is String ? json['delivery_time'] : "",
      userName: json['user_name'] is String ? json['user_name'] : "",
      addressLine1: json['address_line_1'] is String ? json['address_line_1'] : "",
      addressLine2: json['address_line_2'] is String ? json['address_line_2'] : "",
      phoneNo: json['phone_no'] is String ? json['phone_no'] : "",
      alternativePhoneNo: json['alternative_phone_no'] is String ? json['alternative_phone_no'] : "",
      city: json['city'] is String ? json['city'] : "",
      state: json['state'] is String ? json['state'] : "",
      country: json['country'] is String ? json['country'] : "",
      postalCode: json['postal_code'] is String ? json['postal_code'] : "",
      orderDetails: json['order_details'] is Map
          ? OrderDetails.fromJson(json['order_details'])
          : OrderDetails(productDetails: CartListData(qty: 0.obs, productVariation: VariationData(inCart: false.obs), productReviewData: ProductReviewDataModel())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_code': orderCode,
      'user_id': userId,
      'delivery_status': deliveryStatus,
      'payment_status': paymentStatus,
      'sub_total_amount': subTotalAmount,
      'total_tax_amount': totalTaxAmount,
      'logistic_charge': logisticCharge,
      'total_amount': totalAmount,
      'payment_method': paymentMethod,
      'order_date': orderDate,
      'logistic_name': logisticName,
      'expected_delivery_date': expectedDeliveryDate,
      'delivery_days': deliveryDays,
      'delivery_time': deliveryTime,
      'user_name': userName,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'phone_no': phoneNo,
      'alternative_phone_no': alternativePhoneNo,
      'city': city,
      'state': state,
      'country': country,
      'postal_code': postalCode,
      'order_details': orderDetails.toJson(),
    };
  }
}

class OrderDetails {
  int vendorId;
  num totalTaxAmount;
  num logisticCharge;
  num productPrice;
  num totalAmount;
  num grandTotal;
  CartListData productDetails;
  List<OtherOrderItems> otherOrderItems;

  OrderDetails({
    this.vendorId = -1,
    this.totalTaxAmount = -1,
    this.logisticCharge = -1,
    this.productPrice = -1,
    this.totalAmount = -1,
    this.grandTotal = -1,
    required this.productDetails,
    this.otherOrderItems = const <OtherOrderItems>[],
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      vendorId: json['vendor_id'] is int ? json['vendor_id'] : -1,
      totalTaxAmount: json['total_tax_amount'] is num ? json['total_tax_amount'] : -1,
      logisticCharge: json['logistic_charge'] is num ? json['logistic_charge'] : -1,
      productPrice: json['product_price'] is num ? json['product_price'] : -1,
      totalAmount: json['total_amount'] is num ? json['total_amount'] : -1,
      grandTotal: json['grand_total'] is num ? json['grand_total'] : -1,
      productDetails: json['product_details'] is Map
          ? CartListData.fromJson(json['product_details'])
          : CartListData(qty: 0.obs, productVariation: VariationData(inCart: false.obs), productReviewData: ProductReviewDataModel()),
      otherOrderItems: json['other_order_items'] is List ? List<OtherOrderItems>.from(json['other_order_items'].map((x) => OtherOrderItems.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendor_id': vendorId,
      'total_tax_amount': totalTaxAmount,
      'logistic_charge': logisticCharge,
      'product_price': productPrice,
      'total_amount': totalAmount,
      'grand_total': grandTotal,
      'product_details': productDetails.toJson(),
      'other_order_items': otherOrderItems.map((e) => e.toJson()).toList(),
    };
  }
}

class OtherOrderItems {
  int id;
  int orderItemId;
  int userId;
  String deliveryStatus;
  String paymentStatus;
  num productPrice;
  num totalAmount;
  num grandTotal;
  CartListData productDetails;

  OtherOrderItems({
    this.id = -1,
    this.orderItemId = -1,
    this.userId = -1,
    this.deliveryStatus = "",
    this.paymentStatus = "",
    this.productPrice = -1,
    this.totalAmount = -1,
    this.grandTotal = -1,
    required this.productDetails,
  });

  factory OtherOrderItems.fromJson(Map<String, dynamic> json) {
    return OtherOrderItems(
      id: json['id'] is int ? json['id'] : -1,
      orderItemId: json['order_item_id'] is int ? json['order_item_id'] : -1,
      userId: json['user_id'] is int ? json['user_id'] : -1,
      deliveryStatus: json['delivery_status'] is String ? json['delivery_status'] : "",
      paymentStatus: json['payment_status'] is String ? json['payment_status'] : "",
      productPrice: json['product_price'] is num ? json['product_price'] : -1,
      totalAmount: json['total_amount'] is num ? json['total_amount'] : -1,
      grandTotal: json['grand_total'] is num ? json['grand_total'] : -1,
      productDetails: json['product_details'] is Map
          ? CartListData.fromJson(json['product_details'])
          : CartListData(qty: 0.obs, productVariation: VariationData(inCart: false.obs), productReviewData: ProductReviewDataModel()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_item_id': orderItemId,
      'user_id': userId,
      'delivery_status': deliveryStatus,
      'payment_status': paymentStatus,
      'product_price': productPrice,
      'total_amount': totalAmount,
      'grand_total': grandTotal,
      'product_details': productDetails.toJson(),
    };
  }
}
