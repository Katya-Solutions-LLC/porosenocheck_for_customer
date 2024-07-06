import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/circle_widget.dart';
import 'package:porosenocheck/components/screen_shimmer.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/utils/colors.dart';

class NotificationScreenShimmer extends StatelessWidget {
  const NotificationScreenShimmer({Key? key}) : super(key: key);

  Widget notificationComponentShimmer() {
    return SizedBox(
      width: Get.width - 32,
      child: Column(
        children: [
          Row(
            children: [
              ShimmerWidget(
                baseColor: shimmerLightBaseColor,
                child: const CircleWidget(
                  padding: EdgeInsets.all(18),
                ),
              ),
              Column(
                children: List.generate(
                  3,
                  (index) => const ShimmerWidget(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  ).paddingRight(70).paddingSymmetric(vertical: 4),
                ),
              ).paddingSymmetric(horizontal: 16).expand(),
              CircleWidget(
                circleColor: shimmerLightBaseColor,
                padding: const EdgeInsets.all(4),
                child: ShimmerWidget(
                  child: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: shimmerPrimaryBaseColor.withOpacity(0.4),
                  ),
                ),
              ),
            ],
          ),
          ShimmerWidget(
            child: Divider(
              color: shimmerPrimaryBaseColor.withOpacity(0.4),
              height: 16,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenShimmer(
      shimmerComponent: notificationComponentShimmer(),
      itemCount: 15,
    );
  }
}
