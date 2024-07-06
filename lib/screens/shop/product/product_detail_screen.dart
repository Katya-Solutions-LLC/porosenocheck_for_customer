import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/shop/cart/wishlist_screen.dart';
import 'package:porosenocheck/screens/shop/product/product_controller.dart';
import 'package:porosenocheck/screens/shop/product/product_detail_screen_shimmer.dart';

import '../../../components/app_scaffold.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../cart/cart_screen.dart';
import '../shop_dashboard/components/cart_icon_btn.dart';
import '../wishlist/wish_list_apis.dart';
import 'components/delivery_option_components.dart';
import 'components/food_packet_components.dart';
import 'components/product_info_component.dart';
import 'components/product_slider_components.dart';
import 'components/qty_components.dart';
import 'components/rating_components.dart';
import 'components/related_product_components.dart';
import 'model/product_detail_response.dart';

class ProductDetail extends StatelessWidget {
  ProductDetail({super.key});
  final ProductDetailController productDetailController = ProductDetailController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: DummyController(),
        initState: (state) {
          productDetailController.init();
        },
        builder: (c) {
          return WillPopScope(
            onWillPop: () {
              Get.back(result: productDetailController.productDetailRes.value.data.inWishlist.value);
              return Future(() => false);
            },
            child: AppScaffold(
              hideAppBar: true,
              isLoading: productDetailController.isLoading,
              body: RefreshIndicator(
                onRefresh: () async {
                  productDetailController.getProductDetails(isFromSwipeRefresh: true);
                  return await Future.delayed(const Duration(seconds: 2));
                },
                child: Obx(
                  () => SnapHelperWidget<ProductDetailRes>(
                    future: productDetailController.productDetailsFuture.value,
                    errorBuilder: (error) {
                      return NoDataWidget(
                        title: error,
                        retryText: locale.value.reload,
                        imageWidget: const ErrorStateWidget(),
                        onRetry: () {
                          productDetailController.isLoading(true);
                          productDetailController.init();
                        },
                      ).paddingSymmetric(horizontal: 16);
                    },
                    loadingWidget: const ProductDetailScreenShimmer(),
                    onSuccess: (snap) {
                      if (snap.data.id.isNegative) {
                        return NoDataWidget(
                          title: locale.value.noDetailFound,
                          retryText: locale.value.reload,
                          onRetry: () {
                            productDetailController.isLoading(true);
                            productDetailController.init();
                          },
                        );
                      }
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          AnimatedScrollView(
                            listAnimationType: ListAnimationType.FadeIn,
                            padding: const EdgeInsets.only(bottom: 85),
                            children: [
                              ProductSlider(productGallaryData: snap.data.productGallaryData.validate(), productController: productDetailController),
                              16.height,
                              ProductInfoComponent(productData: snap.data, productController: productDetailController),
                              FoodPacketComponents(productData: snap.data, productController: productDetailController),
                              Obx(() => QtyComponents(productController: productDetailController).visible(productDetailController.selectedVariationData.value.isStockAvaible == 1)),
                              DeliveryOptionComponents(productData: snap.data, productController: productDetailController),
                              16.height,
                              RatingComponents(productReviewData: snap.data, reviewDetails: snap.data.productReview.validate(), productController: productDetailController),
                              16.height,
                              RelatedProductComponents(relatedProductData: snap.relatedProduct.validate(), productController: productDetailController),
                            ],
                          ),
                          Positioned(
                            top: context.statusBarHeight + 8,
                            left: 16,
                            child: Container(
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: white),
                              child: backButton(result: snap.data.inWishlist.value),
                            ).scale(scale: 0.8),
                          ),
                          Positioned(
                            top: context.statusBarHeight + 8,
                            right: 8,
                            child: Row(
                              children: [
                                actionsWidget(
                                  widget: const Icon(Icons.favorite_border_outlined, color: secondaryTextColor),
                                  onTap: () {
                                    hideKeyboard(context);
                                    doIfLoggedIn(context, () {
                                      Get.to(() => WishListScreen());
                                    });
                                  },
                                ),
                                8.width,
                                const CartIconBtn(showBGCardColor: true),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: context.cardColor,
                              padding: const EdgeInsets.all(16),
                              width: Get.width,
                              child: Row(
                                children: [
                                  Obx(
                                    () => AppButton(
                                      color: lightPrimaryColor,
                                      width: 45,
                                      height: 47,
                                      splashColor: context.cardColor,
                                      padding: EdgeInsets.zero,
                                      child: snap.data.inWishlist.value ? const Icon(Icons.favorite, size: 26, color: redColor) : const Icon(Icons.favorite_border_outlined, size: 26, color: secondaryTextColor),
                                      onTap: () {
                                        doIfLoggedIn(context, () async {
                                          productDetailController.isLoading(true);
                                          WishListApis.onTapFavourite(favdata: snap.data).whenComplete(() => productDetailController.isLoading(false));
                                        });
                                      },
                                    ).expand(),
                                  ),
                                  16.width,
                                  Obx(
                                    () => AppButton(
                                      color: productDetailController.selectedVariationData.value.isStockAvaible == 1 ? context.primaryColor : null,
                                      width: 45,
                                      height: 47,
                                      enabled: productDetailController.selectedVariationData.value.isStockAvaible == 1 ? true : false,
                                      disabledColor: productDetailController.selectedVariationData.value.isStockAvaible == 1 ? null : context.primaryColor.withOpacity(0.8),
                                      splashColor: context.primaryColor,
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        productDetailController.selectedVariationData.value.inCart.value ? locale.value.goToCart : locale.value.addToCart,
                                        style: boldTextStyle(color: productDetailController.selectedVariationData.value.isStockAvaible == 1 ? Colors.white : Colors.white70),
                                      ),
                                      onTap: () {
                                        hideKeyboard(context);
                                        doIfLoggedIn(context, () async {
                                          if (productDetailController.selectedVariationData.value.inCart.value) {
                                            await Get.to(() => CartScreen());
                                            productDetailController.isLoading(true);
                                            productDetailController.init();
                                          } else {
                                            /// Add To Cart Api
                                            productDetailController.addProductToCart();
                                          }
                                        });
                                      },
                                    ).expand(flex: 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}
