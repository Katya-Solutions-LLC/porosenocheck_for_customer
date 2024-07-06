import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/app_scaffold.dart';

import '../../../components/bottom_selection_widget.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../../booking_module/services/service_navigation.dart';
import '../cart/model/cart_list_model.dart';
import 'new_order_card.dart';
import 'new_order_screen_shimmer.dart';
import 'order_list_controller.dart';

class NewOrderScreen extends StatelessWidget {
  final OrderListController orderListController = Get.put(OrderListController());

  NewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.orders,
      isLoading: orderListController.isLoading,
      actions: [
        IconButton(
          onPressed: () async {
            handleFilterClick(context);
          },
          icon: Assets.iconsIcFilter.iconImage(color: darkGray, size: 24),
        ),
      ],
      body: Obx(
        () => SnapHelperWidget<List<CartListData>>(
          future: orderListController.orderListFuture.value,
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.value.reload,
              imageWidget: const ErrorStateWidget(),
              onRetry: () {
                orderListController.page(1);
                orderListController.isLoading(true);
                orderListController.getOrderList();
              },
            ).paddingSymmetric(horizontal: 16);
          },
          loadingWidget: const NewOrderScreenShimmer(),
          onSuccess: (orderList) {
            return AnimatedListView(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: orderList.length,
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              listAnimationType: ListAnimationType.FadeIn,
              fadeInConfiguration: FadeInConfiguration(duration: const Duration(seconds: 2)),
              scaleConfiguration: ScaleConfiguration(duration: const Duration(milliseconds: 400), delay: const Duration(milliseconds: 50)),
              emptyWidget: NoDataWidget(
                title: locale.value.noOrdersFound,
                subTitle: locale.value.thereAreNoOrders,
                imageWidget: const EmptyStateWidget(),
                retryText: locale.value.reload,
                onRetry: () {
                  orderListController.page(1);
                  orderListController.isLoading(true);
                  orderListController.getOrderList();
                },
              ).paddingSymmetric(horizontal: 16),
              itemBuilder: (_, i) => NewOrderCard(
                getOrderData: orderList[i],
                onUpdateDeliveryStatus: () {
                  orderListController.page(1);
                  orderListController.getOrderList();
                },
              ),
              onNextPage: () {
                if (!orderListController.isLastPage.value) {
                  orderListController.page(orderListController.page.value + 1);
                  orderListController.getOrderList();
                }
              },
              onSwipeRefresh: () async {
                orderListController.page(1);
                orderListController.getOrderList(showLoader: false);
                return await Future.delayed(const Duration(seconds: 2));
              },
            );
          },
        ),
      ),
    );
  }

  void handleFilterClick(BuildContext context) {
    doIfLoggedIn(context, () {
      serviceCommonBottomSheet(
        context,
        child: Obx(
          () => BottomSelectionSheet(
            heightRatio: 0.45,
            title: locale.value.filterBy,
            hideSearchBar: true,
            hintText: locale.value.searchForStatus,
            searchTextCont: TextEditingController(),
            hasError: false,
            isLoading: orderListController.isLoading,
            isEmpty: allStatus.isEmpty,
            noDataTitle: locale.value.statusListIsEmpty,
            noDataSubTitle: locale.value.thereAreNoStatus,
            listWidget: statusListWid(context),
          ),
        ),
      );
    });
  }

  Widget statusListWid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.value.deliveryStatus, style: secondaryTextStyle()),
        16.height,
        AnimatedWrap(
          runSpacing: 4,
          spacing: 4,
          itemCount: allOrderStatus.length,
          listAnimationType: ListAnimationType.None,
          itemBuilder: (_, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  if (orderListController.selectedIndex.contains(allOrderStatus[index].name)) {
                    orderListController.selectedIndex.remove(allOrderStatus[index].name);
                  } else {
                    orderListController.selectedIndex.add(allOrderStatus[index].name);
                  }
                },
                child: Container(
                  width: Get.width / 3.7,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: boxDecorationDefault(
                    color: orderListController.selectedIndex.contains(allOrderStatus[index].name)
                        ? isDarkMode.value
                            ? primaryColor
                            : lightPrimaryColor
                        : isDarkMode.value
                            ? lightPrimaryColor2
                            : Colors.grey.shade100,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        size: 14,
                        color: isDarkMode.value ? whiteColor : primaryColor,
                      ).visible(orderListController.selectedIndex.contains(allOrderStatus[index].name)),
                      4.width.visible(orderListController.selectedIndex.contains(allOrderStatus[index].name)),
                      Text(
                        getOrderStatus(status: allOrderStatus[index].name),
                        style: secondaryTextStyle(
                          color: orderListController.selectedIndex.contains(allOrderStatus[index].name)
                              ? isDarkMode.value
                                  ? whiteColor
                                  : primaryColor
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ).paddingOnly(top: 10, bottom: 16),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppButton(
              text: locale.value.clearFilter,
              textStyle: appButtonTextStyleGray,
              color: lightSecondaryColor,
              onTap: () {
                orderListController.selectedIndex.clear();
              },
            ).expand(),
            16.width,
            AppButton(
              text: locale.value.apply,
              textStyle: appButtonTextStyleWhite,
              onTap: () {
                Get.back();
                orderListController.page(1);
                orderListController.getOrderList();
              },
            ).expand(),
          ],
        ),
      ],
    ).expand();
  }
}
