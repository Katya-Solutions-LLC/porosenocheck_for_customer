class WalkingDurationRes {
  bool status;
  List<DurationData> data;
  String message;

  WalkingDurationRes({
    this.status = false,
    this.data = const <DurationData>[],
    this.message = "",
  });

  factory WalkingDurationRes.fromJson(Map<String, dynamic> json) {
    return WalkingDurationRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List
          ? List<DurationData>.from(json['data'].map((x) => DurationData.fromJson(x)))
          : [],
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

class DurationData {
  int id;
  String duration;
  num price;
  dynamic type;
  int status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

  DurationData({
    this.id = -1,
    this.duration = "",
    this.price = -1,
    this.type,
    this.status = -1,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory DurationData.fromJson(Map<String, dynamic> json) {
    return DurationData(
      id: json['id'] is int ? json['id'] : -1,
      duration: json['duration'] is String ? json['duration'] : "",
      price: json['price'] is num ? json['price'] : 0,
      type: json['type'],
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'duration': duration,
      'price': price,
      'type': type,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
    };
  }
}
