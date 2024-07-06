import 'dart:convert';

import '../../../../utils/constants.dart';

class BookDayCareReq {
  int id;
  int systemServiceId;
  int petId;
  int employeeId;
  String date;
  String dropOfftime;
  String pickUptime;
  String address;
  List<String> food;
  List<String> activity;
  String bookingType;
  num price;
  num totalAmount;
  String additionalInfo;

  BookDayCareReq({
    this.id = -1,
    this.systemServiceId = -1,
    this.petId = -1,
    this.employeeId = -1,
    this.date = "",
    this.dropOfftime = "",
    this.pickUptime = "",
    this.address = "",
    this.food = const <String>[],
    this.activity = const <String>[],
    this.bookingType = "",
    this.additionalInfo = "",
    this.price = 0.0,
    this.totalAmount = 0.0,
  });

  /* factory WalkingReq.fromJson(Map<String, dynamic> json) {
    return WalkingReq(
      id: json['id'] is int ? json['id'] : -1,
      systemServiceId:
          json['system_service_id'] is int ? json['system_service_id'] : -1,
      petId: json['pet_id'] is int ? json['pet_id'] : -1,
      dateTime: json['date_time'] is String ? json['date_time'] : "",
      address: json['address'] is String ? json['address'] : "",
      bookingType: json['booking_type'] is String ? json['booking_type'] : "",
      price: json['price'] is int ? json['price'] : -1,
      duration: json['duration'] is String ? json['duration'] : "",
    );
  } */

  Map<String, dynamic> toJson() {
    return {
      'id': id.isNegative ? "" : id,
      'system_service_id': systemServiceId,
      'pet_id': petId,
      if (!employeeId.isNegative) 'employee_id': employeeId,
      'date': date.trim(),
      'dropoff_time': dropOfftime.trim(),
      'pickup_time': pickUptime.trim(),
      'address': address.trim(),
      'note': additionalInfo.trim(),
      'price': price,
      'total_amount': totalAmount,
      'booking_type': ServicesKeyConst.dayCare,
      'food': jsonEncode(food.map((e) => e).toList()),
      'activity': jsonEncode(activity.map((e) => e).toList()),
    };
  }
}
