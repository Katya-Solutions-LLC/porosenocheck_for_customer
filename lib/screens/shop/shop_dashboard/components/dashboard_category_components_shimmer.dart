import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/components/shimmer_widget.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/components/category_item_components_shimmer.dart';

class DashboardCategoryComponentsShimmer extends StatelessWidget {
  final int columnCount;
  final int itemCount;

  final bool showLabel;
  const DashboardCategoryComponentsShimmer({Key? key, this.columnCount = 2, this.showLabel = false, this.itemCount = 6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        if (showLabel)
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
        if (showLabel) 28.height,
        AnimatedWrap(
          runSpacing: 16,
          spacing: 16,
          columnCount: columnCount,
          listAnimationType: ListAnimationType.None,
          itemCount: itemCount,
          itemBuilder: (p0, p1) {
            return const CategoryItemComponentsShimmer();
          },
        ).paddingSymmetric(horizontal: 16)
      ],
    );
  }
}
