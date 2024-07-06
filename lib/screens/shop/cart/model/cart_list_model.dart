import 'package:get/get.dart';
import 'package:porosenocheck/utils/common_base.dart';

import '../../product/model/product_review_response.dart';
import '../../shop_dashboard/model/product_list_response.dart';

class CartListResponse {
  bool status;
  List<CartListData> data;
  CartPriceData cartPriceData;
  String message;

  CartListResponse({
    this.status = false,
    this.data = const <CartListData>[],
    required this.cartPriceData,
    this.message = "",
  });

  factory CartListResponse.fromJson(Map<String, dynamic> json) {
    return CartListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<CartListData>.from(json['data'].map((x) => CartListData.fromJson(x))) : [],
      cartPriceData: json['price'] is Map ? CartPriceData.fromJson(json['price']) : CartPriceData(taxData: CartTaxData()),
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
      'price': cartPriceData.toJson(),
      'message': message,
    };
  }
}

class CartListData {
  int id;
  int userId;
  int productId;
  int productVariationId;
  RxInt qty;
  String unitName;
  String productName;
  String productImage;
  String productDescription;
  num discountValue;
  String discountType;
  VariationData productVariation;
  String productVariationType;
  String productVariationName;
  String productVariationValue;
  int employeeId;
  String soldBy;
  String createdAt;
  String updatedAt;
  String deletedAt;

  ///order detail
  num taxAmount;
  String deliveredDate;
  String expectedDeliveryDate;

  ///order list
  int orderId;
  String orderCode;
  num taxIncludeProductPrice;
  num getProductPrice;
  num productAmount;
  String deliveryStatus;
  String paymentStatus;
  num totalAmount;
  num grandTotal;
  ProductReviewDataModel productReviewData;

  ///use only for notification id
  String notificationId;

  //local
  bool get isDiscount => discountValue != 0;
  String get deliveringDate => expectedDeliveryDate.dateInDMMMyyyyFormat;

  CartListData({
    this.id = -1,
    this.userId = -1,
    this.productId = -1,
    this.productVariationId = -1,
    required this.qty,
    this.unitName = "",
    this.productName = "",
    this.productImage = "",
    this.productDescription = "",
    this.discountValue = -1,
    this.discountType = "",
    required this.productVariation,
    this.productVariationType = "",
    this.productVariationName = "",
    this.productVariationValue = "",
    this.employeeId = -1,
    this.soldBy = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
    this.taxAmount = -1,
    this.deliveredDate = "",
    this.expectedDeliveryDate = "",
    this.orderId = -1,
    this.orderCode = "",
    this.taxIncludeProductPrice = -1,
    this.getProductPrice = -1,
    this.productAmount = -1,
    this.deliveryStatus = "",
    this.paymentStatus = "",
    this.totalAmount = -1,
    this.grandTotal = -1,
    required this.productReviewData,
    this.notificationId = "",
  });

