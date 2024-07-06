class BreedRes {
  bool status;
  List<BreedModel> data;
  String message;

  BreedRes({
    this.status = false,
    this.data = const <BreedModel>[],
    this.message = "",
  });

  factory BreedRes.fromJson(Map<String, dynamic> json) {
    return BreedRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<BreedModel>.from(json['data'].map((x) => BreedModel.fromJson(x))) : [],
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

class BreedModel {
  int id;
  String name;
  String pettype;
  String description;
  int status;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;

  BreedModel({
    this.id = -1,
    this.name = "",
    this.pettype = "",
    this.description = "",
    this.status = -1,
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      pettype: json['pettype'] is String ? json['pettype'] : "",
      description: json['description'] is String ? json['description'] : "",
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pettype': pettype,
      'description': description,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
    };
  }
}
