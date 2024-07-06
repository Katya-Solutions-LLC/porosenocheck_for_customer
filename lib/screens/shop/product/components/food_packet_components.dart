import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/view_all_label_component.dart';
import '../../shop_dashboard/model/product_list_response.dart';
import '../product_controller.dart';
import '../../../../utils/colors.dart';

class FoodPacketComponents extends StatelessWidget {
  final ProductItemData productData;
  final ProductDetailController productController;

  const FoodPacketComponents({super.key, required this.productController, required this.productData});

  @override
  Widget build(BuildContext context) {
    if (productData.hasVariation != 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.height,
          ViewAllLabel(label: locale.value.foodPacketSize, isShowAll: false).paddingSymmetric(horizontal: 16),
          8.height,
          HorizontalList(
            wrapAlignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            itemCount: productData.variationData.length,
            spacing: 16,
            padding: const EdgeInsets.only(left: 16, right: 16),
            itemBuilder: (context, index) {
              VariationData variationData = productData.variationData[index];
              return Obx(
                () => InkWell(
                  onTap: () {
                    productController.qtyCount(1);
                    productController.selectedVariationData(variationData);
                    variationData.taxIncludeProductPrice = productController.selectedVariationData.value.taxIncludeProductPrice;
                  },
                  borderRadius: radius(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 12),
                    decoration: boxDecorationDefault(
                      color: productController.selectedVariationData.value.id == variationData.id ? lightPrimaryColor : context.cardColor,
                    ),
                    child: AnimatedWrap(
                      itemCount: variationData.combination.length,
                      itemBuilder: (context, index) {
                        Combination combinationData = variationData.combination[index];
                        return Text(
                          combinationData.productVariationName,
                          style: primaryTextStyle(color: productController.selectedVariationData.value.id == variationData.id ? primaryColor : null),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      );
    } else {
      return const Offstage();
    }
  }
}
