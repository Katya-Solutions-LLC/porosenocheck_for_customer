import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../cart/model/cart_list_model.dart';
import 'order_detail_screen.dart';
import 'order_list_controller.dart';

class NewOrderCard extends StatelessWidget {
  final CartListData getOrderData;
  final VoidCallback? onUpdateDeliveryStatus;

  NewOrderCard({super.key, required this.getOrderData, this.onUpdateDeliveryStatus});

  final OrderListController orderListController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: primaryColor,
                  borderRadius: radiusOnly(topLeft: defaultRadius),
                ),
                child: Text('#${getOrderData.orderCode}', style: boldTextStyle(color: Colors.white, size: 12)),
              ).visible(getOrderData.orderCode.isNotEmpty),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                decoration: boxDecorationWithRoundedCorners(
                  backgroundColor: secondaryColor,
                  borderRadius: radiusOnly(topRight: defaultRadius),
                ),
                child: PriceWidget(
                  price: getOrderData.totalAmount.validate(),
                  color: Colors.white,
                  size: 12,
                  isSemiBoldText: true,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedImageWidget(
                    url: getOrderData.productImage.toString(),
                    height: 55,
                    width: 55,
                    fit: BoxFit.cover,
                    radius: defaultRadius,
                  ),
                  12.width,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(getOrderData.productName, style: primaryTextStyle(fontFamily: fontFamilyFontWeight400), maxLines: 1, overflow: TextOverflow.ellipsis),
                      Row(
                        children: [
                          Text(
                            '${locale.value.soldBy} : ',
                            style: secondaryTextStyle(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            getOrderData.soldBy,
                            style: primaryTextStyle(fontFamily: fontFamilyFontWeight600, size: 12, color: primaryColor),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ).visible(getOrderData.soldBy.isNotEmpty && !(getOrderData.soldBy == UNKNOWN)),
                      if (getOrderData.productVariationType.isNotEmpty)
                        Row(
                          children: [
                            Text('${getOrderData.productVariationType} : ', style: secondaryTextStyle()),
                            Text(getOrderData.productVariationName, style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600)),
                          ],
                        ),
                      Row(
                        children: [
                          Text('${locale.value.qty} : ', style: secondaryTextStyle()),
                          Text(getOrderData.qty.toString(), style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600)),
                        ],
                      ),
                    ],
                  ).expand(),
                ],
              ).paddingOnly(left: 16, right: 16, top: 16)
            ],
          ),
          16.height,

          //TODO: Remove Code When confirmed its remove or not
          /// Product Order Status
          /*Divider(color: context.dividerColor),
          2.height,
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(locale.value.deliveryStatus, style: secondaryTextStyle()),
                  Text(getOrderStatus(status: getOrderData.deliveryStatus), style: primaryTextStyle(color: getOrderStatusColor(status: getOrderData.deliveryStatus))),
                ],
              ),
              4.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(locale.value.payment, style: secondaryTextStyle()),
                  Text(getBookingPaymentStatus(status: getOrderData.paymentStatus), style: primaryTextStyle(color: getPriceStatusColor(paymentStatus: getOrderData.paymentStatus))),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
          16.height,*/
        ],
      ),
    ).onTap(() {
      hideKeyboard(context);
      Get.to(() => OrderDetailScreen(), arguments: getOrderData);
    }, borderRadius: radius(), highlightColor: Colors.transparent, splashColor: Colors.transparent).paddingOnly(bottom: 16);
  }
}
