import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/home/model/event_model.dart';

import '../../../network/network_utils.dart';
import '../../../utils/api_end_points.dart';
import '../../../utils/app_common.dart';
import '../../auth/model/notification_model.dart';
import '../../dashboard/dashboard_res_model.dart';
import '../model/about_page_res.dart';
import '../model/blog_model.dart';
import '../model/pet_center_detail.dart';
import '../model/status_list_res.dart';

class HomeServiceApis {
  static Future<DashboardRes> getDashboard() async {
    if (isLoggedIn.value) {
      return DashboardRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getDashboard}?user_id=${loginUserData.value.id}", method: HttpMethodType.GET)));
    } else {
      return DashboardRes.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getDashboard, method: HttpMethodType.GET)));
    }
  }

  static Future<AboutPageRes> getAboutPageData() async {
    return AboutPageRes.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.aboutPages, method: HttpMethodType.GET)));
  }

  static Future<StatusListRes> getAllStatusUsedForBooking({List<String>? statusList}) async {
    return StatusListRes.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.bookingStatus, method: HttpMethodType.GET)));
  }

  static Future<PetCenterRes> getPetCenterDetail() async {
    return PetCenterRes.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.petCenterDetail, method: HttpMethodType.GET)));
  }

  //event And Blog
  static Future<List<Blog>> getBlog({
    int page = 1,
    int perPage = 10,
    required List<Blog> blogs,
    Function(bool)? lastPageCallBack,
  }) async {
    final blogRes = BlogRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getBlogs}?per_page=$perPage&page=$page", method: HttpMethodType.GET)));
    if (page == 1) blogs.clear();
    blogs.addAll(blogRes.data);
    lastPageCallBack?.call(blogRes.data.length != perPage);
    return blogs;
  }

  static Future<List<PetEvent>> getEvent({
    int page = 1,
    int perPage = 10,
    required List<PetEvent> events,
    Function(bool)? lastPageCallBack,
    String latitude = "",
    String longitude = "",
    bool showNearby = false,
  }) async {
    String lat = '';
    String long = '';

    if (showNearby) {
      lat = latitude.trim().isNotEmpty ? '&latitude=$latitude' : "";
      long = longitude.trim().isNotEmpty ? '&longitude=$longitude' : "";
    }

    final eventRes = EventRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getEvents}?per_page=$perPage&page=$page$lat$long", method: HttpMethodType.GET)));
    if (page == 1) events.clear();
    events.addAll(eventRes.data);
    lastPageCallBack?.call(eventRes.data.length != perPage);
    return events;
  }

  static Future<NotificationRes> getBlogsList() async {
    return NotificationRes.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getNotification, method: HttpMethodType.GET)));
  }
}
