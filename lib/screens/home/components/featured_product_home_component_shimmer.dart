import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/screens/home/components/featured_product_item_component_shimmer.dart';

class FeaturedProductHomeComponentShimmer extends StatelessWidget {
  const FeaturedProductHomeComponentShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerWidget(padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8)),
            ShimmerWidget(padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8)),
          ],
        ).paddingOnly(left: 16, right: 16),
        24.height,
        AnimatedWrap(
          runSpacing: 16,
          spacing: 16,
          columnCount: 2,
          itemCount: 6,
          itemBuilder: (p0, p1) {
            return const FeaturedProductItemComponentShimmer();
          },
        ).paddingSymmetric(horizontal: 16)
      ],
    ).paddingTop(16);
  }
}
