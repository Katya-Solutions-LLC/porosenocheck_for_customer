import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/model/product_status_model.dart';
import 'package:stream_transform/stream_transform.dart';

import 'dashboard_shop_apis.dart';
import 'model/product_list_response.dart';

class ProductListController extends GetxController {
  Rx<Future<List<ProductItemData>>> getFeatured = Future(() => <ProductItemData>[]).obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxList<ProductItemData> productList = RxList();
  Rx<ProductStatusModel> argumentsList = ProductStatusModel().obs;
  RxInt page = 1.obs;

  ///Search
  TextEditingController searchCont = TextEditingController();
  RxBool isSearchText = false.obs;
  StreamController<String> searchStream = StreamController<String>();
  final _scrollController = ScrollController();

  @override
  void onInit() {
    initializeSearchStream();
    init(isFromSwipRefresh: true);
    super.onInit();
  }

  Future<void> init({bool isFromSwipRefresh = false}) async {
    if (Get.arguments is ProductStatusModel) {
      argumentsList(Get.arguments as ProductStatusModel);
    }

    await getProductsList(categoryId: argumentsList.value.productCategoryID, bestDiscount: argumentsList.value.isDeal, isFeatured: argumentsList.value.isFeatured, bestSeller: argumentsList.value.isBestSeller, isFromSwipRefresh: isFromSwipRefresh);
  }

  void handleSearch() async {
    page(1);
    getProductsList(search: searchCont.text.trim());
  }

  getProductsList({String search = "", String categoryId = "", String bestDiscount = "", String isFeatured = "", String bestSeller = "", bool isFromSwipRefresh = false}) {
    if (!isFromSwipRefresh) {
      isLoading(true);
    }
    getFeatured(
      DashboardShopApi.getProductsList(
        search: search,
        categoryId: categoryId,
        isFeatured: isFeatured,
        bestSeller: bestSeller,
        bestDiscount: bestDiscount,
        page: page.value,
        products: productList,
        lastPageCallBack: (p0) {
          isLastPage(p0);
        },
      ).whenComplete(
        () => isLoading(false),
      ),
    );
  }

  ///Search
  void initializeSearchStream() {
    _scrollController.addListener(() => Get.context != null ? hideKeyboard(Get.context) : null);
    searchStream.stream.debounce(const Duration(seconds: 1)).listen((s) {
      handleSearch();
    });
  }

  void disposeSearchStream() {
    searchStream.close();
    if (Get.context != null) {
      _scrollController.removeListener(() => hideKeyboard(Get.context));
    }
  }

  @override
  void onClose() {
    disposeSearchStream();
    super.onClose();
  }
}