  factory CartListData.fromJson(Map<String, dynamic> json) {
    return CartListData(
      id: json['id'] is int ? json['id'] : -1,
      userId: json['user_id'] is int ? json['user_id'] : -1,
      productId: json['product_id'] is int ? json['product_id'] : -1,
      productVariationId: json['product_variation_id'] is int ? json['product_variation_id'] : -1,
      qty: RxInt(json['qty'] is int ? json['qty'] : 0),
      unitName: json['unit_name'] is String ? json['unit_name'] : "",
      productName: json['product_name'] is String ? json['product_name'] : "",
      productImage: json['product_image'] is String ? json['product_image'] : "",
      productDescription: json['product_description'] is String ? json['product_description'] : "",
      discountValue: json['discount_value'] is num ? json['discount_value'] : -1,
      discountType: json['discount_type'] is String ? json['discount_type'] : "",
      productVariation: json['product_variation'] is Map ? VariationData.fromJson(json['product_variation']) : VariationData(inCart: false.obs),
      productVariationType: json['product_variation_type'] is String ? json['product_variation_type'] : "",
      productVariationName: json['product_variation_name'] is String ? json['product_variation_name'] : "",
      productVariationValue: json['product_variation_value'] is String ? json['product_variation_value'] : "",
      employeeId: json['employee_id'] is int ? json['employee_id'] : -1,
      soldBy: json['sold_by'] is String ? json['sold_by'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
      taxAmount: json['tax_amount'] is num ? json['tax_amount'] : -1,
      deliveredDate: json['delivered_date'] is String ? json['delivered_date'] : "",
      expectedDeliveryDate: json['expected_delivery_date'] is String ? json['expected_delivery_date'] : "",
      orderId: json['order_id'] is int ? json['order_id'] : -1,
      orderCode: json['order_code'] is String
          ? json['order_code']
          : json['order_code'] is int
              ? json['order_code'].toString()
              : "",
      taxIncludeProductPrice: json['tax_include_product_price'] is num ? json['tax_include_product_price'] : -1,
      getProductPrice: json['get_product_price'] is num ? json['get_product_price'] : -1,
      productAmount: json['product_amount'] is num ? json['product_amount'] : -1,
      deliveryStatus: json['delivery_status'] is String ? json['delivery_status'] : "",
      paymentStatus: json['payment_status'] is String ? json['payment_status'] : "",
      totalAmount: json['total_amount'] is num ? json['total_amount'] : -1,
      grandTotal: json['grand_total'] is num ? json['grand_total'] : -1,
      productReviewData: json['product_review'] is Map ? ProductReviewDataModel.fromJson(json['product_review']) : ProductReviewDataModel(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'product_variation_id': productVariationId,
      'qty': qty.value,
      'unit_name': unitName,
      'product_name': productName,
      'product_image': productImage,
      'product_description': productDescription,
      'discount_value': discountValue,
      'discount_type': discountType,
      'product_variation': productVariation.toJson(),
      'product_variation_type': productVariationType,
      'product_variation_name': productVariationName,
      'product_variation_value': productVariationValue,
      'employee_id': employeeId,
      'sold_by': soldBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'tax_amount': taxAmount,
      'delivered_date': deliveredDate,
      'expected_delivery_date': expectedDeliveryDate,
      'order_id': orderId,
      'order_code': orderCode,
      'tax_include_product_price': taxIncludeProductPrice,
      'get_product_price': getProductPrice,
      'product_amount': productAmount,
      'delivery_status': deliveryStatus,
      'payment_status': paymentStatus,
      'total_amount': totalAmount,
      'grand_total': grandTotal,
      'product_review': productReviewData.toJson(),
    };
  }
}

class CartPriceData {
  num taxIncludedAmount;
  num discountAmount;
  num totalAmount;
  CartTaxData taxData;
  num taxAmount;
  num totalPayableAmount;

  CartPriceData({
    this.taxIncludedAmount = -1,
    this.discountAmount = -1,
    this.totalAmount = -1,
    required this.taxData,
    this.taxAmount = -1,
    this.totalPayableAmount = -1,
  });

  factory CartPriceData.fromJson(Map<String, dynamic> json) {
    return CartPriceData(
      taxIncludedAmount: json['tax_included_amount'] is num ? json['tax_included_amount'] : -1,
      discountAmount: json['discount_amount'] is num ? json['discount_amount'] : -1,
      totalAmount: json['total_amount'] is num ? json['total_amount'] : -1,
      taxData: json['tax_data'] is Map ? CartTaxData.fromJson(json['tax_data']) : CartTaxData(),
      taxAmount: json['tax_amount'] is num ? json['tax_amount'] : -1,
      totalPayableAmount: json['total_payable_amount'] is num ? json['total_payable_amount'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tax_included_amount': taxIncludedAmount,
      'discount_amount': discountAmount,
      'total_amount': totalAmount,
      'tax_data': taxData.toJson(),
      'tax_amount': taxAmount,
      'total_payable_amount': totalPayableAmount,
    };
  }
}

class CartTaxData {
  num totalTaxAmount;
  List<TaxDetails> taxDetails;

  CartTaxData({
    this.totalTaxAmount = -1,
    this.taxDetails = const <TaxDetails>[],
  });

  factory CartTaxData.fromJson(Map<String, dynamic> json) {
    return CartTaxData(
      totalTaxAmount: json['total_tax_amount'] is num ? json['total_tax_amount'] : -1,
      taxDetails: json['tax_details'] is List ? List<TaxDetails>.from(json['tax_details'].map((x) => TaxDetails.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_tax_amount': totalTaxAmount,
      'tax_details': taxDetails.map((e) => e.toJson()).toList(),
    };
  }
}

class TaxDetails {
  String taxName;
  String taxType;
  num taxValue;
  num taxAmount;

  TaxDetails({
    this.taxName = "",
    this.taxType = "",
    this.taxValue = -1,
    this.taxAmount = -1,
  });

  factory TaxDetails.fromJson(Map<String, dynamic> json) {
    return TaxDetails(
      taxName: json['tax_name'] is String ? json['tax_name'] : "",
      taxType: json['tax_type'] is String ? json['tax_type'] : "",
      taxValue: json['tax_value'] is num ? json['tax_value'] : -1,
      taxAmount: json['tax_amount'] is num ? json['tax_amount'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tax_name': taxName,
      'tax_type': taxType,
      'tax_value': taxValue,
      'tax_amount': taxAmount,
    };
  }
}
