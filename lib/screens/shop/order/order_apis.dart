import 'dart:convert';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../models/base_response_model.dart';
import '../../../network/network_utils.dart';
import '../../../utils/api_end_points.dart';
import '../../../utils/constants.dart';
import '../cart/model/cart_list_model.dart';
import 'model/order_detail_model.dart';
import 'model/order_list_model.dart';
import 'model/order_status_model.dart';

class OrderApis {
  static Future<BaseResponseModel> placeOrderAPI(Map request) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.placeOrder, request: request, method: HttpMethodType.POST)));
  }

  static Future<OrderStatusModel> getOrderFilterStatus() async {
    return OrderStatusModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getOrderStatusList, method: HttpMethodType.GET)));
  }

  static Future<dynamic> updateOrderReview({
    List<XFile>? files,
    String reviewId = '',
    String productId = '',
    String employeeId = '',
    String productVariationId = '',
    String rating = '',
    String reviewMsg = '',
    Function(dynamic)? onSuccess,
  }) async {
    MultipartRequest multiPartRequest = await getMultiPartRequest(reviewId.isNotEmpty ? APIEndPoints.updateReview : APIEndPoints.addReview);

    if (reviewId.isNotEmpty) multiPartRequest.fields[ProductModelKey.reviewId] = reviewId;
    if (productId.isNotEmpty) multiPartRequest.fields[ProductModelKey.productId] = productId;
    if (employeeId.isNotEmpty) multiPartRequest.fields[ProductModelKey.employeeId] = employeeId;
    if (productVariationId.isNotEmpty) multiPartRequest.fields[ProductModelKey.productVariationId] = productVariationId;
    if (rating.isNotEmpty) multiPartRequest.fields["rating"] = rating;
    if (reviewMsg.isNotEmpty) multiPartRequest.fields["review_msg"] = reviewMsg;

    if (files.validate().isNotEmpty) {
      multiPartRequest.files.addAll(await getMultipartImages2(files: files.validate(), name: 'gallery'));
      // multiPartRequest.fields['attachment_count'] = files.validate().length.toString();
    }

    log("Multipart ${jsonEncode(multiPartRequest.fields)}");
    log("Multipart Images ${multiPartRequest.files.map((e) => e.filename)}");

    multiPartRequest.headers.addAll(buildHeaderTokens());

    await sendMultiPartRequest(
      multiPartRequest,
      onSuccess: (data) async {
        onSuccess?.call(data);
      },
      onError: (error) {
        throw error;
      },
    ).catchError((error) {
      throw error;
    });
  }

  static Future<BaseResponseModel> deleteOrderReview({required int id}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.removeReview}?review_id=$id', method: HttpMethodType.GET)));
  }

  static Future<BaseResponseModel> updateDeliveryStatus({required Map request}) async {
    return BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.updateDeliveryStatus, request: request, method: HttpMethodType.POST)));
  }

  static Future<OrderDetailModel> getOrderDetail({required int orderId, required int orderItemId, String noteId = ""}) async {
    String notificationId = noteId.isNotEmpty ? '&notification_id=$noteId' : '';
    return OrderDetailModel.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getOrderDetails}?order_id=$orderId&order_item_id=$orderItemId$notificationId', method: HttpMethodType.GET)));
  }

  static Future<List<CartListData>> getOrderList({
    required String filterByStatus,
    int page = 1,
    int perPage = Constants.perPageItem,
    required List<CartListData> orders,
    Function(bool)? lastPageCallBack,
  }) async {
    String statusFilter = filterByStatus.isNotEmpty ? '&delivery_status=$filterByStatus' : '';
    final orderRes = OrderListModel.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getOrderList}?page=$page&per_page=$perPage$statusFilter", method: HttpMethodType.GET)));
    if (page == 1) orders.clear();
    orders.addAll(orderRes.data.validate());

    lastPageCallBack?.call(orderRes.data.validate().length != perPage);

    return orders;
  }
}
