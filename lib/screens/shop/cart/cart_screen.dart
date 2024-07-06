import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../../../utils/view_all_label_component.dart';
import '../../auth/profile/select_address_screen.dart';
import 'cart_controller.dart';
import 'cart_screen_shimmer.dart';
import 'components/cart_item_component.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.cart,
      isLoading: cartController.isLoading,
      body: Obx(
        () => SnapHelperWidget(
          future: cartController.getCartList.value,
          loadingWidget: const CartScreenShimmer(),
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.value.reload,
              imageWidget: const ErrorStateWidget(),
              onRetry: () {
                cartController.page(1);
                cartController.isLoading(true);
                cartController.init();
              },
            );
          },
          onSuccess: (cartList) {
            if (cartList.$1.isEmpty) {
              return NoDataWidget(
                title: locale.value.yourCartIsEmpty,
                subTitle: locale.value.thereAreCurrentlyNoItemsInYourCart,
                imageWidget: const EmptyStateWidget(),
                retryText: locale.value.reload,
                onRetry: () {
                  cartController.page(1);
                  cartController.isLoading(true);
                  cartController.init();
                },
              ).paddingSymmetric(horizontal: 16);
            }

            return Stack(
              children: [
                AnimatedScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 225, top: 20),
                  listAnimationType: ListAnimationType.FadeIn,
                  fadeInConfiguration: FadeInConfiguration(duration: const Duration(seconds: 2)),
                  scaleConfiguration: ScaleConfiguration(duration: const Duration(milliseconds: 400), delay: const Duration(milliseconds: 50)),
                  onSwipeRefresh: () async {
                    cartController.page(1);
                    return await cartController.init();
                  },
                  onNextPage: () {
                    if (!cartController.isLastPage.value) {
                      cartController.page++;
                      cartController.init();
                    }
                  },
                  children: [
                    AnimatedListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      listAnimationType: ListAnimationType.None,
                      itemCount: cartList.$1.length,
                      itemBuilder: (context, index) {
                        return CartItemComponent(cartListData: cartList.$1[index]);
                      },
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                    decoration: boxDecorationDefault(
                      color: context.cardColor,
                      borderRadius: radiusOnly(topLeft: 20, topRight: 20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ViewAllLabel(label: locale.value.productPriceDetails, isShowAll: false, labelSize: 14),

                        /// Subtotal
                        if (cartList.$2.cartPriceData.discountAmount != 0)
                          SettingItemWidget(
                            title: locale.value.subtotal,
                            titleTextStyle: secondaryTextStyle(),
                            padding: EdgeInsets.zero,
                            trailing: Marquee(
                              child: PriceWidget(
                                price: cartList.$2.cartPriceData.taxIncludedAmount.validate(),
                                color: textPrimaryColorGlobal,
                                size: 14,
                              ),
                            ),
                          ),
                        10.height,

                        /// Discount
                        if (cartList.$2.cartPriceData.discountAmount != 0)
                          SettingItemWidget(
                            title: locale.value.discount,
                            titleTextStyle: secondaryTextStyle(),
                            padding: EdgeInsets.zero,
                            trailing: Marquee(
                              child: PriceWidget(
                                price: cartList.$2.cartPriceData.discountAmount.validate(),
                                color: Colors.green,
                                size: 14,
                                isBoldText: true,
                                isDiscountedPrice: true,
                              ),
                            ),
                          ).paddingBottom(10),

                        /// Total Amount
                        SettingItemWidget(
                          title: locale.value.totalAmount,
                          titleTextStyle: secondaryTextStyle(),
                          padding: EdgeInsets.zero,
                          trailing: Marquee(
                            child: PriceWidget(
                              price: cartList.$2.cartPriceData.totalAmount.validate(),
                              color: textPrimaryColorGlobal,
                              size: 14,
                            ),
                          ),
                        ),
                        20.height,
                        AppButton(
                          width: Get.width,
                          textStyle: appButtonTextStyleWhite,
                          onTap: () {
                            Get.to(() => SelectAddressScreen());
                          },
                          child: Text(locale.value.next, style: boldTextStyle(color: Colors.white)),
                        ),
                        16.height,
                      ],
                    ),
                  ),
                ).visible(cartList.$1.isNotEmpty),
              ],
            );
          },
        ),
      ),
    );
  }
}
