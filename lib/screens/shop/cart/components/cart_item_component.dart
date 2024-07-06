import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';

import '../../../../components/cached_image_widget.dart';
import '../../../../components/price_widget.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../../product/product_detail_screen.dart';
import '../cart_controller.dart';
import '../model/cart_list_model.dart';

class CartItemComponent extends StatelessWidget {
  final CartListData cartListData;

  CartItemComponent({super.key, required this.cartListData});

  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          Get.to(() => ProductDetail(), arguments: cartListData.productId);
        },
        child: Container(
          width: Get.width,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedImageWidget(
                    url: cartListData.productImage,
                    height: 75,
                    width: 75,
                    fit: BoxFit.cover,
                    radius: defaultRadius,
                  ),
                  12.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cartListData.productName,
                            style: primaryTextStyle(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ).expand(),
                          4.width,
                          Container(
                            padding: EdgeInsets.zero,
                            height: 20,
                            width: 20,
                            decoration: boxDecorationDefault(shape: BoxShape.circle, border: Border.all(color: textSecondaryColorGlobal), color: context.cardColor),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.close_rounded, color: textSecondaryColorGlobal, size: 18),
                              onPressed: () async {
                                /// Remove Cart Api
                                cartController.removeCart(context: context, cartId: cartListData.id);
                              },
                            ),
                          ),
                        ],
                      ),
                      4.height,
                      if (cartListData.productDescription.isNotEmpty)
                        Text(
                          cartListData.productDescription,
                          style: secondaryTextStyle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      Row(
                        children: [
                          Text(
                            '${locale.value.soldBy}: ',
                            style: secondaryTextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            cartListData.soldBy,
                            style: primaryTextStyle(fontFamily: fontFamilyFontWeight600, size: 12, color: primaryColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ).visible(cartListData.soldBy.isNotEmpty && !(cartListData.soldBy == UNKNOWN)),
                      if (cartListData.productVariationValue.isNotEmpty)
                        Row(
                          children: [
                            Text('${cartListData.productVariationType}: ', style: secondaryTextStyle()),
                            Text(
                              cartListData.productVariationName,
                              style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600),
                            ),
                          ],
                        ),
                    ],
                  ).expand(),
                ],
              ),
              12.height,
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    height: 26,
                    width: 74,
                    decoration: boxDecorationDefault(
                      color: borderColor,
                      border: Border.all(color: textSecondaryColor),
                      borderRadius: radius(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.remove, color: textSecondaryColor, size: 14),
                          highlightColor: Colors.transparent,
                          onPressed: () async {
                            if (cartController.isTap.value) {
                              if (cartListData.qty.value > 1) {
                                cartController.isTap(false);
                                cartListData.qty(cartListData.qty.value - 1);

                                /// update cart api
                                cartController.updateCartAPi(
                                  cartId: cartListData.id,
                                  productId: cartListData.productId,
                                  productVariationId: cartListData.productVariationId,
                                  qty: cartListData.qty.value,
                                );
                              }
                            }
                          },
                        ).expand(),
                        Text('${cartListData.qty}', style: primaryTextStyle(color: Colors.black)),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.add, color: textSecondaryColor, size: 14),
                          highlightColor: Colors.transparent,
                          onPressed: () async {
                            if (cartController.isTap.value) {
                              if (cartListData.qty.value < cartListData.productVariation.productStockQty) {
                                cartController.isTap(false);
                                cartListData.qty(cartListData.qty.value + 1);

                                /// update cart api
                                cartController.updateCartAPi(
                                  cartId: cartListData.id,
                                  productId: cartListData.productId,
                                  productVariationId: cartListData.productVariationId,
                                  qty: cartListData.qty.value,
                                );
                              } else {
                                Fluttertoast.cancel();
                                toast("${locale.value.outOfStock}!!!");
                              }
                            }
                          },
                        ).expand(),
                      ],
                    ),
                  ),
                  16.width,
                  if (!cartListData.productVariation.id.isNegative)
                    Marquee(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (!cartListData.isDiscount)
                            PriceWidget(
                              price: cartListData.productVariation.taxIncludeProductPrice,
                              size: 16,
                            ),
                          if (cartListData.isDiscount)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                PriceWidget(price: cartListData.productVariation.discountedProductPrice),
                                6.width,
                                PriceWidget(
                                  price: cartListData.productVariation.taxIncludeProductPrice,
                                  isLineThroughEnabled: true,
                                  size: 12,
                                  color: textSecondaryColorGlobal,
                                ),
                                if (cartListData.discountType == TaxType.PERCENT)
                                  Text(
                                    '${cartListData.discountValue}%  ${locale.value.off}',
                                    style: primaryTextStyle(color: greenColor, size: 12),
                                  ).paddingLeft(8)
                                else if (cartListData.discountType == TaxType.FIXED)
                                  PriceWidget(
                                    price: cartListData.discountValue,
                                    color: greenColor,
                                    size: 12,
                                    isBoldText: false,
                                    isDiscountedPrice: true,
                                  ).paddingLeft(4),
                              ],
                            ),
                        ],
                      ),
                    ).expand(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
