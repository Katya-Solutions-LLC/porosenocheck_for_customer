import 'package:flutter/material.dart';
import 'package:porosenocheck/components/screen_shimmer.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/components/category_item_components_shimmer.dart';

class ProductCategoryScreenShimmer extends StatelessWidget {
  const ProductCategoryScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenShimmer(shimmerComponent: CategoryItemComponentsShimmer());
  }
}
