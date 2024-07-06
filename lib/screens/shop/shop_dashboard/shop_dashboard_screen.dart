// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/app_scaffold.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/shop_dashboard_controller.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/shop_dashboard_screen_shimmer.dart';

import '../../../components/search_widget.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../cart/wishlist_screen.dart';
import 'components/best_seller_product_components.dart';
import 'components/cart_icon_btn.dart';
import 'components/dashboard_category_components.dart';
import 'components/dashboard_featured_components.dart';
import 'components/deals_components.dart';
import 'components/product_item_component.dart';
import 'model/category_model.dart';
import 'model/product_list_response.dart';
import 'product_list_screen_shimmer.dart';

class ShopDashboardScreen extends StatelessWidget {
  ShopDashboardScreen({super.key});

  final ShopDashboardController shopDashboardController = Get.put(ShopDashboardController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      isLoading: shopDashboardController.isLoading,
      appBartitleText: locale.value.shop,
      hasLeadingWidget: false,
      actions: [
        IconButton(
          onPressed: () async {
            hideKeyboard(context);
            doIfLoggedIn(context, () {
              Get.to(() => WishListScreen());
            });
          },
          icon: const Icon(Icons.favorite_border_outlined, color: switchColor, size: 25),
        ),
        const CartIconBtn(),
      ],
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: [
            8.height,
            SearchBarWidget(
              productListController: shopDashboardController.pCont,
              onClearButton: () {
                shopDashboardController.pCont.handleSearch();
              },
              onFieldSubmitted: (p0) {
                hideKeyboard(context);
              },
            ).paddingSymmetric(horizontal: 16),
            8.height,
            Obx(
              () => shopDashboardController.pCont.isSearchText.value ? _buildSearchComponent() : _buildShopHomeComponent(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildShopHomeComponent() {
    return RefreshIndicator(
      onRefresh: () async {
        shopDashboardController.getShopDashboardDetail(isFromSwipRefresh: true);
        return await Future.delayed(const Duration(seconds: 2));
      },
      child: SnapHelperWidget<DashboardShopRes>(
        future: shopDashboardController.getDashboardDetail.value,
        initialData: shopDashboardController.shopdashboardData.value.shopDashData.category.isNotEmpty ? shopDashboardController.shopdashboardData.value : null,
        errorBuilder: (error) {
          return NoDataWidget(
            title: error,
            retryText: locale.value.reload,
            imageWidget: const ErrorStateWidget(),
            onRetry: () {
              shopDashboardController.getShopDashboardDetail();
            },
          ).paddingSymmetric(horizontal: 16);
        },
        loadingWidget: const ShopDashboardScreenShimmer(),
        onSuccess: (shopDashboardRes) {
          if (shopDashboardRes.shopDashData.category.validate().isEmpty) {
            return NoDataWidget(
              title: locale.value.atThisTimeThere,
              retryText: locale.value.reload,
              imageWidget: const EmptyStateWidget(),
              onRetry: () {
                shopDashboardController.getShopDashboardDetail();
              },
            );
          }
          return AnimatedScrollView(
            listAnimationType: ListAnimationType.FadeIn,
            padding: const EdgeInsets.only(bottom: 20),
            children: [
              DashboardCategoryComponents(productCategoryList: shopDashboardRes.shopDashData.category).paddingTop(8),
              DashboardFeaturedComponents(featuredProductList: shopDashboardRes.shopDashData.featuredProduct).paddingTop(16),
              BestSellerComponents(bestSellerProductList: shopDashboardRes.shopDashData.bestsellerProduct).paddingTop(16),
              DealsComponents(discountProductList: shopDashboardRes.shopDashData.discountProduct).paddingTop(16),
            ],
          );
        },
      ),
    ).expand();
  }

  Widget _buildSearchComponent() {
    return SnapHelperWidget<List<ProductItemData>>(
      future: shopDashboardController.pCont.getFeatured.value,
      errorBuilder: (error) {
        return NoDataWidget(
          title: error,
          retryText: locale.value.reload,
          imageWidget: const ErrorStateWidget(),
          onRetry: () {
            shopDashboardController.pCont.page(1);
            shopDashboardController.pCont.handleSearch();
          },
        ).paddingSymmetric(horizontal: 16);
      },
      loadingWidget: const ProductListScreenShimmer(),
      onSuccess: (productList) {
        if (productList.isEmpty && shopDashboardController.pCont.isSearchText.value && !shopDashboardController.pCont.isLoading.value) {
          return NoDataWidget(
            title: locale.value.noProductsFound,
            imageWidget: const EmptyStateWidget(),
          );
        }

        return AnimatedScrollView(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 30),
          onSwipeRefresh: () async {
            shopDashboardController.pCont.page(1);
            shopDashboardController.pCont.handleSearch();
            return await Future.delayed(const Duration(seconds: 2));
          },
          onNextPage: () {
            if (!shopDashboardController.pCont.isLastPage.value) {
              shopDashboardController.pCont.page(shopDashboardController.pCont.page.value + 1);
              shopDashboardController.pCont.handleSearch();
            }
          },
          children: [
            16.height,
            AnimatedWrap(
              itemCount: productList.length,
              spacing: 16,
              runSpacing: 16,
              itemBuilder: (context, index) {
                return Obx(
                  () => (productList.length == 1)
                      ? Align(
                          alignment: Alignment.topLeft,
                          child: ProductItemComponents(productListData: productList[index]),
                        )
                      : ProductItemComponents(productListData: productList[index]),
                );
              },
            ),
          ],
        );
      },
    ).expand();
  }
}
