import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/components/product_item_component.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/model/product_list_response.dart';
import '../../../../utils/view_all_label_component.dart';
import '../model/product_status_model.dart';
import '../product_list_screen.dart';

class BestSellerComponents extends StatelessWidget {
  final List<ProductItemData> bestSellerProductList;

  const BestSellerComponents({super.key, required this.bestSellerProductList});

  @override
  Widget build(BuildContext context) {
    if (bestSellerProductList.isEmpty) return const Offstage();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          label: locale.value.bestSellerProduct,
          list: bestSellerProductList,
          onTap: () {
            hideKeyboard(context);
            Get.to(() => ProductListScreen(title: locale.value.bestSellerProduct), arguments: ProductStatusModel(isBestSeller: "1"));
          },
        ).paddingOnly(left: 16, right: 8),
        8.height,
        AnimatedWrap(
          runSpacing: 16,
          spacing: 16,
          columnCount: 2,
          itemCount: bestSellerProductList.take(6).length,
          listAnimationType: ListAnimationType.FadeIn,
          itemBuilder: (_, index) {
            return ProductItemComponents(productListData: bestSellerProductList[index]);
          },
        ).paddingOnly(top: 10, left: 16, right: 16, bottom: 16)
      ],
    );
  }
}
