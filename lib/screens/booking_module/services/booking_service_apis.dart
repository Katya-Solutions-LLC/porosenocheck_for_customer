import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/app_common.dart';
import '../../../models/base_response_model.dart';
import '../model/booking_detail_res.dart';
import '../../../network/network_utils.dart';
import '../../../utils/api_end_points.dart';
import '../../../utils/constants.dart';
import '../model/booking_data_model.dart';
import '../model/review_res_model.dart';

class BookingServiceApis {
  static Future<RxList<BookingDataModel>> getBookingList({
    required String filterByStatus,
    required String filterByService,
    int page = 1,
    String search = '',
    int perPage = Constants.perPageItem,
    required List<BookingDataModel> bookings,
    Function(bool)? lastPageCallBack,
  }) async {
    String searchBooking = search.isNotEmpty ? '&search=$search' : '';
    String statusFilter = filterByStatus.isNotEmpty ? '&status=$filterByStatus' : '';
    String serviceFilter = filterByService.isNotEmpty ? '&system_service_name=$filterByService' : '';
    final bookingRes = BookingListRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getBooking}?page=$page&per_page=$perPage$statusFilter$serviceFilter$searchBooking", method: HttpMethodType.GET)));
    if (page == 1) bookings.clear();
    bookings.addAll(bookingRes.data.validate());

    lastPageCallBack?.call(bookingRes.data.validate().length != perPage);

    return bookings.obs;
  }

  static Future<BookingDetailRes> getBookingDetail({required int bookingId, String noteId = ""}) async {
    String notificationId = noteId.isNotEmpty ? '&notification_id=$noteId' : '';
    return BookingDetailRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getBookingDetail}?id=$bookingId$notificationId", method: HttpMethodType.GET)));
  }

  static Future<BaseResponseModel> updateBooking({required Map request}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.bookingUpdate, request: request, method: HttpMethodType.POST)));
  }

  static Future<BaseResponseModel> updateReview({required Map request}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.saveRating, request: request, method: HttpMethodType.POST)));
  }

  static Future<BaseResponseModel> deleteReview({required int id}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.deleteRating, request: {"id": id}, method: HttpMethodType.POST)));
  }

  static Future<EmployeeReviewRes> getEmployeeReviews({
    int? empId,
    int page = 1,
    int perPage = Constants.perPageItem,
    Function(bool)? lastPageCallBack,
  }) async {
    if (isLoggedIn.value) {
      String employeeId = empId != null ? '&employee_id=$empId' : '';
      final reviewRes = EmployeeReviewRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getRating}?per_page=$perPage&page=$page$employeeId", method: HttpMethodType.GET)));
      lastPageCallBack?.call(reviewRes.reviewData.length != perPage);
      return reviewRes;
    } else {
      return EmployeeReviewRes();
    }
  }

  static Future<List<BookingDataModel>> getBookingFilterList({
    int page = 1,
    int perPage = Constants.perPageItem,
    required List<BookingDataModel> bookings,
    Function(bool)? lastPageCallBack,
  }) async {
    String perPageQuery = '&per_page=$perPage';
    String pageQuery = '&page=$page';
    final bookingRes = BookingListRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getBooking}?$perPageQuery$pageQuery", method: HttpMethodType.GET)));
    if (page == 1) bookings.clear();
    bookings.addAll(bookingRes.data.validate());
    lastPageCallBack?.call(bookingRes.data.validate().length != perPage);

    return bookings;
  }
}
