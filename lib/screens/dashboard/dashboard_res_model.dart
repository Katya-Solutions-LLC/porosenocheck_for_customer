import 'package:porosenocheck/screens/pet_sitter/pet_sitter_model.dart';

import '../booking_module/model/booking_data_model.dart';
import '../booking_module/model/save_payment_req.dart';
import '../shop/shop_dashboard/model/product_list_response.dart';

class DashboardRes {
  bool status;
  DashboardData data;
  String message;

  DashboardRes({
    this.status = false,
    required this.data,
    this.message = "",
  });

  factory DashboardRes.fromJson(Map<String, dynamic> json) {
    return DashboardRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is Map ? DashboardData.fromJson(json['data']) : DashboardData(upcommingBooking: BookingDataModel(service: SystemService(), payment: PaymentDetails(), training: Training())),
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class DashboardData {
  List<SystemService> systemService;
  List<Slider> slider;
  List<PetDaycareAmount> petDaycareAmount;
  List<PetBoardingAmount> petBoardingAmount;
  List<TaxPercentage> taxPercentage;
  List<PetEvent> event;
  List<Blog> blog;
  List<ProductItemData> featuresProduct;
  List<UnitModel> weightUnit;
  List<UnitModel> heightUnit;
  List<PetSitterItem> petSitter;
  BookingDataModel upcommingBooking;
  num notificationCount;

  DashboardData({
    this.systemService = const <SystemService>[],
    this.slider = const <Slider>[],
    this.petDaycareAmount = const <PetDaycareAmount>[],
    this.petBoardingAmount = const <PetBoardingAmount>[],
    this.taxPercentage = const <TaxPercentage>[],
    this.event = const <PetEvent>[],
    this.featuresProduct = const <ProductItemData>[],
    this.blog = const <Blog>[],
    this.weightUnit = const <UnitModel>[],
    this.heightUnit = const <UnitModel>[],
    this.petSitter = const <PetSitterItem>[],
    required this.upcommingBooking,
    this.notificationCount = 0,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      systemService: json['system_service'] is List ? List<SystemService>.from(json['system_service'].map((x) => SystemService.fromJson(x))) : [],
      slider: json['slider'] is List ? List<Slider>.from(json['slider'].map((x) => Slider.fromJson(x))) : [],
      petDaycareAmount: json['pet_daycare_amount'] is List ? List<PetDaycareAmount>.from(json['pet_daycare_amount'].map((x) => PetDaycareAmount.fromJson(x))) : [],
      petBoardingAmount: json['pet_boarding_amount'] is List ? List<PetBoardingAmount>.from(json['pet_boarding_amount'].map((x) => PetBoardingAmount.fromJson(x))) : [],
      taxPercentage: json['tax'] is List ? List<TaxPercentage>.from(json['tax'].map((x) => TaxPercentage.fromJson(x))) : [],
      event: json['event'] is List ? List<PetEvent>.from(json['event'].map((x) => PetEvent.fromJson(x))) : [],
      featuresProduct: json['featuresProduct'] is List ? List<ProductItemData>.from(json['featuresProduct'].map((x) => ProductItemData.fromJson(x))) : [],
      blog: json['blog'] is List ? List<Blog>.from(json['blog'].map((x) => Blog.fromJson(x))) : [],
      weightUnit: json['weight_unit'] is List ? List<UnitModel>.from(json['weight_unit'].map((x) => UnitModel.fromJson(x))) : [],
      heightUnit: json['height_unit'] is List ? List<UnitModel>.from(json['height_unit'].map((x) => UnitModel.fromJson(x))) : [],
      petSitter: json['pet_sitter'] is List ? List<PetSitterItem>.from(json['pet_sitter'].map((x) => PetSitterItem.fromJson(x))) : [],
      upcommingBooking: json['upcomming_booking'] is Map ? BookingDataModel.fromJson(json['upcomming_booking']) : BookingDataModel(service: SystemService(), payment: PaymentDetails(), training: Training()),
      notificationCount: json['notification_count'] is num ? json['notification_count'] : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'system_service': systemService.map((e) => e.toJson()).toList(),
      'slider': slider.map((e) => e.toJson()).toList(),
      'pet_daycare_amount': petDaycareAmount.map((e) => e.toJson()).toList(),
      'pet_boarding_amount': petBoardingAmount.map((e) => e.toJson()).toList(),
      'tax': taxPercentage.map((e) => e.toJson()).toList(),
      'event': event.map((e) => e.toJson()).toList(),
      'featuresProduct': featuresProduct.map((e) => e.toJson()).toList(),
      'blog': blog.map((e) => e.toJson()).toList(),
      'upcomming_booking': upcommingBooking.toJson(),
      'notification_count': notificationCount,
    };
  }
}

class SystemService {
  int id;
  String slug;
  String name;
  String description;
  int status;
  String serviceImage;
  num serviceAmount;

  SystemService({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.description = "",
    this.status = -1,
    this.serviceImage = "",
    this.serviceAmount = 0,
  });

  factory SystemService.fromJson(Map<String, dynamic> json) {
    return SystemService(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      description: json['description'] is String ? json['description'] : "",
      status: json['status'] is int ? json['status'] : -1,
      serviceImage: json['service_image'] is String ? json['service_image'] : "",
      serviceAmount: json['service_amount'] is num ? json['service_amount'] : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'description': description,
      'status': status,
      'service_image': serviceImage,
      'service_amount': serviceAmount,
    };
  }
}

class Slider {
  int id;
  String name;
  String desc;
  int status;
  String type;
  String link;
  int linkId;
  String sliderImage;

  Slider({
    this.id = -1,
    this.name = "",
    this.desc = "",
    this.status = -1,
    this.type = "",
    this.link = "",
    this.linkId = -1,
    this.sliderImage = "",
  });

  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      desc: json['description'] is String ? json['description'] : "",
      status: json['status'] is int ? json['status'] : -1,
      type: json['type'] is String ? json['type'] : "",
      link: json['link'] is String ? json['link'] : "",
      linkId: json['link_id'] is int ? json['link_id'] : -1,
      sliderImage: json['slider_image'] is String ? json['slider_image'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': desc,
      'status': status,
      'type': type,
      'link': link,
      'link_id': linkId,
      'slider_image': sliderImage,
    };
  }
}

class PetDaycareAmount {
  int id;
  String name;
  String val;
  String type;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  PetDaycareAmount({
    this.id = -1,
    this.name = "",
    this.val = "",
    this.type = "",
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory PetDaycareAmount.fromJson(Map<String, dynamic> json) {
    return PetDaycareAmount(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      val: json['val'] is String ? json['val'] : "",
      type: json['type'] is String ? json['type'] : "",
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'] is String ? json['deleted_by'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'val': val,
      'type': type,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class PetBoardingAmount {
  int id;
  String name;
  String val;
  String type;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  PetBoardingAmount({
    this.id = -1,
    this.name = "",
    this.val = "",
    this.type = "",
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory PetBoardingAmount.fromJson(Map<String, dynamic> json) {
    return PetBoardingAmount(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      val: json['val'] is String ? json['val'] : "",
      type: json['type'] is String ? json['type'] : "",
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
      'name': name,
      'val': val,
      'type': type,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class PetEvent {
  int id;
  String date;
  String name;
  int organizerId;
  String organizerName;
  String organizerEmail;
  String organizerContactNo;
  String organizerImage;
  String description;
  String eventDateTime;
  String location;
  int status;
  String image;
  String createdBy;
  String updatedBy;
  String deletedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;
  List<PetEvent> youMayAlsoLikeEvent;

  PetEvent({
    this.id = -1,
    this.date = "",
    this.name = "",
    this.organizerId = -1,
    this.organizerName = "",
    this.organizerEmail = "",
    this.organizerContactNo = "",
    this.organizerImage = "",
    this.description = "",
    this.eventDateTime = "",
    this.location = "",
    this.status = -1,
    this.image = "",
    this.createdBy = "",
    this.updatedBy = "",
    this.deletedBy = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
    this.youMayAlsoLikeEvent = const <PetEvent>[],
  });

  factory PetEvent.fromJson(Map<String, dynamic> json) {
    return PetEvent(
      id: json['id'] is int ? json['id'] : -1,
      date: json['date'] is String ? json['date'] : "",
      name: json['name'] is String ? json['name'] : "",
      organizerId: json['organizer_id'] is int ? json['organizer_id'] : -1,
      organizerName: json['organizer_name'] is String ? json['organizer_name'] : "",
      organizerEmail: json['organizer_email'] is String ? json['organizer_email'] : "",
      organizerContactNo: json['organizer_contact_no'] is String ? json['organizer_contact_no'] : "",
      organizerImage: json['organizer_image'] is String ? json['organizer_image'] : "",
      description: json['description'] is String ? json['description'] : "",
      eventDateTime: json['event_date_time'] is String ? json['event_date_time'] : "",
      location: json['location'] is String ? json['location'] : "",
      status: json['status'] is int ? json['status'] : -1,
      image: json['image'] is String ? json['image'] : "",
      createdBy: json['created_by'] is String ? json['created_by'] : "",
      updatedBy: json['updated_by'] is String ? json['updated_by'] : "",
      deletedBy: json['deleted_by'] is String ? json['deleted_by'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'name': name,
      'organizer_id': organizerId,
      'organizer_name': organizerName,
      'organizer_email': organizerEmail,
      'organizer_contact_no': organizerContactNo,
      'organizer_image': organizerImage,
      'description': description,
      'event_date_time': eventDateTime,
      'location': location,
      'status': status,
      'image': image,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class Blog {
  int id;
  String description;
  String name;
  String tags;
  int status;
  String blogImage;
  int createdBy;
  int updatedBy;
  String deletedBy;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Blog({
    this.id = -1,
    this.description = "",
    this.name = "",
    this.tags = "",
    this.status = -1,
    this.blogImage = "",
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy = "",
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt = "",
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'] is int ? json['id'] : -1,
      description: json['description'] is String ? json['description'] : "",
      name: json['name'] is String ? json['name'] : "",
      tags: json['tags'] is String ? json['tags'] : "",
      status: json['status'] is int ? json['status'] : -1,
      blogImage: json['blog_image'] is String ? json['blog_image'] : "",
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'] is String ? json['deleted_by'] : "",
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'] is String ? json['deleted_at'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'name': name,
      'tags': tags,
      'status': status,
      'blog_image': blogImage,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class UnitModel {
  int id;
  String name;
  String type;
  String value;
  int sequence;
  dynamic subType;
  int status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  UnitModel({
    this.id = -1,
    this.name = "",
    this.type = "",
    this.value = "",
    this.sequence = -1,
    this.subType,
    this.status = -1,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] is int ? json['id'] : -1,
      name: json['name'] is String ? json['name'] : "",
      type: json['type'] is String ? json['type'] : "",
      value: json['value'] is String ? json['value'] : "",
      sequence: json['sequence'] is int ? json['sequence'] : -1,
      subType: json['sub_type'],
      status: json['status'] is int ? json['status'] : -1,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'value': value,
      'sequence': sequence,
      'sub_type': subType,
      'status': status,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
