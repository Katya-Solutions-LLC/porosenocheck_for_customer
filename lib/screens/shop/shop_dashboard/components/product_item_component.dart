import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';

import '../../../../components/cached_image_widget.dart';
import '../../../../components/price_widget.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../../cart/wishlist_controller.dart';
import '../../product/product_detail_screen.dart';
import '../../wishlist/wish_list_apis.dart';
import '../model/product_list_response.dart';
import '../shop_dashboard_controller.dart';

class ProductItemComponents extends StatelessWidget {
  final ProductItemData productListData;
  final bool isFromWishList;

  ProductItemComponents({super.key, required this.productListData, this.isFromWishList = false});

  final ShopDashboardController shopDashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        hideKeyboard(context);
        final isAddedToWishList = await Get.to(() => ProductDetail(), arguments: isFromWishList ? productListData.productId : productListData.id);
        if (isAddedToWishList is bool) {
          productListData.inWishlist(isAddedToWishList);
        }
      },
      child: Container(
        width: Get.width / 2 - 24,
        decoration: boxDecorationDefault(
          color: context.cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius),
                  child: CachedImageWidget(
                    url: productListData.productImage,
                    width: Get.width,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  left: 8,
                  child: GestureDetector(
                    onTap: () {
                      if (isFromWishList) {
                        try {
                          WishlistController wLCont = Get.find();
                          doIfLoggedIn(context, () async {
                            wLCont.isLoading(true);
                            WishListApis.onTapFavourite(favdata: productListData).whenComplete(() => wLCont.isLoading(false));
                          });
                        } catch (e) {
                          log('wLCont = Get.find(); E: $e');
                        }
                      } else {
                        doIfLoggedIn(context, () async {
                          shopDashboardController.isLoading(true);
                          WishListApis.onTapFavourite(favdata: productListData).whenComplete(() => shopDashboardController.isLoading(false));
                        });
                      }
                    },
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: boxDecorationWithShadow(boxShape: BoxShape.rectangle, backgroundColor: context.cardColor, borderRadius: radius(18)),
                            child: Marquee(child: Text(locale.value.outOfStock, style: boldTextStyle(size: 12, color: context.primaryColor))),
                          ).visible(productListData.stockQty == 0),
                          Container(
                              padding: const EdgeInsets.all(8),
                              decoration: boxDecorationWithShadow(boxShape: BoxShape.circle, backgroundColor: context.cardColor),
                              child: productListData.inWishlist.value ? const Icon(Icons.favorite, size: 15, color: redColor) : Icon(Icons.favorite, size: 15, color: textSecondaryColorGlobal)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(isFromWishList ? productListData.productName : productListData.name, style: primaryTextStyle(size: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                6.height,
                Marquee(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (productListData.isDiscount) PriceWidget(price: productListData.variationData.validate().first.discountedProductPrice),
                      if (productListData.isDiscount) 4.width,
                      PriceWidget(
                        price: productListData.variationData.first.taxIncludeProductPrice,
                        isLineThroughEnabled: productListData.isDiscount ? true : false,
                        isBoldText: productListData.isDiscount ? false : true,
                        size: productListData.isDiscount ? 12 : 16,
                        color: productListData.isDiscount ? textSecondaryColorGlobal : null,
                      ).visible(productListData.variationData.isNotEmpty),
                    ],
                  ),
                ),
                Marquee(
                  child: Row(
                    children: [
                      Text(
                        '${locale.value.soldBy}: ',
                        style: secondaryTextStyle(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        productListData.soldBy,
                        style: primaryTextStyle(fontFamily: fontFamilyFontWeight600, size: 12, color: secondaryColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ).paddingOnly(top: 6).visible(productListData.soldBy.isNotEmpty && !(productListData.soldBy == UNKNOWN)),
                6.height,
              ],
            ).paddingAll(16),
          ],
        ),
      ),
    );
  }
}
