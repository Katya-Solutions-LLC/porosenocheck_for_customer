import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/screens/home/components/featured_product_item_component_shimmer.dart';
import 'package:porosenocheck/utils/app_common.dart';
import 'package:porosenocheck/utils/colors.dart';

class DashboardFeaturedComponentsShimmer extends StatelessWidget {
  const DashboardFeaturedComponentsShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      width: Get.width,
      decoration: BoxDecoration(color: isDarkMode.value ? whiteColor.withOpacity(0.1) : lightPrimaryColor2),
      child: Wrap(
        direction: Axis.vertical,
        children: [
          SizedBox(
            width: Get.width,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerWidget(padding: EdgeInsets.symmetric(horizontal: 48, vertical: 8)),
                ShimmerWidget(padding: EdgeInsets.symmetric(horizontal: 36, vertical: 8)),
              ],
            ).paddingSymmetric(horizontal: 16),
          ),
          24.height,
          HorizontalList(
            runSpacing: 16,
            spacing: 16,
            wrapAlignment: WrapAlignment.start,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 4,
            itemBuilder: (context, index) {
              return const FeaturedProductItemComponentShimmer();
            },
          )
        ],
      ).paddingSymmetric(vertical: 16),
    );
  }
}
