import 'package:flutter/material.dart';
import 'package:porosenocheck/components/screen_shimmer.dart';
import 'package:porosenocheck/screens/home/components/featured_product_item_component_shimmer.dart';

class ProductListScreenShimmer extends StatelessWidget {
  const ProductListScreenShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenShimmer(shimmerComponent: FeaturedProductItemComponentShimmer());
  }
}
