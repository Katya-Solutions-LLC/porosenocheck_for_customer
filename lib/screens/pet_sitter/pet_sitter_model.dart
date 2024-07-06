class PetSitterItem {
  int id;
  String firstName;
  String lastName;
  String email;
  String mobile;
  dynamic loginType;
  dynamic playerId;
  dynamic webPlayerId;
  String gender;
  dynamic dateOfBirth;
  int isManager;
  int showInCalender;
  String emailVerifiedAt;
  dynamic avatar;
  int isBanned;
  int isSubscribe;
  int status;
  dynamic lastNotificationSeen;
  dynamic userSetting;
  dynamic address;
  String userType;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String latitude;
  String longitude;
  String fullName;
  String profileImage;
  List<Media> media;

  PetSitterItem({
    this.id = -1,
    this.firstName = "",
    this.lastName = "",
    this.email = "",
    this.mobile = "",
    this.loginType,
    this.playerId,
    this.webPlayerId,
    this.gender = "",
    this.dateOfBirth,
    this.isManager = -1,
    this.showInCalender = -1,
    this.emailVerifiedAt = "",
    this.avatar,
    this.isBanned = -1,
    this.isSubscribe = -1,
    this.status = -1,
    this.lastNotificationSeen,
    this.userSetting,
    this.address,
    this.userType = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
    this.latitude = "",
    this.longitude = "",
    this.fullName = "",
    this.profileImage = "",
    this.media = const <Media>[],
  });

  factory PetSitterItem.fromJson(Map<String, dynamic> json) {
    return PetSitterItem(
      id: json['id'] is int ? json['id'] : -1,
      firstName: json['first_name'] is String ? json['first_name'] : "",
      lastName: json['last_name'] is String ? json['last_name'] : "",
      email: json['email'] is String ? json['email'] : "",
      mobile: json['mobile'] is String ? json['mobile'] : "",
      loginType: json['login_type'],
      playerId: json['player_id'],
      webPlayerId: json['web_player_id'],
      gender: json['gender'] is String ? json['gender'] : "",
      dateOfBirth: json['date_of_birth'],
      isManager: json['is_manager'] is int ? json['is_manager'] : -1,
      showInCalender:
          json['show_in_calender'] is int ? json['show_in_calender'] : -1,
      emailVerifiedAt:
          json['email_verified_at'] is String ? json['email_verified_at'] : "",
      avatar: json['avatar'],
      isBanned: json['is_banned'] is int ? json['is_banned'] : -1,
      isSubscribe: json['is_subscribe'] is int ? json['is_subscribe'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      lastNotificationSeen: json['last_notification_seen'],
      userSetting: json['user_setting'],
      address: json['address'],
      userType: json['user_type'] is String ? json['user_type'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
      latitude: json['latitude'] is String ? json['latitude'] : "",
      longitude: json['longitude'] is String ? json['longitude'] : "",
      fullName: json['full_name'] is String ? json['full_name'] : "",
      profileImage:
          json['profile_image'] is String ? json['profile_image'] : "",
      media: json['media'] is List
          ? List<Media>.from(json['media'].map((x) => Media.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'login_type': loginType,
      'player_id': playerId,
      'web_player_id': webPlayerId,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'is_manager': isManager,
      'show_in_calender': showInCalender,
      'email_verified_at': emailVerifiedAt,
      'avatar': avatar,
      'is_banned': isBanned,
      'is_subscribe': isSubscribe,
      'status': status,
      'last_notification_seen': lastNotificationSeen,
      'user_setting': userSetting,
      'address': address,
      'user_type': userType,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'latitude': latitude,
      'longitude': longitude,
      'full_name': fullName,
      'profile_image': profileImage,
      'media': media.map((e) => e.toJson()).toList(),
    };
  }
}

class Media {
  int id;
  String modelType;
  int modelId;
  String uuid;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String conversionsDisk;
  int size;
  List<dynamic> manipulations;
  List<dynamic> customProperties;
  List<dynamic> generatedConversions;
  List<dynamic> responsiveImages;
  int orderColumn;
  String createdAt;
  String updatedAt;
  String originalUrl;
  String previewUrl;

  Media({
    this.id = -1,
    this.modelType = "",
    this.modelId = -1,
    this.uuid = "",
    this.collectionName = "",
    this.name = "",
    this.fileName = "",
    this.mimeType = "",
    this.disk = "",
    this.conversionsDisk = "",
    this.size = -1,
    this.manipulations = const [],
    this.customProperties = const [],
    this.generatedConversions = const [],
    this.responsiveImages = const [],
    this.orderColumn = -1,
    this.createdAt = "",
    this.updatedAt = "",
    this.originalUrl = "",
    this.previewUrl = "",
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'] is int ? json['id'] : -1,
      modelType: json['model_type'] is String ? json['model_type'] : "",
      modelId: json['model_id'] is int ? json['model_id'] : -1,
      uuid: json['uuid'] is String ? json['uuid'] : "",
      collectionName:
          json['collection_name'] is String ? json['collection_name'] : "",
      name: json['name'] is String ? json['name'] : "",
      fileName: json['file_name'] is String ? json['file_name'] : "",
      mimeType: json['mime_type'] is String ? json['mime_type'] : "",
      disk: json['disk'] is String ? json['disk'] : "",
      conversionsDisk:
          json['conversions_disk'] is String ? json['conversions_disk'] : "",
      size: json['size'] is int ? json['size'] : -1,
      manipulations: json['manipulations'] is List ? json['manipulations'] : [],
      customProperties:
          json['custom_properties'] is List ? json['custom_properties'] : [],
      generatedConversions: json['generated_conversions'] is List
          ? json['generated_conversions']
          : [],
      responsiveImages:
          json['responsive_images'] is List ? json['responsive_images'] : [],
      orderColumn: json['order_column'] is int ? json['order_column'] : -1,
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      originalUrl: json['original_url'] is String ? json['original_url'] : "",
      previewUrl: json['preview_url'] is String ? json['preview_url'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model_type': modelType,
      'model_id': modelId,
      'uuid': uuid,
      'collection_name': collectionName,
      'name': name,
      'file_name': fileName,
      'mime_type': mimeType,
      'disk': disk,
      'conversions_disk': conversionsDisk,
      'size': size,
      'manipulations': [],
      'custom_properties': [],
      'generated_conversions': [],
      'responsive_images': [],
      'order_column': orderColumn,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'original_url': originalUrl,
      'preview_url': previewUrl,
    };
  }
}
