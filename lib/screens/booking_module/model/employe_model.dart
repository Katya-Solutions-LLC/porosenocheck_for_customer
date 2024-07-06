import 'package:get/get.dart';

class EmployeeRes {
  bool status;
  List<EmployeeModel> data;
  String message;

  EmployeeRes({
    this.status = false,
    this.data = const <EmployeeModel>[],
    this.message = "",
  });

  factory EmployeeRes.fromJson(Map<String, dynamic> json) {
    return EmployeeRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<EmployeeModel>.from(json['data'].map((x) => EmployeeModel.fromJson(x))) : [],
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

class EmployeeModel {
  int id;
  String firstName;
  String lastName;
  String fullName;
  String email;
  String mobile;
  dynamic playerId;
  String userType;
  String gender;
  dynamic expert;
  dynamic dateOfBirth;
  String emailVerifiedAt;
  int status;
  int isBanned;
  int isManager;
  int showInCalender;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  int ratingStar;
  String aboutSelf;
  dynamic facebookLink;
  dynamic instagramLink;
  dynamic twitterLink;
  dynamic dribbbleLink;
  String latitude;
  String longitude;
  num distance;
  RxString profileImage;

  EmployeeModel({
    this.id = -1,
    this.firstName = "",
    this.lastName = "",
    this.fullName = "",
    this.email = "",
    this.mobile = "",
    this.playerId,
    this.userType = "",
    this.gender = "",
    this.expert,
    this.dateOfBirth,
    this.emailVerifiedAt = "",
    this.status = -1,
    this.isBanned = -1,
    this.isManager = -1,
    this.showInCalender = -1,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
    this.ratingStar = -1,
    this.aboutSelf = "",
    this.facebookLink,
    this.instagramLink,
    this.twitterLink,
    this.dribbbleLink,
    this.latitude = "",
    this.longitude = "",
    this.distance = 0,
    required this.profileImage,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] is int ? json['id'] : -1,
      firstName: json['first_name'] is String ? json['first_name'] : "",
      lastName: json['last_name'] is String ? json['last_name'] : "",
      fullName: json['full_name'] is String ? json['full_name'] : "",
      email: json['email'] is String ? json['email'] : "",
      mobile: json['mobile'] is String ? json['mobile'] : "",
      playerId: json['player_id'],
      userType: json['user_type'] is String ? json['user_type'] : "",
      gender: json['gender'] is String ? json['gender'] : "",
      expert: json['expert'],
      dateOfBirth: json['date_of_birth'],
      emailVerifiedAt: json['email_verified_at'] is String ? json['email_verified_at'] : "",
      status: json['status'] is int ? json['status'] : -1,
      isBanned: json['is_banned'] is int ? json['is_banned'] : -1,
      isManager: json['is_manager'] is int ? json['is_manager'] : -1,
      showInCalender: json['show_in_calender'] is int ? json['show_in_calender'] : -1,
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
      ratingStar: json['rating_star'] is int ? json['rating_star'] : -1,
      aboutSelf: json['about_self'] is String ? json['about_self'] : "",
      facebookLink: json['facebook_link'],
      instagramLink: json['instagram_link'],
      twitterLink: json['twitter_link'],
      dribbbleLink: json['dribbble_link'],
      latitude: json['latitude'] is String ? json['latitude'] : "",
      longitude: json['longitude'] is String ? json['longitude'] : "",
      distance: json['distance'] is String
          ? double.tryParse(json['distance'].toString().replaceAll(",", "")) ?? 0
          : json['distance'] is num
              ? json['distance']
              : 0,
      profileImage: json['profile_image'] is String ? (json['profile_image'] as String).obs : "".obs,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'full_name': fullName,
      'email': email,
      'mobile': mobile,
      'player_id': playerId,
      'user_type': userType,
      'gender': gender,
      'expert': expert,
      'date_of_birth': dateOfBirth,
      'email_verified_at': emailVerifiedAt,
      'profile_image': profileImage,
      'status': status,
      'is_banned': isBanned,
      'is_manager': isManager,
      'show_in_calender': showInCalender,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'rating_star': ratingStar,
      'about_self': aboutSelf,
      'facebook_link': facebookLink,
      'instagram_link': instagramLink,
      'twitter_link': twitterLink,
      'dribbble_link': dribbbleLink,
      'latitude': latitude,
      'longitude': longitude,
      'distance': distance,
    };
  }
}
