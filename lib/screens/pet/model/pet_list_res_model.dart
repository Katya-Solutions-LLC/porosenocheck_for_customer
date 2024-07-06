import 'pet_note_model.dart';

class PetListRes {
  bool status;
  List<PetData> data;
  String message;

  PetListRes({
    this.status = false,
    this.data = const <PetData>[],
    this.message = "",
  });

  factory PetListRes.fromJson(Map<String, dynamic> json) {
    return PetListRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<PetData>.from(json['data'].map((x) => PetData.fromJson(x))) : [],
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

class PetData {
  int id;
  String name;
  String slug;
  String pettype;
  String gender;
  String breed;
  int breedId;
  dynamic size;
  String petImage;
  String dateOfBirth;
  String age;
  num weight;
  String weightUnit;
  num height;
  String heightUnit;
  int userId;
  int status;
  int createdBy;
  int updatedBy;
  int deletedBy;
  List<NotePetModel> petNotes;

  PetData({
    this.id = -1,
    this.name = "",
    this.slug = "",
    this.pettype = "",
    this.gender = "",
    this.breed = "",
    this.breedId = -1,
    this.size,
    this.petImage = "",
    this.dateOfBirth = "",
    this.age = "",
    this.weight = 0,
    this.weightUnit = "",
    this.height = 0,
    this.heightUnit = "",
    this.userId = -1,
    this.status = -1,
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy = -1,
    this.petNotes = const <NotePetModel>[],
  });

  factory PetData.fromJson(Map<String, dynamic> json) {
    return PetData(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      slug: json['slug'] is String ? json['slug'] : "",
      pettype: json['pettype'] is String ? json['pettype'] : "",
      gender: json['gender'] is String ? json['gender'] : "",
      breed: json['breed'] is String ? json['breed'] : "",
      breedId: json['breed_id'] is int ? json['breed_id'] : -1,
      size: json['size'],
      petImage: json['pet_image'] is String ? json['pet_image'] : "",
      dateOfBirth: json['date_of_birth'] is String ? json['date_of_birth'] : "",
      age: json['age'] is String ? json['age'] : "",
      weight: json['weight'] is num ? json['weight'] : 0,
      weightUnit: json['weight_unit'] is String ? json['weight_unit'] : "",
      height: json['height'] is num ? json['height'] : 0,
      heightUnit: json['height_unit'] is String ? json['height_unit'] : "",
      userId: json['user_id'] is int ? json['user_id'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'] is int ? json['deleted_by'] : -1,
      petNotes: json['pet_notes'] is List ? List<NotePetModel>.from(json['pet_notes'].map((x) => NotePetModel.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'pettype': pettype,
      'gender': gender,
      'breed': breed,
      'breed_id': breedId,
      'size': size,
      'pet_image': petImage,
      'date_of_birth': dateOfBirth,
      'age': age,
      'weight': weight,
      'weight_unit': weightUnit,
      'height': height,
      'height_unit': heightUnit,
      'user_id': userId,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'pet_notes': petNotes.map((e) => e.toJson()).toList(),
    };
  }
}
