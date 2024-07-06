import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/base_response_model.dart';
import '../../../network/network_utils.dart';
import '../../../utils/api_end_points.dart';
import '../../../utils/app_common.dart';
import '../../pet/model/breed_model.dart';
import 'package:http/http.dart' as http;
import '../../shop/model/category_model.dart';
import '../model/employe_model.dart';
import '../model/facilities_model.dart';
import '../model/save_booking_res.dart';
import '../model/service_model.dart';
import '../model/training_model.dart';
import '../model/walking_model.dart';

class PetServiceFormApis {
  static Future<List<FacilityModel>> getFacility() async {
    final facilityRes = FacilityRes.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getFacility, method: HttpMethodType.GET)));
    return facilityRes.data;
  }

  static Future<TrainingRes> getTraining({String search = ""}) async {
    String searchTraining = search.isNotEmpty ? '?search=$search' : '';
    return TrainingRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getTraining}$searchTraining", method: HttpMethodType.GET)));
  }

  static Future<ServiceRes> getService({required String type, String search = "", String? categoryId}) async {
    String categoryIdParam = categoryId != null ? '&category_id=$categoryId' : "";
    String searchService = search.isNotEmpty ? '&search=$search' : '';
    return ServiceRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getService}?type=$type$categoryIdParam$searchService", method: HttpMethodType.GET)));
  }

  static Future<EmployeeRes> getEmployee({
    int page = 1,
    int perPage = 50,
    required String role,
    String search = "",
    String? serviceId,
    String latitude = "",
    String longitude = "",
    bool showNearby = false,
  }) async {
    String serviceIdParam = serviceId != null ? '&service_ids=$serviceId' : "";
    String searchEmployee = search.isNotEmpty ? '&search=$search' : '';
    String lat = '';
    String long = '';

    if (showNearby) {
      lat = latitude.trim().isNotEmpty ? '&latitude=$latitude' : "";
      long = longitude.trim().isNotEmpty ? '&longitude=$longitude' : "";
    }
    return EmployeeRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getEmployeeList}?per_page=$perPage&page=$page&type=$role$serviceIdParam$searchEmployee$lat$long", method: HttpMethodType.GET)));
  }

  static Future<RxList<EmployeeModel>> getPetSitters({
    int page = 1,
    int perPage = 10,
    required List<EmployeeModel> petSittersList,
    Function(bool)? lastPageCallBack,
    required String role,
    String search = "",
    String? serviceId,
    String latitude = "",
    String longitude = "",
    bool showNearby = false,
  }) async {
    String serviceIdParam = serviceId != null ? '&service_ids=$serviceId' : "";
    String searchEmployee = search.isNotEmpty ? '&search=$search' : '';
    String lat = '';
    String long = '';

    if (showNearby) {
      lat = latitude.trim().isNotEmpty ? '&latitude=$latitude' : "";
      long = longitude.trim().isNotEmpty ? '&longitude=$longitude' : "";
    }

    final empRes = EmployeeRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getEmployeeList}?per_page=$perPage&page=$page&type=$role$serviceIdParam$searchEmployee$lat$long", method: HttpMethodType.GET)));

    if (page == 1) petSittersList.clear();
    petSittersList.addAll(empRes.data);
    lastPageCallBack?.call(empRes.data.length != perPage);

    return petSittersList.obs;
  }

  static Future<CategoryRes> getCategory({required String categoryType, String search = ""}) async {
    String searchCategory = search.isNotEmpty ? '&search=$search' : '';
    return CategoryRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getCategory}?type=$categoryType$searchCategory", method: HttpMethodType.GET)));
  }

  static Future<BreedRes> getBreed({
    required int petTypeId,
    String search = "",
    int page = 1,
    int perPage = 50,
    Function(bool)? lastPageCallBack,
  }) async {
    String searchBreed = search.isNotEmpty ? '&search=$search' : '';
    return BreedRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getBreed}?pettype_id=$petTypeId&per_page=$perPage&page=$page$searchBreed", method: HttpMethodType.GET)));
  }

  static Future<List<DurationData>> getDuration({required String serviceType}) async {
    final res = WalkingDurationRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getDuration}?type=$serviceType", method: HttpMethodType.GET)));
    return res.data;
  }

  static Future<void> bookServiceApi({required Map<String, dynamic> request, List<PlatformFile>? files, required VoidCallback onSuccess, required VoidCallback loaderOff}) async {
    var multiPartRequest = await getMultiPartRequest(APIEndPoints.saveBooking);
    multiPartRequest.fields.addAll(await getMultipartFields(val: request));

    if (files.validate().isNotEmpty) {
      multiPartRequest.files.add(await http.MultipartFile.fromPath('medical_report', files.validate().first.path.validate()));
    }

    /*  if (files.validate().isNotEmpty) {
      multiPartRequest.files.addAll(await getMultipartImages(files: files.validate(), name: 'medical_report'));
      // multiPartRequest.fields['attachment_count'] = files.validate().length.toString();
    } */

    log("Multipart ${jsonEncode(multiPartRequest.fields)}");
    log("Multipart Files ${multiPartRequest.files.map((e) => e.filename)}");
    log("Multipart Extension ${multiPartRequest.files.map((e) => e.filename!.split(".").last)}");
    multiPartRequest.headers.addAll(buildHeaderTokens());

    await sendMultiPartRequest(multiPartRequest, onSuccess: (temp) async {
      log("Response: ${jsonDecode(temp)}");
      // toast(baseResponseModel.message, print: true);
      try {
        saveBookingRes(SaveBookingRes.fromJson(jsonDecode(temp)));
      } catch (e) {
        log('SaveBookingRes.fromJson E: $e');
      }
      onSuccess.call();
    }, onError: (error) {
      toast(error.toString(), print: true);
      loaderOff.call();
    });
  }

  static Future<BaseResponseModel> savePayment({required Map request}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.savePayment, request: request, method: HttpMethodType.POST)));
  }
}
