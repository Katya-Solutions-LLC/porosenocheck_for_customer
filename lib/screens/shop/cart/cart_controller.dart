import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/app_common.dart';

import '../../../main.dart';
import '../../../utils/constants.dart';
import 'model/cart_list_model.dart';
import 'product_cart_api.dart';

class CartController extends GetxController {
  Rx<Future<(List<CartListData>, CartListResponse)>> getCartList = Future(() => (const <CartListData>[], CartListResponse(cartPriceData: CartPriceData(taxData: CartTaxData())))).obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  Rx<(List<CartListData>, CartListResponse)> cartList = (<CartListData>[], CartListResponse(cartPriceData: CartPriceData(taxData: CartTaxData()))).obs;
  RxInt page = 1.obs;
  RxBool isTap = true.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init({bool showLoader = false}) async {
    if (showLoader) {
      isLoading(true);
    }
    await getCartList(
      ProductCartApi.getCartList(
        page: page.value,
        cartList: cartList.value,
        lastPageCallBack: (p0) {
          isLastPage(p0);
        },
      ),
    ).then((value) {
      cartItemCount(value.$1.length);
      isTap(true);
    }).whenComplete(() => isLoading(false));
  }

  Future<void> removeCart({required BuildContext context, required int cartId}) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: "${locale.value.doYouWantToRemoveThisItem}?",
      positiveText: locale.value.remove,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        isLoading(true);
        await ProductCartApi.removeFromCart(cartId: cartId).then((value) {
          cartItemCount(cartItemCount.value - 1);
          toast(value.message);
          init(showLoader: true);
        }).catchError((error) {
          isLoading(false);
          toast(error.toString());
        }).whenComplete(() => isLoading(false));
      },
    );
  }

  Future<void> updateCartAPi({
    required int productId,
    required int cartId,
    required int productVariationId,
    required int qty,
  }) async {
    isLoading(true);

    Map request = {
      ProductModelKey.productId: productId,
      ProductModelKey.cartId: cartId,
      ProductModelKey.productVariationId: productVariationId,
      ProductModelKey.qty: qty,
    };

    await ProductCartApi.updateCart(request).then((value) {
      toast(value.message);
      init(showLoader: true);
    }).catchError((error) {
      toast(error.toString());
      isLoading(false);
    }).whenComplete(() => isLoading(false));
  }
}
