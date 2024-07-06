import 'package:get/get.dart';

class AddressListResponse {
  String message;
  List<UserAddress> userAddress;
  bool status;

  AddressListResponse({
    this.message = "",
    this.userAddress = const <UserAddress>[],
    this.status = false,
  });

  factory AddressListResponse.fromJson(Map<String, dynamic> json) {
    return AddressListResponse(
      message: json['message'] is String ? json['message'] : "",
      userAddress: json['data'] is List ? List<UserAddress>.from(json['data'].map((x) => UserAddress.fromJson(x))) : [],
      status: json['status'] is bool ? json['status'] : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'data': userAddress.map((e) => e.toJson()).toList(),
      'status': status,
    };
  }
}

class UserAddress {
  RxInt id;
  String firstName;
  String lastName;
  String addressLine1;
  String addressLine2;
  String postalCode;
  String city;
  String state;
  String country;
  String cityName;
  String stateName;
  String countryName;
  int isPrimary;

  UserAddress({
    required this.id,
    this.firstName = "",
    this.lastName = "",
    this.addressLine1 = "",
    this.addressLine2 = "",
    this.postalCode = "",
    this.city = "",
    this.state = "",
    this.country = "",
    this.cityName = "",
    this.stateName = "",
    this.countryName = "",
    this.isPrimary = -1,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) {
    return UserAddress(
      id: json['id'] is int ? (json['id'] as int).obs : (-1).obs,
      firstName: json['first_name'] is String ? json['first_name'] : "",
      lastName: json['last_name'] is String ? json['last_name'] : "",
      addressLine1: json['address_line_1'] is String ? json['address_line_1'] : "",
      addressLine2: json['address_line_2'] is String ? json['address_line_2'] : "",
      postalCode: json['postal_code'] is String ? json['postal_code'] : "",
      city: json['city'] is String ? json['city'] : "",
      state: json['state'] is String ? json['state'] : "",
      country: json['country'] is String ? json['country'] : "",
      cityName: json['city_name'] is String ? json['city_name'] : "",
      stateName: json['state_name'] is String ? json['state_name'] : "",
      countryName: json['country_name'] is String ? json['country_name'] : "",
      isPrimary: json['is_primary'] is int ? json['is_primary'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'address_line_1': addressLine1,
      'address_line_2': addressLine2,
      'postal_code': postalCode,
      'city': city,
      'state': state,
      'country': country,
      'city_name': cityName,
      'state_name': stateName,
      'country_name': countryName,
      'is_primary': isPrimary,
    };
  }
}
