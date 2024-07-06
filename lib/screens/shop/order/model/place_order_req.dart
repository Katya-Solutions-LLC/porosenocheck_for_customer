class PlaceOrderReq {
  int locationId;
  int shippingAddressId;
  int billingAddressId;
  String phone;
  String alternativePhone;
  int chosenLogisticZoneId;
  String shippingDeliveryType;
  String paymentMethod;
  String paymentDetails;
  String paymentStatus;

  PlaceOrderReq({
    this.locationId = -1,
    this.shippingAddressId = -1,
    this.billingAddressId = -1,
    this.phone = "",
    this.alternativePhone = "",
    this.chosenLogisticZoneId = -1,
    this.shippingDeliveryType = "",
    this.paymentMethod = "",
    this.paymentDetails = "",
    this.paymentStatus = "",
  });

  factory PlaceOrderReq.fromJson(Map<String, dynamic> json) {
    return PlaceOrderReq(
      locationId: json['location_id'] is int ? json['location_id'] : -1,
      shippingAddressId: json['shipping_address_id'] is int ? json['shipping_address_id'] : -1,
      billingAddressId: json['billing_address_id'] is int ? json['billing_address_id'] : -1,
      phone: json['phone'] is String ? json['phone'] : "",
      alternativePhone: json['alternative_phone'] is String ? json['alternative_phone'] : "",
      chosenLogisticZoneId: json['chosen_logistic_zone_id'] is int ? json['chosen_logistic_zone_id'] : -1,
      shippingDeliveryType: json['shipping_delivery_type'] is String ? json['shipping_delivery_type'] : "",
      paymentMethod: json['payment_method'] is String ? json['payment_method'] : "",
      paymentDetails: json['payment_details'] is String ? json['payment_details'] : "",
      paymentStatus: json['payment_status'] is String ? json['payment_status'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location_id': locationId,
      'shipping_address_id': shippingAddressId,
      'billing_address_id': billingAddressId,
      'phone': phone,
      'alternative_phone': alternativePhone,
      'chosen_logistic_zone_id': chosenLogisticZoneId,
      'shipping_delivery_type': shippingDeliveryType,
      'payment_method': paymentMethod,
      'payment_details': paymentDetails,
      'payment_status': paymentStatus,
    };
  }
}
