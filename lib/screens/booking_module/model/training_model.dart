class TrainingRes {
  bool status;
  List<TrainingModel> data;
  String message;

  TrainingRes({
    this.status = false,
    this.data = const <TrainingModel>[],
    this.message = "",
  });

  factory TrainingRes.fromJson(Map<String, dynamic> json) {
    return TrainingRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<TrainingModel>.from(json['data'].map((x) => TrainingModel.fromJson(x))) : [],
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

class TrainingModel {
  int id;
  String name;
  String slug;
  String description;
  int status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

  TrainingModel({
    this.id = -1,
    this.name = "",
    this.slug = "",
    this.description = "",
    this.status = -1,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
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
