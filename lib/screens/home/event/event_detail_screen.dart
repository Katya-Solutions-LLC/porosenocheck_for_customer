import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/app_scaffold.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/screens/home/event/your_events_components.dart';
import 'package:porosenocheck/utils/common_base.dart';

import '../../../components/cached_image_widget.dart';
import '../../../generated/assets.dart';
import '../../../google_calendar/calendar_event_service.dart';
import '../../../utils/colors.dart';
import '../../../utils/view_all_label_component.dart';
import '../../pet_sitter/employee_detail_screen.dart';
import 'event_detail_controller.dart';

class EventDetailScreen extends StatelessWidget {
  EventDetailScreen({super.key});

  final EventDetailController eventDetailController = Get.put(EventDetailController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBartitleText: eventDetailController.eventDetailFromArg.value.name,
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedImageWidget(
                url: eventDetailController.eventDetailFromArg.value.image,
                width: Get.width,
                fit: BoxFit.fitWidth,
                height: 240,
              ),
              16.height,
              Text(
                eventDetailController.eventDetailFromArg.value.name,
                style: primaryTextStyle(size: 18, decoration: TextDecoration.none),
              ).paddingSymmetric(horizontal: 16),
              16.height,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: eventDetailController.eventDetailFromArg.value.organizerId > 0
                        ? () {
                            Get.to(() => EmployeeDetailScreen(), arguments: eventDetailController.eventDetailFromArg.value.organizerId);
                          }
                        : null,
                    behavior: HitTestBehavior.translucent,
                    child: Row(
                      children: [
                        CachedImageWidget(
                          url: eventDetailController.eventDetailFromArg.value.organizerImage,
                          height: 20,
                          width: 20,
                          circle: true,
                          radius: 25,
                          fit: BoxFit.cover,
                        ),
                        4.width,
                        Text(eventDetailController.eventDetailFromArg.value.organizerName, style: secondaryTextStyle(size: 11)).visible(eventDetailController.eventDetailFromArg.value.organizerName.isNotEmpty),
                      ],
                    ),
                  ),
                  8.width,
                  commonLeadingWid(imgPath: Assets.iconsIcTimeOutlined, icon: Icons.access_time_outlined, color: primaryColor, size: 15).visible(eventDetailController.eventDetailFromArg.value.createdAt.isNotEmpty),
                  Text(eventDetailController.eventDetailFromArg.value.createdAt.isValidDateTime ? " ${eventDetailController.eventDetailFromArg.value.createdAt.timeInHHmmAmPmFormat}" : "", style: secondaryTextStyle(size: 11))
                      .visible(eventDetailController.eventDetailFromArg.value.createdAt.isNotEmpty),
                  8.width,
                  commonLeadingWid(imgPath: Assets.navigationIcCalendarOutlined, icon: Icons.event, color: primaryColor, size: 15),
                  4.width,
                  GestureDetector(
                      onTap: () {
                        showConfirmDialogCustom(
                          context,
                          primaryColor: primaryColor,
                          negativeText: locale.value.cancel,
                          positiveText: locale.value.yes,
                          onAccept: (_) {
                            eventDetailController.isLoading(true);
                            DateTime eventDateTime = eventDetailController.eventDetailFromArg.value.date.dateInyyyyMMddHHmmFormat;
                            String description = locale.value.petEvents;
                            String location = eventDetailController.eventDetailFromArg.value.location;
                            addToGoogleCalendar(
                                    title: "${eventDetailController.eventDetailFromArg.value.organizerName} - ${eventDetailController.eventDetailFromArg.value.name}",
                                    description: description,
                                    location: location,
                                    startTime: eventDateTime,
                                    endTime: eventDateTime.add(const Duration(hours: 1)))
                                .then((isSuccess) {
                              log('ISSUCCESS: $isSuccess');
                              eventDetailController.isLoading(false);
                            });
                          },
                          dialogType: DialogType.CONFIRMATION,
                          title: "${locale.value.doYouWantToAddEvent}?",
                        );
                      },
                      child: Text(eventDetailController.eventDetailFromArg.value.date.dateInyyyyMMddHHmmFormat.toString().dateInMMMMDyyyyFormat, style: secondaryTextStyle(size: 11))),
                ],
              ).paddingSymmetric(horizontal: 16),
              16.height,
              commonDivider,
              if (eventDetailController.eventDetailFromArg.value.description.isNotEmpty && !(eventDetailController.eventDetailFromArg.value.description.contains('<br>')))
                Text(
                  parseHtmlString(eventDetailController.eventDetailFromArg.value.description),
                  style: secondaryTextStyle(),
                ).paddingOnly(left: 16, right: 16, top: 16),
              if (eventDetailController.eventDetailFromArg.value.location.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    32.height,
                    Text(locale.value.location, style: primaryTextStyle(size: 16)).paddingSymmetric(horizontal: 16),
                    8.height,
                    GestureDetector(
                      onTap: () {
                        launchMap(eventDetailController.eventDetailFromArg.value.location);
                      },
                      child: Row(
                        children: [
                          commonLeadingWid(imgPath: Assets.iconsIcMyAddress, icon: Icons.location_on_outlined, color: secondaryColor, size: 22),
                          8.width,
                          Text(eventDetailController.eventDetailFromArg.value.location.replaceAll("\n", ""), style: secondaryTextStyle(), maxLines: 2).expand(),
                        ],
                      ).paddingSymmetric(horizontal: 16),
                    )
                  ],
                ),
              32.height.visible(eventDetailController.eventDetailFromArg.value.organizerEmail.isNotEmpty),
              Text(locale.value.organizerDetail, style: primaryTextStyle(size: 16)).paddingSymmetric(horizontal: 16).visible(eventDetailController.eventDetailFromArg.value.organizerEmail.isNotEmpty),
              16.height.visible(eventDetailController.eventDetailFromArg.value.organizerEmail.isNotEmpty),
              GestureDetector(
                  onTap: () {
                    launchMail(eventDetailController.eventDetailFromArg.value.organizerEmail);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: detailWidget(
                    title: locale.value.email,
                    value: eventDetailController.eventDetailFromArg.value.organizerEmail,
                  ).visible(eventDetailController.eventDetailFromArg.value.organizerEmail.isNotEmpty)),
              8.height.visible(eventDetailController.eventDetailFromArg.value.organizerEmail.isNotEmpty),
              GestureDetector(
                  onTap: () {
                    launchCall(eventDetailController.eventDetailFromArg.value.organizerContactNo);
                  },
                  behavior: HitTestBehavior.translucent,
                  child: detailWidget(
                    title: locale.value.number,
                    value: eventDetailController.eventDetailFromArg.value.organizerContactNo,
                  ).visible(eventDetailController.eventDetailFromArg.value.organizerContactNo.isNotEmpty)),
              32.height,
              ViewAllLabel(
                label: locale.value.youMayAlsoLike,
                isShowAll: false,
              ).visible(eventDetailController.eventDetailFromArg.value.youMayAlsoLikeEvent.isNotEmpty).paddingOnly(left: 16, right: 8),
              YourEventsComponents(events: eventDetailController.eventDetailFromArg.value.youMayAlsoLikeEvent, isFromDetail: true).visible(eventDetailController.eventDetailFromArg.value.youMayAlsoLikeEvent.isNotEmpty),
            ],
          ),
        ));
  }

  Widget detailWidget({required String title, required String value, Color? textColor}) {
    return Row(
      children: [
        Text(title, style: secondaryTextStyle()),
        2.width,
        Text(":", style: secondaryTextStyle()),
        6.width,
        Text(value, style: primaryTextStyle(color: textColor)),
      ],
    ).paddingSymmetric(horizontal: 16).visible(value.isNotEmpty);
  }
}
