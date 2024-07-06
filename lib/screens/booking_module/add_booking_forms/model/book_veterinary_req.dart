import '../../../../utils/constants.dart';

class BookVeterinaryReq {
  int id;
  int systemServiceId;
  int petId;
  int employeeId;
  int serviceId;
  String serviceName;
  int vetId;
  String date;
  String time;
  String duration;
  String bookingType;
  num price;
  num totalAmount;
  String startVideoLink;
  String joinVideoLink;
  String reason;

  BookVeterinaryReq({
    this.id = -1,
    this.systemServiceId = -1,
    this.petId = -1,
    this.employeeId = -1,
    this.serviceId = -1,
    this.serviceName = "",
    this.vetId = -1,
    this.date = "",
    this.time = "",
    this.duration = "",
    this.bookingType = "",
    this.reason = "",
    this.price = 0.0,
    this.startVideoLink = "",
    this.joinVideoLink = "",
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
      'date_time': "$date $time".trim(),
      'duration': duration,
      if (!employeeId.isNegative) 'employee_id': employeeId,
      if (!serviceId.isNegative) 'service_id': serviceId,
      'service_name': serviceName,
      'reason': reason.trim(),
      'start_video_link': startVideoLink.trim(),
      'join_video_link': joinVideoLink.trim(),
      // 'addition_information': "",
      'price': price,
      'total_amount': totalAmount,
      'booking_type': ServicesKeyConst.veterinary,
    };
  }
}
/* 
{
  'id': '',
  'system_service_id': '2',
  'pet_id': '21',
  'date_time': '2023-07-27 12:05',
  'service_id': '23',
  'price': '86',
  'employee_id': '3',
  'reason': 'ferver',
  'duration': '60',
  'booking_type': 'veterinary',
  'service_name': 'Anesthesia'
}
 */