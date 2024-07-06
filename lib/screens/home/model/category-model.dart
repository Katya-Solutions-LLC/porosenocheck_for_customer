class CategoryRes {
  bool status;
  List<CategoryModel> data;
  String message;
  CategoryRes({
    this.status = false,
    this.data = const <CategoryModel>[],
    this.message = "",
  });

  factory CategoryRes.fromJson(Map<String, dynamic> json) {
    return CategoryRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<CategoryModel>.from(json['data'].map((x) => CategoryModel.fromJson(x))) : [],
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

class CategoryModel {
  int id;
  String slug;
  String name;
  dynamic parentId;
  int brandId;
  int status;
  dynamic categoryImage;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  CategoryModel({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.parentId,
    this.brandId = -1,
    this.status = -1,
    this.categoryImage,
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      parentId: json['parent_id'],
      brandId: json['brand_id'] is int ? json['brand_id'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      categoryImage: json['category_image'],
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
      'parent_id': parentId,
      'brand_id': brandId,
      'status': status,
      'category_image': categoryImage,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
