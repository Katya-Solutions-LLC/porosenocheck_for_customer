import 'package:image_picker/image_picker.dart';

import '../../../utils/app_common.dart';

class AddPetReq {
  // int id;
  String pettypeId;
  String name;
  int breedId;
  String gender;
  String birthdate;
  String weight;
  String height;
  String weightUnit;
  String heightUnit;
  String userId;

  // Local Variable
  List<XFile>? petImages;

  AddPetReq({
    // this.id = -1,
    this.pettypeId = "",
    this.name = "",
    this.breedId = -1,
    this.gender = "",
    this.birthdate = "",
    this.weight = "",
    this.height = "",
    this.weightUnit = "",
    this.heightUnit = "",
    this.userId = "",
  });

  factory AddPetReq.fromJson(Map<String, dynamic> json) {
    return AddPetReq(
      // id: json['id'] is int ? json['id'] : -1,s
      pettypeId: json['pettype_id'] is String ? json['pettype_id'] : "",
      name: json['name'] is String ? json['name'] : "",
      breedId: json['breed'] is int ? json['breed'] : -1,
      gender: json['gender'] is String ? json['gender'] : "",
      birthdate: json['date_of_birth'] is String ? json['date_of_birth'] : "",
      weight: json['weight'] is String ? json['weight'] : "",
      height: json['height'] is String ? json['height'] : "",
      weightUnit: json['weight_unit'] is String ? json['weight_unit'] : "",
      heightUnit: json['height_unit'] is String ? json['height_unit'] : "",
      userId: json['user_id'] is String ? json['user_id'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pettype_id': pettypeId,
      'name': name,
      'breed': breedId,
      'gender': gender,
      'date_of_birth': birthdate,
      'weight': weight,
      'height': height,
      'weight_unit': weightUnit,
      'height_unit': heightUnit,
      'user_id': loginUserData.value.id,
    };
  }
}
