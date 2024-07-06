import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/common_base.dart';
import 'package:porosenocheck/utils/view_all_label_component.dart';

import '../../../../components/cached_image_widget.dart';
import '../../../../components/price_widget.dart';
import '../../../booking_module/booking_detail/booking_detail_controller.dart';
import '../../shop_dashboard/model/product_list_response.dart';
import '../../wishlist/wish_list_apis.dart';
import '../product_controller.dart';

class RelatedProductComponents extends StatelessWidget {
  final List<ProductItemData> relatedProductData;
  final ProductDetailController productController;

  const RelatedProductComponents({super.key, required this.productController, required this.relatedProductData});

  @override
  Widget build(BuildContext context) {
    if (relatedProductData.isEmpty) return const Offstage();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(label: locale.value.ourMostLoveChewTreats, isShowAll: false).paddingSymmetric(horizontal: 16),
        16.height,
        HorizontalList(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          runSpacing: 16,
          spacing: 16,
          itemCount: relatedProductData.take(6).length,
          itemBuilder: (context, index) {
            ProductItemData data = relatedProductData[index];
            return Container(
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
                          url: data.productImage,
                          width: Get.width,
                          height: 120,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: GestureDetector(
                            onTap: () {
                              doIfLoggedIn(context, () async {
                                productController.isLoading(true);
                                WishListApis.onTapFavourite(favdata: data).whenComplete(() => productController.isLoading(false));
                              });
                            },
                            child: Obx(
                              () => Container(
                                padding: const EdgeInsets.all(8),
                                decoration: boxDecorationWithShadow(boxShape: BoxShape.circle, backgroundColor: context.cardColor),
                                child: data.inWishlist.value
                                    ? const Icon(Icons.favorite, size: 15, color: redColor)
                                    : Icon(
                                        Icons.favorite,
                                        size: 15,
                                        color: textSecondaryColorGlobal,
                                      ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(data.name, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                      6.height,
                      Marquee(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (data.isDiscount) PriceWidget(price: data.variationData.first.discountedProductPrice.validate().toDouble(), size: 14),
                            if (data.isDiscount) 4.width,
                            PriceWidget(
                              price: data.variationData.first.taxIncludeProductPrice.validate().toDouble(),
                              isLineThroughEnabled: data.isDiscount ? true : false,
                              isBoldText: data.isDiscount ? false : true,
                              size: data.isDiscount ? 12 : 16,
                              color: data.isDiscount ? textSecondaryColorGlobal : null,
                            ).visible(data.variationData.isNotEmpty),
                          ],
                        ),
                      ),
                      6.height,
                      RatingBarWidget(
                        size: 12,
                        disable: true,
                        activeColor: getRatingBarColor(data.rating),
                        rating: data.rating.toDouble(),
                        onRatingChanged: (aRating) {},
                      ),
                    ],
                  ).paddingAll(16),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
