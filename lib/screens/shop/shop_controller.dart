import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:porosenocheck/screens/shop/model/category_model.dart';
import 'package:porosenocheck/screens/shop/shop_api.dart';

import 'model/shop_model.dart';

class ShopController extends GetxController {
  Rx<Future<List<ShopModel>>> getShop = Future(() => <ShopModel>[]).obs;
  RxList<ShopModel> shopList = RxList();
  TabController? tabController;
  RxInt categorySelectIndex = (-1).obs;
  RxBool isLoading = false.obs;
  RxList<ShopCategoryModel> categoryList = RxList();
  RxBool hasErrorFetchingCategory = false.obs;
  RxString errorMessageCaegory = "".obs;
  RxBool isLastPage = false.obs;
  RxInt page = 1.obs;

  @override
  void onInit() {
    getShopCategory();
    /*getShopList();*/
    /*init();*/
    super.onInit();
  }

  getShopCategory() {
    isLoading(true);
    ShopApi.getShopCategoryList().then((value) {
      categoryList(value);
      hasErrorFetchingCategory(false);
      isLoading(false);
    }).onError((error, stackTrace) {
      hasErrorFetchingCategory(true);
      errorMessageCaegory(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }
}
