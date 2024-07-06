import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../main.dart';
import '../../../utils/app_common.dart';
import '../../../utils/view_all_label_component.dart';
import '../../dashboard/dashboard_res_model.dart';
import 'event_item_component.dart';
import 'event_list_screen.dart';

class YourEventsComponents extends StatelessWidget {
  final List<PetEvent> events;
  final bool isFromDetail;
  const YourEventsComponents({Key? key, required this.events, this.isFromDetail = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          ViewAllLabel(
            label: locale.value.upcomingEvents,
            onTap: () {
              Get.to(() => EventListScreen());
            },
          ).paddingOnly(left: 16, right: 8).paddingTop(16).visible(!isFromDetail),
          8.height,
          HorizontalList(
            runSpacing: 16,
            spacing: 16,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return EventItemComponent(event: events[index], youMayAlsoLikeEvent: events, itemWidth: 300);
            },
          ),
        ],
      ).visible(appConfigs.value.isEvent && events.isNotEmpty),
    );
  }
}
