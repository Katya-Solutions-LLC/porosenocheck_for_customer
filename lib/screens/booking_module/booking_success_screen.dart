// ignore_for_file: must_be_immutable
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/configs.dart';
import 'package:porosenocheck/main.dart';
import '../../components/cached_image_widget.dart';
import '../../google_calendar/calendar_event_service.dart';
import '../../utils/app_common.dart';
import '../../utils/common_base.dart';
import '../../components/app_scaffold.dart';
import '../../generated/assets.dart';
import '../../utils/colors.dart';
import 'model/save_booking_res.dart';
import 'services/service_navigation.dart';

class BookingSuccess extends StatelessWidget {
  BookingSuccess({super.key});
  RxBool isLoading = false.obs;
  @override
  Widget build(BuildContext context) {
    log('BOOKINGSUCCESSDATE.VALUE.: ${bookingSuccessDate.value}');
    return AppScaffold(
      hideAppBar: true,
      isLoading: isLoading,
      body: Container(
        alignment: Alignment.center,
        height: Get.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.only(left: 16,right: 16,bottom: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: boxDecorationDefault(color: context.scaffoldBackgroundColor),
                    child: Image.asset(Assets.imagesVector4), //TODO replace this vector
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    alignment: Alignment.center,
                    decoration: boxDecorationDefault(shape: BoxShape.circle, color: bookingVerifyColor),
                    child: const CachedImageWidget(
                      url: Assets.imagesConfirm,
                      height: 50,
                      width: 50,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              32.height,
              SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  locale.value.yourAppointmentHasBeen,
                  textAlign: TextAlign.center,
                  style: primaryTextStyle(size: 18),
                ),
              ),
              16.height,
              SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  saveBookingRes.value.bookingId.isNegative ? locale.value.yourPetAppointmentIs : "${locale.value.yourBookingIdIs} #${saveBookingRes.value.bookingId}${locale.value.eWillBe}.",
                  textAlign: TextAlign.center,
                  style: secondaryTextStyle(color: secondaryTextColor),
                ),
              ),
              Obx(() => 32.height.visible(bookingSuccessDate.value.isNotEmpty)),
              Obx(
                () => Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: boxDecorationDefault(
                    color: primaryTextColor,
                    shape: BoxShape.rectangle,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Assets.iconsIcTimeOutlined.iconImage(color: Colors.white, size: 15, fit: BoxFit.contain),
                      8.width,
                      Text(bookingSuccessDate.value.dateInEEEEDMMMMAtHHmmAmPmFormat, style: primaryTextStyle(size: 12, color: Colors.white)),
                    ],
                  ),
                ).visible(bookingSuccessDate.value.isNotEmpty),
              ),
              Obx(() => 36.height.visible(bookingSuccessDate.value.isNotEmpty)),
              Obx(
                () => TextButton(
                  onPressed: () {
                    isLoading(true);
                    // Replace these values with the event date and name you want to add
                    DateTime eventDateTime = bookingSuccessDate.value.dateInyyyyMMddHHmmFormat;
                    String description = "${getServiceNameByServiceElement(serviceSlug: currentSelectedService.value.slug)}-#${saveBookingRes.value.bookingId}";
                    addToGoogleCalendar(title: "$APP_NAME ${locale.value.booking}", description: description, location: "", startTime: eventDateTime, endTime: eventDateTime.add(const Duration(hours: 1))).then((isSuccess) {
                      log('ISSUCCESS: $isSuccess');
                      if (isSuccess) {
                        /// To Clear Value
                        bookingSuccessDate("");
                        saveBookingRes(SaveBookingRes());
                        Get.back();
                      }
                      isLoading(false);
                    });
                  },
                  child: Text(locale.value.addToGoogleCalendar,
                      style: primaryTextStyle(
                        size: 12,
                        color: primaryColor,
                        decorationColor: primaryColor,
                        decoration: TextDecoration.underline,
                      )),
                ).visible(bookingSuccessDate.value.isNotEmpty),
              ),
              58.height,
              AppButton(
                width: Get.width,
                text: locale.value.goToBookings,
                textStyle: appButtonTextStyleWhite,
                onTap: () {
                  /// To Clear Value
                  bookingSuccessDate("");
                  saveBookingRes(SaveBookingRes());
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* void addToGoogleCalendar(DateTime eventDateTime, String eventName) {
  final url = 'https://www.google.com/calendar/event?action=TEMPLATE&dates=${eventDateTime.toIso8601String()}/${eventDateTime.toIso8601String()}&text=$eventName';

  if (Platform.isAndroid) {
    final AndroidIntent intent = AndroidIntent(
      action: 'action_view',
      data: url,
    );
    intent.launch();
  } else if (Platform.isIOS) {
    /*  final IOSIntent intent = IOSIntent(
      url: Uri.parse(url),
    );
    intent.launch(); */ //TODO not find suitable intent pakage for ios
  } else {
    // For other platforms, fallback to opening in browser
    commonLaunchUrl(url, launchMode: LaunchMode.externalApplication);
  }
} */
