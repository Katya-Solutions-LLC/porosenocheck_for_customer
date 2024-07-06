import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/generated/assets.dart';
import 'package:porosenocheck/utils/common_base.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/dotted_line.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/colors.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../../shop/order/billing_address_screen.dart';
import '../model/address_models/address_list_response.dart';
import '../model/address_models/logistic_zone_response.dart';
import '../services/addresses_apis.dart';
import 'add_address_screen.dart';
import 'select_address_controller.dart';
import 'select_address_screen_shimmer.dart';

class SelectAddressScreen extends StatelessWidget {
  final bool isFromProfile;
  SelectAddressScreen({super.key, this.isFromProfile = false});
  final SelectAddressController selectAddressController = Get.put(SelectAddressController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.myAddresses,
      isLoading: selectAddressController.isLoading,
      body: Stack(
        children: [
          Obx(
            () => SnapHelperWidget<List<UserAddress>>(
              future: selectAddressController.getAddresses.value,
              loadingWidget: const SelectAddressScreenShimmer(),
              errorBuilder: (error) {
                return NoDataWidget(
                  title: error,
                  retryText: locale.value.reload,
                  imageWidget: const ErrorStateWidget(),
                  onRetry: () {
                    selectAddressController.page(1);
                    selectAddressController.init();
                  },
                );
              },
              onSuccess: (addressList) {
                RxList<UserAddress> addressListRx = RxList(addressList);
                if (addressListRx.isEmpty) {
                  return NoDataWidget(
                    title: locale.value.oppsLooksLikeYou,
                    retryText: locale.value.addNewAddress,
                    imageWidget: const EmptyStateWidget(),
                    onRetry: () async {
                      Get.to(() => AddAddressScreen())?.then((result) {
                        if (result == true) {
                          selectAddressController.page(1);
                          selectAddressController.isLoading(true);
                          selectAddressController.init();
                        }
                      });
                    },
                  ).paddingSymmetric(horizontal: 32);
                }

                return AnimatedScrollView(
                  listAnimationType: ListAnimationType.None,
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 90, top: 20),
                  physics: const AlwaysScrollableScrollPhysics(),
                  onSwipeRefresh: () async {
                    selectAddressController.page(1);
                    return await selectAddressController.init();
                  },
                  children: [
                    Obx(
                      () => AnimatedListView(
                        shrinkWrap: true,
                        listAnimationType: ListAnimationType.None,
                        itemCount: addressListRx.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          UserAddress addressData = addressListRx[index];

                          return Obx(
                            () => Container(
                              decoration: boxDecorationDefault(color: context.cardColor, borderRadius: radius()),
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      RadioListTile(
                                        value: addressData.id,
                                        activeColor: primaryColor,
                                        groupValue: selectAddressController.setSelectedAddressData.value.id.value,
                                        shape: RoundedRectangleBorder(borderRadius: radius()),
                                        visualDensity: VisualDensity.compact,
                                        dense: true,
                                        contentPadding: const EdgeInsets.all(8),
                                        title: "${addressData.firstName} ${addressData.lastName}".trim().isEmpty ? null : Text("${addressData.firstName} ${addressData.lastName}".trim(), style: primaryTextStyle()),
                                        subtitle: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${addressData.addressLine1} ${addressData.addressLine2}',
                                              style: secondaryTextStyle(size: 12),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${addressData.cityName}' ' - ${addressData.postalCode}',
                                              style: secondaryTextStyle(size: 12),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              '${addressData.stateName}' ', ${addressData.countryName}',
                                              style: secondaryTextStyle(size: 12),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        secondary: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            buildIconWidget(
                                              icon: Assets.iconsIcEditReview,
                                              onTap: () async {
                                                Get.to(() => AddAddressScreen(), arguments: addressData)?.then((value) {
                                                  log('AddAddressScreen VALUE: $value');
                                                  if (value == true) {
                                                    selectAddressController.page(1);
                                                    selectAddressController.isLoading(true);
                                                    selectAddressController.init();
                                                  }
                                                });
                                              },
                                            ),
                                            buildIconWidget(
                                              icon: Assets.iconsIcDelete,
                                              onTap: () => handleDeleteAddressClick(addressListRx, index, context),
                                            ).visible(!addressData.isPrimary.getBoolInt()),
                                          ],
                                        ),
                                        onChanged: (value) async {
                                          if (!isFromProfile) {
                                            /// LogisticZone Api
                                            await selectAddressController.getLogisticZoneApi(addressId: addressData.id.value);
                                            selectAddressController.isSelectedLogistic(false);
                                            selectAddressController.setLogisticZoneData(LogisticZoneData());
                                          }

                                          selectAddressController.setSelectedAddressData(addressData);
                                        },
                                      ),
                                      if (!isFromProfile) Obx(() => logisticWidget(context).visible(selectAddressController.setSelectedAddressData.value.id.value == addressData.id.value)),
                                    ],
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                      decoration: boxDecorationWithRoundedCorners(
                                        backgroundColor: lightPrimaryColor,
                                        borderRadius: radiusOnly(bottomLeft: defaultRadius),
                                      ),
                                      child: Text(locale.value.primary, style: primaryTextStyle(color: primaryTextColor, size: 12)),
                                    ),
                                  ).visible(addressData.isPrimary.getBoolInt()),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Obx(
                  () => AppButton(
                    text: locale.value.addNewAddress,
                    textStyle: selectAddressController.isSelectedLogistic.value
                        ? appButtonTextStyleGray
                        : appButtonTextStyleWhite,
                    color: selectAddressController.isSelectedLogistic.value
                        ? lightSecondaryColor
                        : primaryColor,
                    onTap: () {
                      Get.to(() => AddAddressScreen())?.then((value) {
                        if (value == true) {
                          selectAddressController.page(1);
                          selectAddressController.isLoading(true);
                          selectAddressController.init();
                        }
                      });
                    },
                  ).visible(selectAddressController.addressList.isNotEmpty).expand(),
                ),
                Obx(() => 12.width.visible(selectAddressController.isSelectedLogistic.value)),
                Obx(() => AppButton(
                      width: Get.width,
                      text: locale.value.deliverHere,
                      textStyle: appButtonTextStyleWhite,
                      onTap: () {
                        Get.to(() => BillingAddressScreen());
                      },
                    ).expand().visible(selectAddressController.isSelectedLogistic.value)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIconWidget({required String icon, required VoidCallback onTap}) {
    return SizedBox(
      height: 38,
      width: 38,
      child: IconButton(padding: EdgeInsets.zero, icon: icon.iconImage(size: 18), onPressed: onTap),
    );
  }

  Future<void> handleDeleteAddressClick(RxList<UserAddress> addressList, int index, BuildContext context) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: locale.value.areYouSureYouWantToDeleteThisAddress,
      positiveText: locale.value.delete,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        selectAddressController.isLoading(true);
        UserAddressesApis.removeAddress(addressId: addressList[index].id.value).then((value) {
          addressList.removeAt(index);
          if (value.message.trim().isNotEmpty) toast(locale.value.addressDeleteSuccessfully);
          selectAddressController.isLoading(false);
        }).catchError(onError);
      },
    );
  }

  /// Logistic Zone Widget
  Widget logisticWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectAddressController.logisticList.isEmpty) Text('*${locale.value.weAreNotShipping}', style: secondaryTextStyle(color: primaryColor, fontStyle: FontStyle.italic)),
        if (selectAddressController.logisticList.isNotEmpty) DottedLine(lineThickness: 1, dashLength: 4, dashColor: context.dividerColor),
        8.height,
        if (selectAddressController.logisticList.isNotEmpty)
          Text(
            locale.value.deliveryCharge,
            style: secondaryTextStyle(color: Colors.green, size: 14, fontStyle: FontStyle.italic),
          ).paddingSymmetric(horizontal: 16),
        AnimatedWrap(
          itemCount: selectAddressController.logisticList.length,
          itemBuilder: (context, index) {
            LogisticZoneData logisticData = selectAddressController.logisticList[index];

            return Obx(
              () => Container(
                decoration: boxDecorationDefault(color: context.cardColor, borderRadius: radius()),
                padding: const EdgeInsets.only(left: 10, right: 16, bottom: 10),
                child: RadioListTile(
                  value: logisticData.id,
                  groupValue: selectAddressController.setLogisticZoneData.value.id,
                  activeColor: isDarkMode.value ? primaryColor : secondaryColor,
                  shape: RoundedRectangleBorder(borderRadius: radius()),
                  visualDensity: VisualDensity.compact,
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text(logisticData.name, style: primaryTextStyle(color: isDarkMode.value ? textPrimaryColorGlobal : secondaryColor, size: 14)),
                  secondary: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(logisticData.standardDeliveryTime, style: secondaryTextStyle()),
                      8.width,
                      PriceWidget(price: logisticData.standardDeliveryCharge, size: 14),
                    ],
                  ),
                  onChanged: (value) {
                    selectAddressController.setLogisticZoneData(logisticData);
                    selectAddressController.isSelectedLogistic(true);
                    log("id==== ${selectAddressController.setLogisticZoneData.value.id}");
                    log("logisticId==== ${selectAddressController.setLogisticZoneData.value.logisticId}");
                    log("name==== ${selectAddressController.setLogisticZoneData.value.name}");
                    log("standardDeliveryCharge==== ${selectAddressController.setLogisticZoneData.value.standardDeliveryCharge}");
                    log("standardDeliveryTime==== ${selectAddressController.setLogisticZoneData.value.standardDeliveryTime}");
                  },
                ),
                /*CheckboxListTile(
                  checkColor: white,
                  value: logisticData.isLogisticCheck.value,
                  title: Text(logisticData.name, style: primaryTextStyle(color: isDarkMode.value ? textPrimaryColorGlobal : secondaryColor, size: 14)),
                  secondary: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(logisticData.standardDeliveryTime, style: secondaryTextStyle()),
                      8.width,
                      PriceWidget(price: logisticData.standardDeliveryCharge, size: 14),
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  controlAffinity: ListTileControlAffinity.leading,
                  checkboxShape: RoundedRectangleBorder(borderRadius: radius(5)),
                  side: BorderSide(color: textSecondaryColorGlobal),
                  dense: true,
                  activeColor: isDarkMode.value ? primaryColor : secondaryColor,
                  onChanged: (value) {
                    logisticData.isLogisticCheck(!logisticData.isLogisticCheck.value);

                    if (logisticData.isLogisticCheck.value) {
                      selectAddressController.isSelectedLogistic(logisticData.isLogisticCheck.value);
                      selectAddressController.setLogisticZoneData(logisticData);
                    } else {
                      selectAddressController.isSelectedLogistic(logisticData.isLogisticCheck.value);
                      selectAddressController.setLogisticZoneData(LogisticZoneData());
                    }
                  },
                ),*/
              ),
            );
          },
        ),
      ],
    );
  }
}
