import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../components/price_widget.dart';
import '../../../../main.dart';
import '../../../../utils/common_base.dart';
import '../../../booking_module/services/service_navigation.dart';
import '../model/order_detail_model.dart';

class OrderPaymentInfoComponent extends StatelessWidget {
  final OrderListData orderData;

  const OrderPaymentInfoComponent({super.key, required this.orderData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(locale.value.priceDetails, style: primaryTextStyle()),
        8.height,
        Container(
          decoration: boxDecorationDefault(color: context.cardColor),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Subtotal
              detailWidgetPrice(title: locale.value.subtotal, value: orderData.orderDetails.productPrice, textColor: textPrimaryColorGlobal),

              /// Total Tax Amount
              detailWidgetPrice(title: locale.value.tax, value: orderData.orderDetails.productDetails.taxAmount, textColor: textPrimaryColorGlobal),

              /// Delivery Charge
              detailWidgetPrice(title: locale.value.deliveryCharge, value: orderData.logisticCharge, textColor: textPrimaryColorGlobal),

              /// Payment Status
              detailWidget(
                title: locale.value.paymentStatus,
                value: orderData.paymentStatus.capitalizeFirstLetter(),
                textStyle: primaryTextStyle(
                  size: 12,
                  color: getPriceStatusColor(paymentStatus: orderData.paymentStatus),
                  fontFamily: fontFamilyFontWeight600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(locale.value.total, style: secondaryTextStyle()),
                  PriceWidget(price: orderData.totalAmount, size: 12),
                ],
              ).paddingBottom(10),
            ],
          ),
        ),
      ],
    );
  }
}
