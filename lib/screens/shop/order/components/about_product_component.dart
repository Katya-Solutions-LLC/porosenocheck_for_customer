import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';

import '../../../../components/cached_image_widget.dart';
import '../../../../components/price_widget.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';
import '../../../../utils/constants.dart';
import '../../cart/model/cart_list_model.dart';
import '../../product/product_detail_screen.dart';
import 'order_review_component.dart';

class AboutProductComponent extends StatelessWidget {
  final CartListData productData;
  final String? deliveryStatus;

  const AboutProductComponent({super.key, this.deliveryStatus, required this.productData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.value.aboutProduct, style: primaryTextStyle()),
        8.height,
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => ProductDetail(), arguments: productData.productId);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CachedImageWidget(
                      url: productData.productImage,
                      height: 75,
                      width: 75,
                      fit: BoxFit.cover,
                      radius: defaultRadius,
                    ),
                    12.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(productData.productName, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                        Row(
                          children: [
                            Text(
                              '${locale.value.soldBy} : ',
                              style: secondaryTextStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              productData.soldBy,
                              style: primaryTextStyle(fontFamily: fontFamilyFontWeight600, size: 12, color: primaryColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ).paddingOnly(top: 2).visible(productData.soldBy.isNotEmpty && !(productData.soldBy == UNKNOWN)),
                        if (productData.productVariationType.isNotEmpty)
                          Row(
                            children: [
                              Text('${productData.productVariationType} : ', style: secondaryTextStyle()),
                              Text(productData.productVariationName, style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600)),
                            ],
                          ),
                        Row(
                          children: [
                            Text('${locale.value.qty} : ', style: secondaryTextStyle()),
                            Text(productData.qty.toString(), style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600)),
                          ],
                        ),
                        PriceWidget(price: productData.getProductPrice, size: 12),
                      ],
                    ).expand(),
                  ],
                ),
              ),

              OrderReviewComponent(deliveryStatus: deliveryStatus, productData: productData),
            ],
          ),
        ),
      ],
    );
  }
}
