class PetTypeRes {
  bool status;
  List<ChoosePetModel> data;
  String message;

  PetTypeRes({
    this.status = false,
    this.data = const <ChoosePetModel>[],
    this.message = "",
  });

  factory PetTypeRes.fromJson(Map<String, dynamic> json) {
    return PetTypeRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List
          ? List<ChoosePetModel>.from(json['data'].map((x) => ChoosePetModel.fromJson(x)))
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

class ChoosePetModel {
  int id;
  String name;
  String pettypeImage;
  String slug;
  int status;

  ChoosePetModel({
    this.id = -1,
    this.name = "",
    this.pettypeImage = "",
    this.slug = "",
    this.status = -1,
  });

  factory ChoosePetModel.fromJson(Map<String, dynamic> json) {
    return ChoosePetModel(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      pettypeImage:
          json['pettype_image'] is String ? json['pettype_image'] : "",
      slug: json['slug'] is String ? json['slug'] : "",
      status: json['status'] is int ? json['status'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'pettype_image': pettypeImage,
      'slug': slug,
      'status': status,
    };
  }
}
