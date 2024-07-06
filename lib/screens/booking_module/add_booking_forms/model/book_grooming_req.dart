import '../../../../utils/constants.dart';

class BookGroomingReq {
  int id;
  int systemServiceId;
  int petId;
  int employeeId;
  int groomServiceId;
  String serviceName;
  String date;
  String time;
  String duration;
  String bookingType;
  num price;
  num totalAmount;
  String additionalInfo;

  BookGroomingReq({
    this.id = -1,
    this.systemServiceId = -1,
    this.petId = -1,
    this.employeeId = -1,
    this.groomServiceId = -1,
    this.serviceName = "",
    this.date = "",
    this.time = "",
    this.duration = "",
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
    );
  } */

  Map<String, dynamic> toJson() {
    return {
      'id': id.isNegative ? "" : id,
      'system_service_id': systemServiceId,
      'pet_id': petId,
      'date_time': "$date $time".trim(),
      'duration': duration,
      if (!employeeId.isNegative) 'employee_id': employeeId,
      'service_id': groomServiceId,
      'service_name': serviceName,
      // 'address': address.trim(),
      'note': additionalInfo.trim(),
      'price': price,
      'total_amount': totalAmount,
      'booking_type': ServicesKeyConst.grooming,
    };
  }
}
