import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/product_list_screen.dart';
import 'package:porosenocheck/utils/empty_error_state_widget.dart';

import '../../../../main.dart';
import '../../../../utils/view_all_label_component.dart';
import '../model/category_response.dart';
import '../model/product_status_model.dart';
import '../product_category_screen.dart';
import '../shop_dashboard_controller.dart';
import 'category_item_components.dart';

class DashboardCategoryComponents extends StatelessWidget {
  final List<CategoryData> productCategoryList;

  DashboardCategoryComponents({super.key, required this.productCategoryList});

  final ShopDashboardController shopDashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (productCategoryList.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: NoDataWidget(
          title: locale.value.noCategoryFound,
          imageWidget: const EmptyStateWidget(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewAllLabel(
          label: locale.value.category,
          list: productCategoryList,
          onTap: () {
            hideKeyboard(context);
            Get.to(() => ProductCategoryScreen())?.then((value) {
              setStatusBarColor(Colors.transparent);
            });
          },
        ).paddingOnly(left: 16, right: 8),
        8.height,
        AnimatedWrap(
          runSpacing: 16,
          spacing: 16,
          columnCount: 2,
          itemCount: productCategoryList.take(6).length,
          listAnimationType: ListAnimationType.FadeIn,
          itemBuilder: (_, index) {
            CategoryData data = productCategoryList[index];
            return GestureDetector(
              onTap: () {
                hideKeyboard(context);
                Get.to(() => ProductListScreen(title: data.name), arguments: ProductStatusModel(productCategoryID: data.id.toString()));
              },
              child: CategoryItemComponents(categoryData: data, width: Get.width / 3 - 22),
            );
          },
        ).paddingOnly(top: 10, left: 16, right: 16, bottom: 16)
      ],
    );
  }
}
