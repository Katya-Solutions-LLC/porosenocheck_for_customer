import 'dart:convert';

import '../../../../utils/constants.dart';
import '../../model/facilities_model.dart';

class BookBoardingReq {
  int id;

  int systemServiceId;
  int petId;
  int employeeId;
  String dropoffDate;
  String dropoffTime;
  String dropoffAddress;
  String pickupDate;
  String pickupTime;
  String pickupAddress;
  List<FacilityModel> additionalFacility;
  String bookingType;
  String additionalInfo;
  num price;
  num totalAmount;

  BookBoardingReq({
    this.id = -1,
    this.systemServiceId = -1,
    this.petId = -1,
    this.employeeId = -1,
    this.dropoffDate = "",
    this.dropoffTime = "",
    this.dropoffAddress = "",
    this.pickupDate = "",
    this.pickupTime = "",
    this.pickupAddress = "",
    this.additionalFacility = const <FacilityModel>[],
    this.bookingType = "",
    this.additionalInfo = "",
    this.price = 0.0,
    this.totalAmount = 0.0,
  });

  /* factory BookBoardingReq.fromJson(Map<String, dynamic> json) {
    return BookBoardingReq(
      id: json['id'] is int ? json['id'] : -1,
      systemServiceId: json['system_service_id'] is int ? json['system_service_id'] : -1,
      petId: json['pet_id'] is int ? json['pet_id'] : -1,
      dropoffDateTime: json['dropoff_date_time'] is String ? json['dropoff_date_time'] : "",
      dropoffAddress: json['dropoff_address'] is String ? json['dropoff_address'] : "",
      pickupDateTime: json['pickup_date_time'] is String ? json['pickup_date_time'] : "",
      pickupAddress: json['pickup_address'] is String ? json['pickup_address'] : "",
      additionalFacility: json['data'] is List ? List<FacilityModel>.from(json['data'].map((x) => FacilityModel.fromJson(x))) : [],
      bookingType: json['booking_type'] is String ? json['booking_type'] : "",
      price: json['price'] is num ? json['price'] : 0,
    );
  } */

  Map<String, dynamic> toJson() {
    return {
      'id': id.isNegative ? "" : id,
      'system_service_id': systemServiceId,
      'pet_id': petId,
      if (!employeeId.isNegative) 'employee_id': employeeId,
      'dropoff_date_time': "$dropoffDate $dropoffTime".trim(),
      'dropoff_address': dropoffAddress.trim(),
      'pickup_date_time': "$pickupDate $pickupTime".trim(),
      'pickup_address': pickupAddress.trim(),
      'additional_facility': jsonEncode(additionalFacility.map((e) => e.toJson()).toList()),
      'note': additionalInfo.trim(),
      'price': price,
      'total_amount': totalAmount,
      'booking_type': ServicesKeyConst.boarding,
    };
  }
}
