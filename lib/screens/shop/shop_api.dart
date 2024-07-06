import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/shop/product/model/product_detail_response.dart';
import 'package:porosenocheck/screens/shop/product/model/product_review_response.dart';

import '../../network/network_utils.dart';
import '../../utils/api_end_points.dart';
import '../../utils/app_common.dart';
import '../../utils/constants.dart';
import 'model/category_model.dart';
import 'model/shop_model.dart';

class ShopApi {
  static Future<List<ShopCategoryModel>> getShopCategoryList() async {
    var categoryRes = CategoryRes.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.getShopCategory, method: HttpMethodType.GET)));
    if (categoryRes.data.validate().isNotEmpty) {
      categoryRes.data.insert(0, ShopCategoryModel(id: 0, name: 'All'));
    }
    return categoryRes.data.validate();
  }

  static Future<List<ShopModel>> getShopList({
    required int categoryId,
    int page = 1,
    int perPage = 10,
    required List<ShopModel> shops,
    Function(bool)? lastPageCallBack,
  }) async {
    if (categoryId != 0) {
      final shopRes = ShopRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getShopList}?category_id=$categoryId&per_page=$perPage&page=$page", method: HttpMethodType.GET)));
      if (page == 1) shops.clear();
      shops.addAll(shopRes.data);
      lastPageCallBack?.call(shopRes.data.length != perPage);
      return shops;
    } else {
      final shopRes = ShopRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getShopList}?per_page=$perPage&page=$page", method: HttpMethodType.GET)));
      if (page == 1) shops.clear();
      shops.addAll(shopRes.data);
      lastPageCallBack?.call(shopRes.data.length != perPage);
      return shops;
    }
  }

  static Future<ProductDetailRes> getProductDetails({required int productId}) async {
    if (isLoggedIn.value) {
      return ProductDetailRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getProductDetails}?id=$productId&user_id=${loginUserData.value.id}", method: HttpMethodType.GET)));
    } else {
      return ProductDetailRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getProductDetails}?id=$productId", method: HttpMethodType.GET)));
    }
  }

  static Future<List<ProductReviewDataModel>> productAllReviews({
    int productId = 0,
    int page = 1,
    int perPage = Constants.perPageItem,
    required List<ProductReviewDataModel> list,
    Function(bool)? lastPageCallBack,
  }) async {
    String prodId = productId != 0 ? 'product_id=$productId' : '';
    final res = ProductReviewsResponse.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getProductReviewList}?$prodId&user_id=${loginUserData.value.id}&per_page=$perPage&page=$page", method: HttpMethodType.GET)));
    if (page == 1) list.clear();
    list.addAll(res.data.validate());
    lastPageCallBack?.call(res.data.validate().length != perPage);
    return list;
  }

  static Future<ProductReviewLikeDislikeModel> addReviewLikeOrDislike(request) async {
    return ProductReviewLikeDislikeModel.fromJson(await handleResponse(await buildHttpResponse(APIEndPoints.reviewLike, method: HttpMethodType.POST, request: request)));
  }
}
