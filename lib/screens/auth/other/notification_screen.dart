import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/generated/assets.dart';
import 'package:porosenocheck/screens/auth/model/notification_model.dart';
import 'package:porosenocheck/screens/auth/other/notification_screen_shimmer.dart';

import '../../../components/app_scaffold.dart';
import '../../../components/cached_image_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../../utils/empty_error_state_widget.dart';
import '../../booking_module/booking_detail/booking_detail_screen.dart';
import '../../booking_module/model/booking_data_model.dart';
import '../../booking_module/services/service_navigation.dart';
import '../../dashboard/dashboard_res_model.dart';
import '../../shop/cart/model/cart_list_model.dart';
import '../../shop/order/order_detail_screen.dart';
import '../../shop/product/model/product_review_response.dart';
import '../../shop/shop_dashboard/model/product_list_response.dart';
import 'notification_screen_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final NotificationScreenController notificationScreenController = Get.put(NotificationScreenController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppScaffold(
        appBartitleText: locale.value.notifications,
        isLoading: notificationScreenController.isLoading,
        actions: notificationScreenController.notificationDetail.isNotEmpty
            ? [
                TextButton(
                  onPressed: () {
                    notificationScreenController.clearAllNotification(context: context);
                  },
                  child: Text(locale.value.clearAll, style: secondaryTextStyle(color: primaryColor, decorationColor: primaryColor)).paddingSymmetric(horizontal: 8),
                ),
              ]
            : null,
        body: Obx(
          () => SnapHelperWidget(
            future: notificationScreenController.getNotifications.value,
            errorBuilder: (error) {
              return NoDataWidget(
                title: error,
                retryText: locale.value.reload,
                imageWidget: const ErrorStateWidget(),
                onRetry: () {
                  notificationScreenController.page(1);
                  notificationScreenController.isLoading(true);
                  notificationScreenController.init();
                },
              ).paddingSymmetric(horizontal: 32);
            },
            loadingWidget: const NotificationScreenShimmer(),
            onSuccess: (notifications) {
              return AnimatedListView(
                shrinkWrap: true,
                itemCount: notifications.length,
                physics: const AlwaysScrollableScrollPhysics(),
                emptyWidget: NoDataWidget(
                  title: locale.value.stayTunedNoNew,
                  subTitle: locale.value.noNewNotificationsAt,
                  titleTextStyle: primaryTextStyle(),
                  imageWidget: const EmptyStateWidget(),
                  retryText: locale.value.reload,
                  onRetry: () {
                    notificationScreenController.page(1);
                    notificationScreenController.isLoading(true);
                    notificationScreenController.init();
                  },
                ).paddingSymmetric(horizontal: 32),
                itemBuilder: (context, index) {
                  NotificationData notification = notificationScreenController.notificationDetail[index];
                  return GestureDetector(
                    onTap: () async {
                      if (notification.data.notificationDetail.id > 0) {
                        if (notification.data.notificationDetail.notificationGroup == NotificationConst.shop) {
                          await Get.to(
                            () => OrderDetailScreen(),
                            arguments: CartListData(
                              notificationId: notification.id,
                              orderId: notification.data.notificationDetail.id,
                              id: notification.data.notificationDetail.itemId,
                              orderCode: notification.data.notificationDetail.orderCode,
                              qty: 0.obs,
                              productVariation: VariationData(inCart: false.obs),
                              productReviewData: ProductReviewDataModel(),
                            ),
                          );
                          notificationScreenController.page(1);
                          notificationScreenController.init();
                        } else if (notification.data.notificationDetail.notificationGroup == NotificationConst.booking) {
                          await Get.to(
                            () => BookingDetailScreen(),
                            arguments: BookingDataModel(
                              notificationId: notification.id,
                              id: notification.data.notificationDetail.id,
                              service: SystemService(slug: notification.data.notificationDetail.bookingServicesNames.toLowerCase()),
                              payment: PaymentDetails(),
                              training: Training(),
                            ),
                          );
                          notificationScreenController.page(1);
                          notificationScreenController.init();
                        }
                      }
                    },
                    behavior: HitTestBehavior.translucent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width,
                          padding: const EdgeInsets.all(16),
                          decoration: boxDecorationDefault(
                            color: notification.readAt.isNotEmpty ? context.scaffoldBackgroundColor : lightPrimaryColor,
                            borderRadius: radius(0),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              notification.data.notificationDetail.notificationGroup == NotificationConst.shop
                                  ? Container(
                                      decoration: boxDecorationDefault(color: Colors.white, shape: BoxShape.circle),
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      child: const CachedImageWidget(
                                        url: Assets.iconsIcOrder,
                                        height: 20,
                                        fit: BoxFit.cover,
                                        color: primaryColor,
                                        circle: true,
                                      ),
                                    )
                                  : notification.data.notificationDetail.bookingServiceImage.isNotEmpty
                                      ? Container(
                                          decoration: boxDecorationDefault(color: Colors.white, shape: BoxShape.circle),
                                          padding: const EdgeInsets.all(10),
                                          alignment: Alignment.center,
                                          child: CachedImageWidget(
                                            url: notification.data.notificationDetail.bookingServiceImage,
                                            height: 20,
                                            fit: BoxFit.cover,
                                            circle: true,
                                          ),
                                        )
                                      : Container(
                                          decoration: boxDecorationDefault(color: Colors.white, shape: BoxShape.circle),
                                          padding: const EdgeInsets.all(10),
                                          alignment: Alignment.center,
                                          child: const CachedImageWidget(
                                            url: Assets.imagesLogo,
                                            height: 20,
                                            fit: BoxFit.cover,
                                            color: primaryColor,
                                            circle: true,
                                          ),
                                        ),
                              16.width,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        notification.data.notificationDetail.notificationGroup == NotificationConst.shop ? '#${notification.data.notificationDetail.orderCode}' : '#${notification.data.notificationDetail.id}',
                                        style: primaryTextStyle(decoration: TextDecoration.none),
                                      ),
                                      4.width,
                                      Text('- ${notification.data.notificationDetail.bookingServicesNames}', style: primaryTextStyle()).visible(notification.data.notificationDetail.bookingServicesNames.isNotEmpty),
                                    ],
                                  ),
                                  4.height,
                                  Text(getBookingNotification(notification: notification.data.notificationDetail.type), style: primaryTextStyle(size: 14)).visible(notification.data.notificationDetail.type.isNotEmpty),
                                  4.height,
                                  Text(notification.createdAt.dateInddMMMyyyyHHmmAmPmFormat, style: secondaryTextStyle()),
                                ],
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.zero,
                                height: 20,
                                width: 20,
                                decoration: boxDecorationDefault(shape: BoxShape.circle, border: Border.all(color: textSecondaryColorGlobal), color: context.cardColor),
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.close_rounded, color: textSecondaryColorGlobal, size: 18),
                                  onPressed: () async {
                                    notificationScreenController.removeNotification(context: context, notificationId: notificationScreenController.notificationDetail[index].id);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        commonDivider,
                      ],
                    ),
                  );
                },
                onNextPage: () async {
                  if (!notificationScreenController.isLastPage.value) {
                    notificationScreenController.page(notificationScreenController.page.value + 1);
                    notificationScreenController.isLoading(true);
                    notificationScreenController.init();
                    return await Future.delayed(const Duration(seconds: 2), () {
                      notificationScreenController.isLoading(false);
                    });
                  }
                },
                onSwipeRefresh: () async {
                  notificationScreenController.page(1);
                  return await notificationScreenController.init();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
