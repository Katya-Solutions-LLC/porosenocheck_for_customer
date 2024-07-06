import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/shop/shop_api.dart';
import 'package:porosenocheck/utils/app_common.dart';
import '../../../utils/constants.dart';
import '../cart/product_cart_api.dart';
import '../shop_dashboard/model/product_list_response.dart';
import 'model/product_detail_response.dart';
import 'model/product_review_response.dart';

class ProductDetailController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController pinCodeCont = TextEditingController();
  RxInt qtyCount = 1.obs;
  Rx<Future<ProductDetailRes>> productDetailsFuture = Future(() => ProductDetailRes(data: ProductItemData(inWishlist: false.obs))).obs;
  Rx<ProductDetailRes> productDetailRes = ProductDetailRes(data: ProductItemData(inWishlist: false.obs)).obs;
  RxList<ProductReviewDataModel> allReviewList = RxList();
  Rx<Future<List<ProductReviewDataModel>>> getreview = Future(() => <ProductReviewDataModel>[]).obs;
  PageController pageController = PageController(keepPage: true, initialPage: 0);
  int page = 1;
  RxBool isLastPage = false.obs;
  Rx<VariationData> selectedVariationData = VariationData(inCart: false.obs).obs;
  RxInt productId = (-1).obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    if (Get.arguments is int) {
      productId(Get.arguments as int);
      getProductDetails(isFromSwipeRefresh: true);
      getReviewList();
    }
  }

  getProductDetails({bool isFromSwipeRefresh = false}) {
    if (!isFromSwipeRefresh) {
      isLoading(true);
    }

    productDetailsFuture(ShopApi.getProductDetails(productId: productId.value)).then((value) {
      productDetailRes(value);
      if (productDetailRes.value.data.variationData.isNotEmpty) {
        selectedVariationData(productDetailRes.value.data.variationData.first);
      }
    }).whenComplete(() => isLoading(false));
  }

  getReviewList() {
    getreview(ShopApi.productAllReviews(
      productId: productId.value,
      page: page,
      list: allReviewList,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ));
  }

  Future<void> addProductToCart() async {
    isLoading(true);

    Map request = {
      ProductModelKey.productId: productId.value,
      ProductModelKey.productVariationId: selectedVariationData.value.id,
      ProductModelKey.qty: qtyCount.value,
      ProductModelKey.locationId: 1,
    };

    await ProductCartApi.addToCart(request).then((value) {
      toast(value.message);
      cartItemCount(cartItemCount.value + 1);
      isLoading(false);
      selectedVariationData.value.inCart(true);
      init();
    }).catchError((error) {
      isLoading(false);
      toast(error.toString());
    });
  }
}

class DummyController extends GetxController {}
