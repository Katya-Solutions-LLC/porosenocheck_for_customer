import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/constants.dart';

import '../../../components/cached_image_widget.dart';
import '../../../components/price_widget.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../../pet_sitter/employee_detail_screen.dart';
import '../booking_detail/booking_detail_screen.dart';
import '../model/booking_data_model.dart';
import '../services/booking_service_apis.dart';
import '../services/service_navigation.dart';
import 'bookings_controller.dart';

class BookingCard extends StatelessWidget {
  final BookingDataModel appointment;
  final bool isFromHome;
  final VoidCallback? onUpdateBooking;

  BookingCard({super.key, required this.appointment, this.isFromHome = false, this.onUpdateBooking});

  final BookingsController bookingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
        Get.to(() => BookingDetailScreen(), arguments: appointment);
      },
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 16, bottom: isFromHome ? 0 : 24),
            decoration: boxDecorationDefault(color: context.cardColor, shape: BoxShape.rectangle),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                16.height,
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: '#${appointment.id}',
                        child: Text(
                          '#${appointment.id}',
                          style: primaryTextStyle(decoration: TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${locale.value.bookingStatus}:", style: secondaryTextStyle()),
                    4.width,
                    Text(
                      getBookingStatus(status: appointment.status),
                      style: primaryTextStyle(size: 12, color: getBookingStatusColor(status: appointment.status)),
                    ),
                  ],
                ),
                16.height,
                commonDivider,
                16.height,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    16.width,
                    SizedBox(
                      width: Get.width * 0.2,
                      child: Column(
                        children: [
                          8.height,
                          CachedImageWidget(
                            url: appointment.petImage,
                            firstName: appointment.petName,
                            height: 54,
                            width: 54,
                            fit: BoxFit.cover,
                            circle: true,
                          ),
                          8.height,
                          Marquee(child: Text(appointment.petName, textAlign: TextAlign.center, style: primaryTextStyle(size: 12))),
                        ],
                      ),
                    ),
                    8.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        8.height,
                        detailWidget(title: locale.value.schedule, value: scheduleDate),
                        detailWidgetPrice(title: locale.value.price, value: appointment.payment.totalAmount, textColor: getPriceStatusColor(paymentStatus: appointment.payment.paymentStatus)),
                        detailWidget(title: locale.value.duration, value: appointment.duration.toFormattedDuration(showFullTitleHoursMinutes: true)),
                        detailWidget(
                          title: getEmployeeRoleByServiceElement(appointment: appointment),
                          value: appointment.employeeName,
                          prefixImage: appointment.employeeImage,
                          employeeId: appointment.employeeId,
                        ).visible(appointment.employeeName.isNotEmpty),
                        detailWidget(title: locale.value.address, value: getAddressByServiceElement(appointment: appointment)),
                      ],
                    ).expand(),
                  ],
                ),
                if (appointment.status.contains(BookingStatusConst.PENDING) && !appointment.payment.paymentStatus.toLowerCase().contains(PaymentStatus.PAID)) ...[
                  8.height,
                  AppButton(
                    width: Get.width,
                    text: locale.value.cancel,
                    textStyle: appButtonTextStyleWhite,
                    color: primaryColor,
                    onTap: () {
                      showConfirmDialogCustom(
                        getContext,
                        primaryColor: primaryColor,
                        negativeText: locale.value.cancel,
                        positiveText: locale.value.yes,
                        onAccept: (_) {
                          bookingsController.updateBooking(bookingId: appointment.id, status: BookingStatusConst.CANCELLED, onUpdateBooking: onUpdateBooking);
                        },
                        dialogType: DialogType.DELETE,
                        title: "${locale.value.doYouWantToCancelBooking}?",
                      );
                    },
                  ).paddingSymmetric(horizontal: 16),
                ],
                if (appointment.status.contains(BookingStatusConst.COMPLETED) && appointment.service.status.getBoolInt()) ...[
                  8.height,
                  AppButton(
                    width: Get.width,
                    text: locale.value.bookAgain,
                    textStyle: appButtonTextStyleWhite,
                    color: primaryColor,
                    onTap: () async {
                      bookingsController.isLoading(true);
                      BookingDataModel? bData;
                      await BookingServiceApis.getBookingDetail(bookingId: appointment.id).then((value) {
                        bData = value.data;
                        navigateToService(appointment.service, arguments: bData);
                      }).onError((error, stackTrace) {
                        toast(error.toString());
                      }).whenComplete(() => bookingsController.isLoading(false));
                    },
                  ).paddingSymmetric(horizontal: 16),
                ],
                16.height,
              ],
            ).paddingTop(32),
          ),
          Positioned(
            top: -8,
            left: Get.width * 0.163,
            right: Get.width * 0.163,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: boxDecorationDefault(borderRadius: BorderRadius.circular(40), color: context.scaffoldBackgroundColor),
              child: Container(
                height: 42,
                decoration: boxDecorationDefault(
                  borderRadius: BorderRadius.circular(40),
                  color: lightSecondaryColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CachedImageWidget(
                      url: getServiceIconByServiceElement(appointment.service),
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                      color: secondaryColor,
                    ).visible(getServiceIconByServiceElement(appointment.service).isNotEmpty),
                    12.width,
                    Text(getServiceNameByServiceElement(serviceSlug: appointment.service.slug), style: primaryTextStyle(color: secondaryColor)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get scheduleDate {
    try {
      return appointment.startDateTime.isValidDateTime ? appointment.startDateTime.dateInddMMMyyyyHHmmAmPmFormat : " - ";
    } catch (e) {
      log('get scheduleDate E: $e');
      return " - ";
    }
  }

  Widget detailWidget({required String title, int employeeId = -1, required String value, Color? textColor, String? prefixImage}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Marquee(child: Text(title, style: secondaryTextStyle(), textAlign: TextAlign.left)).expand(flex: 3),
        Text(":  ", style: secondaryTextStyle()),
        GestureDetector(
          onTap: employeeId > 0
              ? () {
                  Get.to(() => EmployeeDetailScreen(), arguments: employeeId);
                }
              : null,
          behavior: HitTestBehavior.translucent,
          child: Row(
            children: [
              CachedImageWidget(
                url: prefixImage.validate(),
                height: 20,
                width: 20,
                circle: true,
                radius: 20,
                fit: BoxFit.cover,
              ).visible(prefixImage != null),
              8.width.visible(prefixImage != null),
              Marquee(
                directionMarguee: DirectionMarguee.oneDirection,
                child: Text(
                  value,
                  style: primaryTextStyle(size: 12, color: textColor),
                  textAlign: TextAlign.left,
                ),
              ).expand(),
            ],
          ),
        ).expand(flex: 6),
      ],
    ).paddingBottom(8).visible(value.trim().isNotEmpty);
  }

  Widget detailWidgetPrice({required String title, required num value, Color? textColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Marquee(child: Text(title, style: secondaryTextStyle(), textAlign: TextAlign.left)).expand(flex: 3),
        Text(":  ", style: secondaryTextStyle()),
        2.width,
        PriceWidget(
          price: value,
          color: textColor ?? black,
          size: 12,
          isBoldText: true,
        ).expand(flex: 6)
      ],
    ).paddingBottom(10);
  }
}
