import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/components/product_item_component.dart';
import 'package:porosenocheck/utils/empty_error_state_widget.dart';
import '../../../../utils/app_common.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/view_all_label_component.dart';
import '../model/product_list_response.dart';
import '../model/product_status_model.dart';
import '../product_list_screen.dart';

class DashboardFeaturedComponents extends StatelessWidget {
  final List<ProductItemData> featuredProductList;

  const DashboardFeaturedComponents({super.key, required this.featuredProductList});

  @override
  Widget build(BuildContext context) {
    if (featuredProductList.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: NoDataWidget(
          title: locale.value.featuredProducts,
          subTitle: locale.value.noProductsFound,
          imageWidget: const EmptyStateWidget(),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      width: Get.width,
      decoration: BoxDecoration(color: isDarkMode.value ? whiteColor.withOpacity(0.1) : lightPrimaryColor2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.height,
          ViewAllLabel(
            label: locale.value.featuredProducts,
            list: featuredProductList,
            onTap: () {
               hideKeyboard(context);
              Get.to(() => ProductListScreen(title: locale.value.featuredProducts), arguments: ProductStatusModel(isFeatured: "1"));
            },
          ).paddingSymmetric(horizontal: 16),
          HorizontalList(
            itemCount: featuredProductList.take(6).length,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 16),
            crossAxisAlignment: WrapCrossAlignment.start,
            itemBuilder: (_, index) {
              return ProductItemComponents(productListData: featuredProductList[index]).paddingRight(8);
            },
          ),
        ],
      ),
    );
  }
}
