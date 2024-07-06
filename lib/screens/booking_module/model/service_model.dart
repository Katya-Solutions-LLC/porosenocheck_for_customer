class ServiceRes {
  bool status;
  List<ServiceModel> data;
  String message;

  ServiceRes({
    this.status = false,
    this.data = const <ServiceModel>[],
    this.message = "",
  });

  factory ServiceRes.fromJson(Map<String, dynamic> json) {
    return ServiceRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<ServiceModel>.from(json['data'].map((x) => ServiceModel.fromJson(x))) : [],
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

class ServiceModel {
  int id;
  String slug;
  String name;
  String description;
  int durationMin;
  num defaultPrice;
  int status;
  int categoryId;
  String categoryName;
  int subCategoryId;
  String serviceImage;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  ServiceModel({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.description = "",
    this.durationMin = -1,
    this.defaultPrice = -1,
    this.status = -1,
    this.categoryId = -1,
    this.categoryName = "",
    this.subCategoryId = -1,
    this.serviceImage = "",
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      description: json['description'] is String ? json['description'] : "",
      durationMin: json['duration_min'] is int ? json['duration_min'] : -1,
      defaultPrice: json['default_price'] is num ? json['default_price'] : 0,
      status: json['status'] is int ? json['status'] : -1,
      categoryId: json['category_id'] is int ? json['category_id'] : -1,
      categoryName: json['category_name'] is String ? json['category_name'] : "",
      subCategoryId: json['sub_category_id'] is int ? json['sub_category_id'] : -1,
      serviceImage: json['service_image'] is String ? json['service_image'] : "",
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      'duration_min': durationMin,
      'default_price': defaultPrice,
      'status': status,
      'category_id': categoryId,
      'category_name': categoryName,
      'sub_category_id': subCategoryId,
      'service_image': serviceImage,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
