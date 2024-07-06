import 'logistic_zone_response.dart';

class CityListResponse {
  bool status;
  List<CityData> data;
  String message;

  CityListResponse({
    this.status = false,
    this.data = const <CityData>[],
    this.message = "",
  });

  factory CityListResponse.fromJson(Map<String, dynamic> json) {
    return CityListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<CityData>.from(json['data'].map((x) => CityData.fromJson(x))) : [],
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
