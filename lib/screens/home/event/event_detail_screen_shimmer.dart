import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/circle_widget.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/screens/home/event/event_item_component_shimmer.dart';
import 'package:porosenocheck/utils/colors.dart';

class EventDetailScreenShimmer extends StatelessWidget {
  const EventDetailScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedScrollView(
      children: [
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 100),
            decoration: boxDecorationDefault(borderRadius: BorderRadius.zero),
          ),
        ),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(150).paddingLeft(16).paddingBottom(8),
        Row(
          children: List.generate(
            3,
            (index) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShimmerWidget(
                  baseColor: shimmerLightBaseColor,
                  child: const CircleWidget(padding: EdgeInsets.all(12)),
                ),
                8.width,
                const ShimmerWidget(padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8))
              ],
            ).paddingRight(12),
          ),
        ).paddingSymmetric(horizontal: 16),
        12.height,
        ShimmerWidget(
          baseColor: shimmerPrimaryBaseColor,
          child: Divider(
            height: 4,
            color: shimmerLightBaseColor,
            indent: 16,
            endIndent: 16,
          ),
        ),
        24.height,
        ...List.generate(
          3,
          (index) => ShimmerWidget(
            baseColor: shimmerLightBaseColor,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
              decoration: boxDecorationDefault(),
            ),
          ),
        ),
        24.height,
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(140),
        8.height,
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShimmerWidget(
              baseColor: shimmerLightBaseColor,
              child: const CircleWidget(padding: EdgeInsets.all(12)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget(
                  baseColor: shimmerLightBaseColor,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 8),
                    decoration: boxDecorationDefault(),
                  ),
                ),
                ShimmerWidget(
                  baseColor: shimmerLightBaseColor,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    decoration: boxDecorationDefault(),
                  ),
                ),
              ],
            ).expand()
          ],
        ).paddingSymmetric(horizontal: 16),
        28.height,
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(140),
        8.height,
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ),
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(140),
        24.height,
        ShimmerWidget(
          baseColor: shimmerLightBaseColor,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
            decoration: boxDecorationDefault(),
          ),
        ).paddingRight(140),
        16.height,
        const EventItemComponentShimmer().paddingLeft(16)
      ],
    );
  }
}
