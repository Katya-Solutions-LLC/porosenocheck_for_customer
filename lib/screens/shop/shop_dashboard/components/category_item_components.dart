import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../../components/cached_image_widget.dart';
import '../model/category_response.dart';

class CategoryItemComponents extends StatelessWidget {
  final double? width;
  final CategoryData categoryData;

  const CategoryItemComponents({super.key, required this.categoryData, this.width});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? Get.width / 3 - 20,
      padding: EdgeInsets.zero,
      decoration: boxDecorationWithRoundedCorners(backgroundColor: context.cardColor),
      child: Column(
        children: [
          CachedImageWidget(
            url: categoryData.categoryImage.validate(),
            width: width ?? Get.width * 3 - 20,
            height: 85,
            fit: BoxFit.cover,
            radius: defaultRadius,
          ),
          Marquee(
            directionMarguee: DirectionMarguee.oneDirection,
            child: Text(
              categoryData.name.validate(),
              style: primaryTextStyle(size: 12),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ).paddingSymmetric(vertical: 8, horizontal: 8),
        ],
      ),
    );
  }
}
