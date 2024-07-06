import '../../dashboard/dashboard_res_model.dart';

class EventRes {
  bool status;
  List<PetEvent> data;
  String message;

  EventRes({
    this.status = false,
    this.data = const <PetEvent>[],
    this.message = "",
  });

  factory EventRes.fromJson(Map<String, dynamic> json) {
    return EventRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<PetEvent>.from(json['data'].map((x) => PetEvent.fromJson(x))) : [],
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
