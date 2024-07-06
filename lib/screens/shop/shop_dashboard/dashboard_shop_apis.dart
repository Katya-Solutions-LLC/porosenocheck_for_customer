import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/constants.dart';

import '../../../network/network_utils.dart';
import '../../../utils/api_end_points.dart';
import '../../../utils/app_common.dart';
import 'model/category_model.dart';
import 'model/category_response.dart';
import 'model/product_list_response.dart';

class DashboardShopApi {
  static Future<DashboardShopRes> getShopDashboard() async {
    String uId = isLoggedIn.value ? '?user_id=${loginUserData.value.id}' : '';
    return DashboardShopRes.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getShopDashboard}$uId", method: HttpMethodType.GET)));
  }

  static Future<List<CategoryData>> getCategory({
    int page = 1,
    int perPage = 10,
    int productCategoryID = -1,
    required List<CategoryData> category,
    Function(bool)? lastPageCallBack,
  }) async {
    final categoryRes = CategoryResponse.fromJson(await handleResponse(await buildHttpResponse("${APIEndPoints.getProductCategory}?per_page=$perPage&page=$page", method: HttpMethodType.GET)));
    if (page == 1) category.clear();
    category.addAll(categoryRes.category.validate());
    lastPageCallBack?.call(categoryRes.category.validate().length != perPage);
    return category;
  }

  static Future<List<ProductItemData>> getProductsList({
    String categoryId = '',
    String isFeatured = '',
    String bestSeller = '',
    String bestDiscount = '',
    String search = '',
    int page = 1,
    var perPage = Constants.perPageItem,
    required List<ProductItemData> products,
    Function(bool)? lastPageCallBack,
  }) async {
    String searchProduct = search.isNotEmpty ? 'search=$search&' : '';
    String categoryIds = categoryId.isNotEmpty ? 'category_id=$categoryId&' : '';
    String uId = isLoggedIn.value ? 'user_id=${loginUserData.value.id}&' : '';
    String isFeatures = isFeatured.isNotEmpty ? 'is_featured=$isFeatured&' : '';
    String bestSellers = bestSeller.isNotEmpty ? 'best_seller=$bestSeller&' : '';
    String bestDiscounts = bestDiscount.isNotEmpty ? 'best_discount=$bestDiscount&' : '';

    String perPages = 'per_page=$perPage&';
    String pages = 'page=$page';

    final productListRes = ProductListResponse.fromJson(await handleResponse(await buildHttpResponse('${APIEndPoints.getProductList}?$categoryIds$uId$isFeatures$bestSellers$bestDiscounts$searchProduct$perPages$pages', method: HttpMethodType.GET)));
    if (page == 1) products.clear();
    products.addAll(productListRes.data.validate());
    lastPageCallBack?.call(productListRes.data.validate().length != perPage);
    return products;
  }


}
