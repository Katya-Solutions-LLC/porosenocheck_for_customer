import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/common_base.dart';

import '../../../components/cached_image_widget.dart';
import '../../../utils/colors.dart';
import '../../dashboard/dashboard_res_model.dart';
import 'event_detail_screen.dart';

class EventItemComponent extends StatelessWidget {
  final PetEvent event;
  final double? itemWidth;
  final List<PetEvent> youMayAlsoLikeEvent;

  const EventItemComponent({super.key, required this.event, this.itemWidth, this.youMayAlsoLikeEvent = const <PetEvent>[]});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        List<PetEvent> tempEvent = [];
        tempEvent.addAll(youMayAlsoLikeEvent);
        tempEvent.removeWhere((element) => element.id == event.id);
        event.youMayAlsoLikeEvent = tempEvent;
        Get.to(() => EventDetailScreen(), arguments: event);
      },
      child: Stack(
        children: [
          CachedImageWidget(
            url: event.image,
            fit: BoxFit.cover,
            width: itemWidth ?? Get.width,
            height: 300,
            radius: 8.0,
          ),
          Positioned(
            bottom: 16,
            right: 16,
            left: 16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: boxDecorationDefault(
                    color: context.cardColor,
                    shape: BoxShape.rectangle,
                  ),
                  padding: const EdgeInsets.all(8),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      8.width,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(event.date.dayFromDate, style: primaryTextStyle(color: primaryColor, size: 24, fontFamily: GoogleFonts.beVietnamPro(fontWeight: FontWeight.w700).fontFamily)),
                          Text(event.date.monthMMMFormat, style: primaryTextStyle(color: secondaryTextColor, size: 12)),
                        ],
                      ).expand(flex: 1),
                      8.width,
                      const VerticalDivider(color: borderColor).paddingSymmetric(vertical: 26),
                      8.width,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(event.name, maxLines: 1, style: primaryTextStyle(decoration: TextDecoration.none), overflow: TextOverflow.ellipsis),
                          8.height,
                          Text(parseHtmlString(event.description), maxLines: 2, overflow: TextOverflow.ellipsis, style: secondaryTextStyle()),
                          // 4.height,
                          // Text(dashboardController.dashboardData.value.event[index].createdAt.dateInMMMMDyyyyAtHHmmAmPmFormat, style: secondaryTextStyle(size: 9)), //TODO event time here
                        ],
                      ).expand(flex: 4),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
