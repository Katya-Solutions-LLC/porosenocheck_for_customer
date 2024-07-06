import 'package:get/get.dart';

class FacilityRes {
  bool status;
  List<FacilityModel> data;
  String message;

  FacilityRes({
    this.status = false,
    this.data = const <FacilityModel>[],
    this.message = "",
  });

  factory FacilityRes.fromJson(Map<String, dynamic> json) {
    return FacilityRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<FacilityModel>.from(json['data'].map((x) => FacilityModel.fromJson(x))) : [],
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

class FacilityModel {
  int id;
  String name;
  String slug;
  String description;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  int status;
  RxBool isChecked = false.obs;

  FacilityModel({
    this.id = -1,
    this.name = "",
    this.slug = "",
    this.description = "",
    this.status = -1,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory FacilityModel.fromJson(Map<String, dynamic> json) {
    return FacilityModel(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      slug: json['slug'] is String ? json['slug'] : "",
      description: json['description'] is String ? json['description'] : "",
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
    };
  }
}
