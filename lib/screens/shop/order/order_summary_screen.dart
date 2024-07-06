import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/auth/profile/select_address_controller.dart';
import 'package:porosenocheck/screens/shop/order/order_payment_controller.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/cached_image_widget.dart';
import '../../../components/dotted_line.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/view_all_label_component.dart';
import '../../dashboard/dashboard_controller.dart';
import '../cart/cart_controller.dart';
import '../cart/model/cart_list_model.dart';
import 'billing_address_controller.dart';
import 'model/place_order_req.dart';
import 'order_payment_screen.dart';

class OrderSummaryScreen extends StatelessWidget {
  OrderSummaryScreen({super.key});

  final BillingAddressController additionalInfoController = Get.find();
  final SelectAddressController selectAddressController = Get.find();
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.orderSummary,
      body: Stack(
        children: [
          AnimatedScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
            children: [
              Container(
                width: Get.width,
                decoration: boxDecorationDefault(color: context.cardColor),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(locale.value.shippingAddress, style: secondaryTextStyle(size: 14)),
                    8.height,
                    Text(additionalInfoController.fullNameCont.text.trim(), style: boldTextStyle()),
                    Text(
                      '${selectAddressController.setSelectedAddressData.value.addressLine1} ${selectAddressController.setSelectedAddressData.value.addressLine2} ${selectAddressController.setSelectedAddressData.value.cityName} - ${selectAddressController.setSelectedAddressData.value.postalCode}',
                      style: primaryTextStyle(size: 12),
                    ),
                    Text(selectAddressController.setSelectedAddressData.value.stateName, style: primaryTextStyle(size: 12)),
                    Text(selectAddressController.setSelectedAddressData.value.countryName, style: primaryTextStyle(size: 12)),
                    Text(additionalInfoController.mobileCont.text.trim(), style: primaryTextStyle(size: 12)),
                    if (additionalInfoController.alternateMobileCont.text.trim().isNotEmpty) Text(additionalInfoController.alternateMobileCont.text.trim(), style: primaryTextStyle()),
                  ],
                ),
              ),
              16.height,
              AnimatedWrap(
                runSpacing: 16,
                itemCount: cartController.cartList.value.$1.length,
                listAnimationType: ListAnimationType.None,
                itemBuilder: (context, index) {
                  CartListData productData = cartController.cartList.value.$1[index];

                  return Container(
                    decoration: boxDecorationDefault(color: context.cardColor),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedImageWidget(
                              url: productData.productImage.validate(),
                              height: 75,
                              width: 75,
                              fit: BoxFit.cover,
                              radius: defaultRadius,
                            ),
                            12.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(productData.productName, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                                Row(
                                  children: [
                                    Text(
                                      '${locale.value.soldBy} : ',
                                      style: secondaryTextStyle(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      productData.soldBy,
                                      style: primaryTextStyle(fontFamily: fontFamilyFontWeight600, size: 12, color: primaryColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ).visible(productData.soldBy.isNotEmpty && !(productData.soldBy == UNKNOWN)),
                                if (productData.productVariationType.isNotEmpty)
                                  Row(
                                    children: [
                                      Text('${productData.productVariationType} : ', style: secondaryTextStyle()),
                                      Text(productData.productVariationName, style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600)),
                                    ],
                                  ),
                                Row(
                                  children: [
                                    Text('${locale.value.qty} : ', style: secondaryTextStyle()),
                                    Text(productData.qty.toString(), style: primaryTextStyle(size: 12, color: textPrimaryColorGlobal, fontFamily: fontFamilyFontWeight600)),
                                  ],
                                ),
                                if (productData.productVariation.id > 0)
                                  Marquee(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        if (!productData.isDiscount)
                                          PriceWidget(
                                            price: productData.productVariation.taxIncludeProductPrice,
                                            size: 14,
                                          ),
                                        if (productData.isDiscount)
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              PriceWidget(price: productData.productVariation.discountedProductPrice, size: 14),
                                              6.width,
                                              PriceWidget(
                                                price: productData.productVariation.taxIncludeProductPrice,
                                                isLineThroughEnabled: true,
                                                size: 12,
                                                color: secondaryTextColor,
                                              ),
                                              if (productData.discountType == TaxType.PERCENT)
                                                Text(
                                                  '${productData.discountValue}%  ${locale.value.off}',
                                                  style: primaryTextStyle(color: greenColor, size: 12),
                                                ).paddingLeft(8)
                                              else if (productData.discountType == TaxType.FIXED)
                                                PriceWidget(
                                                  price: productData.discountValue,
                                                  color: greenColor,
                                                  size: 12,
                                                  isBoldText: false,
                                                  isDiscountedPrice: true,
                                                ).paddingLeft(4),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                              ],
                            ).expand(),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              16.height,
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: boxDecorationDefault(color: context.cardColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ViewAllLabel(label: locale.value.priceDetails, isShowAll: false, labelSize: 14),

                    /// Subtotal
                    detailWidgetPrice(
                      title: locale.value.subtotal,
                      value: cartController.cartList.value.$2.cartPriceData.taxIncludedAmount,
                      textColor: textPrimaryColorGlobal,
                    ),

                    ///total
                    detailWidgetPrice(
                      title: locale.value.discountedAmount,
                      value: cartController.cartList.value.$2.cartPriceData.totalAmount,
                      textColor: textPrimaryColorGlobal,
                    ).visible(cartController.cartList.value.$2.cartPriceData.taxIncludedAmount != cartController.cartList.value.$2.cartPriceData.totalAmount),

                    /// Total Tax Amount
                    detailWidgetPrice(title: locale.value.tax, value: cartController.cartList.value.$2.cartPriceData.taxAmount, textColor: textPrimaryColorGlobal),

                    /// Delivery Charge
                    detailWidgetPrice(
                      title: '${locale.value.deliveryCharge} $totalDeliveryChargeText',
                      value: totalDeliveryChargeAmount,
                      textColor: textPrimaryColorGlobal,
                    ),

                    DottedLine(lineThickness: 1, dashLength: 4, dashColor: context.dividerColor),
                    10.height,

                    /// Total Amount
                    detailWidgetPrice(
                      title: locale.value.total,
                      value: cartController.cartList.value.$2.cartPriceData.totalPayableAmount + totalDeliveryChargeAmount,
                      textColor: primaryColor,
                    ),

                    6.height,
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AppButton(
              width: Get.width,
              text: locale.value.proceed,
              textStyle: appButtonTextStyleWhite,
              onTap: () {
                orderPaymentController = OrderPaymentController(
                  amount: cartController.cartList.value.$2.cartPriceData.totalPayableAmount + totalDeliveryChargeAmount,
                  placeOrderReq: PlaceOrderReq(
                    locationId: 1,
                    shippingAddressId: selectAddressController.setSelectedAddressData.value.id.value,
                    billingAddressId: selectAddressController.setSelectedAddressData.value.id.value,
                    phone: additionalInfoController.mobileCont.text.trim(),
                    alternativePhone: additionalInfoController.alternateMobileCont.text.trim(),
                    chosenLogisticZoneId: selectAddressController.setLogisticZoneData.value.id,
                    shippingDeliveryType: ShippingDeliveryType.regular,
                  ),
                );
                Get.to(() => const OrderPaymentScreen(), binding: BindingsBuilder(() {
                  getAppConfigurations();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }

  num get totalDeliveryChargeAmount => selectAddressController.setLogisticZoneData.value.standardDeliveryCharge * cartController.cartList.value.$1.length;

  String get totalDeliveryChargeText => '( ${cartController.cartList.value.$1.length} ${cartController.cartList.value.$1.length == 1 ? 'item' : 'items'} * ${selectAddressController.setLogisticZoneData.value.standardDeliveryCharge} )';
}
