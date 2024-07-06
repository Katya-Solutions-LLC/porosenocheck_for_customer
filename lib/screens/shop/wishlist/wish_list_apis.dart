import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';

import '../../../models/base_response_model.dart';
import '../../../network/network_utils.dart';
import '../../../utils/api_end_points.dart';
import '../../../utils/constants.dart';
import '../cart/wishlist_controller.dart';
import '../product/product_controller.dart';
import '../shop_dashboard/model/product_list_response.dart';

class WishListApis {
  static Future<bool> addToWishList({required int productId}) async {
    try {
      final res = BaseResponseModel.fromJson(await handleResponse(await buildHttpResponse(
        APIEndPoints.addToWishList,
        method: HttpMethodType.POST,
        request: {ProductModelKey.productId: productId},
      )));
      return res.status;
    } catch (e) {
      toast(e.toString());
      return false;
    }
  }

  static Future<bool> removeFromWishList({required int productId}) async {
    try {
      final res = BaseResponseModel.fromJson(await handleResponse(
        await buildHttpResponse('${APIEndPoints.removeWishList}?product_id=$productId', method: HttpMethodType.GET),
      ));
      return res.status;
    } catch (e) {
      toast(e.toString());
      return false;
    }
  }

  static Future<bool> onTapFavourite({required ProductItemData favdata}) async {
    bool isRemoved = false;
    final productId = favdata.productId.isNegative ? favdata.id : favdata.productId;
    if (favdata.inWishlist.value) {
      bool success = await removeFromWishList(productId: productId);
      if (success) {
        isRemoved = true;
        toast(locale.value.productRemoveToWishlist); //TODO dynamic value set
        favdata.inWishlist(false);
        updateProductElementEveryWhere();
        log("-----remove success--product_id $productId-----${favdata.inWishlist.value}-------");
      }
    } else {
      bool success = await addToWishList(productId: productId);
      if (success) {
        favdata.inWishlist(true);
        toast(locale.value.productAddedToWishlist); //TODO dynamic value set
        updateProductElementEveryWhere();
        log("-----add success--product_id $productId-----${favdata.inWishlist.value}-------");
      }
    }
    return isRemoved;
  }

  static void updateProductElementEveryWhere() {
    try {
      WishlistController wLCont = Get.find();
      wLCont.page(1);
      wLCont.getWishListData();
    } catch (e) {
      log('sDCont = Get.find() E: $e');
    }
    try {
      ProductDetailController pDCont = Get.find();
      pDCont.init();
    } catch (e) {
      log('sDCont = Get.find() E: $e');
    }
  }
}
