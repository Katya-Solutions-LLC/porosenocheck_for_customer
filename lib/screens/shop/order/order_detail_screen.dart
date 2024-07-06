import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/app_scaffold.dart';
import 'package:porosenocheck/screens/shop/order/order_detail_controller.dart';
import '../../../components/loader_widget.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/empty_error_state_widget.dart';
import 'components/about_product_component.dart';
import 'components/order_information_component.dart';
import 'components/order_payment_info_component.dart';
import 'components/other_product_items_component.dart';
import 'components/shipping_detail_component.dart';

class OrderDetailScreen extends StatelessWidget {
  OrderDetailScreen({Key? key}) : super(key: key);
  final OrderDetailController orderDetailController = Get.put(OrderDetailController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: Obx(
        () => Text(
          '#${orderDetailController.orderCode.value}',
          style: primaryTextStyle(size: 16, decoration: TextDecoration.none),
        ),
      ),
      isLoading: orderDetailController.isLoading,
      body: Obx(
        () => SnapHelperWidget(
          future: orderDetailController.getOrderDetailFuture.value,
          loadingWidget: const LoaderWidget(),
          errorBuilder: (error) {
            return NoDataWidget(
              title: error,
              retryText: locale.value.reload,
              imageWidget: const ErrorStateWidget(),
              onRetry: () {
                orderDetailController.isLoading(true);

                orderDetailController.init();
              },
            );
          },
          onSuccess: (snap) {
            if (snap.data.id.isNegative) {
              return NoDataWidget(
                title: locale.value.noDetailsFound,
                retryText: locale.value.reload,
                onRetry: () {
                  orderDetailController.isLoading(true);

                  orderDetailController.init();
                },
              );
            }

            return AnimatedScrollView(
              padding: const EdgeInsets.all(16),
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                OrderInformationComponent(orderData: snap.data),
                16.height,
                AboutProductComponent(productData: snap.data.orderDetails.productDetails, deliveryStatus: snap.data.deliveryStatus),
                16.height,
                OrderPaymentInfoComponent(orderData: snap.data),
                16.height,
                if (snap.data.orderDetails.otherOrderItems.isNotEmpty)
                  Column(
                    children: [
                      OtherProductItemsComponent(otherProductItemList: snap.data.orderDetails.otherOrderItems).paddingBottom(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${locale.value.grandTotal}: ', style: primaryTextStyle(size: 14)),
                          PriceWidget(price: snap.data.orderDetails.grandTotal, size: 14),
                        ],
                      ),
                    ],
                  ),
                ShippingDetailComponent(shippingData: snap.data),
                16.height,
              ],
              onSwipeRefresh: () async {
                return orderDetailController.init();
              },
            );
          },
        ),
      ),
    );
  }
}
