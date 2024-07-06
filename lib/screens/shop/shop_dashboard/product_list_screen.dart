import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/product_list_controller.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/product_list_screen_shimmer.dart';

import '../../../components/app_scaffold.dart';
import '../../../main.dart';
import '../../../utils/empty_error_state_widget.dart';
import 'components/product_item_component.dart';
import 'model/product_list_response.dart';

class ProductListScreen extends StatelessWidget {
  final String? title;

  ProductListScreen({super.key, this.title});

  final ProductListController productListController = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: title,
      isLoading: productListController.isLoading,
      body: Obx(
        () => SnapHelperWidget<List<ProductItemData>>(
          future: productListController.getFeatured.value,
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.value.reload,
              imageWidget: const ErrorStateWidget(),
              onRetry: () {
                productListController.page(1);
                productListController.init();
              },
            ).paddingSymmetric(horizontal: 16);
          },
          loadingWidget: const ProductListScreenShimmer(),
          onSuccess: (productList) {
            if (productList.isEmpty) {
              return NoDataWidget(
                title: locale.value.noProductsFound,
                retryText: locale.value.reload,
                onRetry: () {
                  productListController.page(1);
                  productListController.init();
                },
              );
            }
            return AnimatedScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
              listAnimationType: ListAnimationType.None,
              onNextPage: () async {
                if (!productListController.isLastPage.value) {
                  productListController.page(productListController.page.value + 1);
                  productListController.init();
                }
              },
              onSwipeRefresh: () async {
                productListController.page(1);
                return await productListController.init(isFromSwipRefresh: true);
              },
              children: [
                AnimatedWrap(
                  itemCount: productList.length,
                  spacing: 16,
                  runSpacing: 16,
                  listAnimationType: ListAnimationType.FadeIn,
                  fadeInConfiguration: FadeInConfiguration(duration: const Duration(seconds: 2)),
                  scaleConfiguration: ScaleConfiguration(duration: const Duration(milliseconds: 400), delay: const Duration(milliseconds: 50)),
                  itemBuilder: (context, index) {
                    return Obx(() => ProductItemComponents(productListData: productList[index]));
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
