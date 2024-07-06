import 'package:get/get.dart';

class LogisticZoneResponse {
  bool status;
  List<LogisticZoneData> data;
  String message;

  LogisticZoneResponse({
    this.status = false,
    this.data = const <LogisticZoneData>[],
    this.message = "",
  });

  factory LogisticZoneResponse.fromJson(Map<String, dynamic> json) {
    return LogisticZoneResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<LogisticZoneData>.from(json['data'].map((x) => LogisticZoneData.fromJson(x))) : [],
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

class LogisticZoneData {
  int id;
  String name;
  int logisticId;
  String logisticName;
  int countryId;
  int stateId;
  num standardDeliveryCharge;
  num expressDeliveryCharge;
  String standardDeliveryTime;
  String expressDeliveryTime;
  List<CityData> cities;
  RxBool isLogisticCheck = false.obs;

  LogisticZoneData({
    this.id = -1,
    this.name = "",
    this.logisticId = -1,
    this.logisticName = "",
    this.countryId = -1,
    this.stateId = -1,
    this.standardDeliveryCharge = -1,
    this.expressDeliveryCharge = -1,
    this.standardDeliveryTime = "",
    this.expressDeliveryTime = "",
    this.cities = const <CityData>[],
  });

  factory LogisticZoneData.fromJson(Map<String, dynamic> json) {
    return LogisticZoneData(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      logisticId: json['logistic_id'] is int ? json['logistic_id'] : -1,
      logisticName: json['logistic_name'] is String ? json['logistic_name'] : "",
      countryId: json['country_id'] is int ? json['country_id'] : -1,
      stateId: json['state_id'] is int ? json['state_id'] : -1,
      standardDeliveryCharge: json['standard_delivery_charge'] is num ? json['standard_delivery_charge'] : 0,
      expressDeliveryCharge: json['express_delivery_charge'] is num ? json['express_delivery_charge'] : 0,
      standardDeliveryTime: json['standard_delivery_time'] is String ? json['standard_delivery_time'] : "",
      expressDeliveryTime: json['express_delivery_time'] is String ? json['express_delivery_time'] : "",
      cities: json['cities'] is List ? List<CityData>.from(json['cities'].map((x) => CityData.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logistic_id': logisticId,
      'logistic_name': logisticName,
      'country_id': countryId,
      'state_id': stateId,
      'standard_delivery_charge': standardDeliveryCharge,
      'express_delivery_charge': expressDeliveryCharge,
      'standard_delivery_time': standardDeliveryTime,
      'express_delivery_time': expressDeliveryTime,
      'cities': cities.map((e) => e.toJson()).toList(),
    };
  }
}

class CityData {
  int id;
  String name;
  int stateId;
  int status;
  int createdBy;
  int updatedBy;
  int deletedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;
  Pivot pivot;

  CityData({
    this.id = -1,
    this.name = "",
    this.stateId = -1,
    this.status = -1,
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy = -1,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
    required this.pivot,
  });

  factory CityData.fromJson(Map<String, dynamic> json) {
    return CityData(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      stateId: json['state_id'] is int ? json['state_id'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'] is int ? json['deleted_by'] : -1,
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
      pivot: json['pivot'] is Map ? Pivot.fromJson(json['pivot']) : Pivot(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'state_id': stateId,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'pivot': pivot.toJson(),
    };
  }
}

class Pivot {
  int logisticZoneId;
  int cityId;

  Pivot({
    this.logisticZoneId = -1,
    this.cityId = -1,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      logisticZoneId: json['logistic_zone_id'] is int ? json['logistic_zone_id'] : -1,
      cityId: json['city_id'] is int ? json['city_id'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'logistic_zone_id': logisticZoneId,
      'city_id': cityId,
    };
  }
}
