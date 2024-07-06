import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/view_all_label_component.dart';
import '../../shop_dashboard/model/product_list_response.dart';
import '../product_controller.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';

class DeliveryOptionComponents extends StatelessWidget {
  final ProductItemData productData;
  final ProductDetailController productController;

  const DeliveryOptionComponents({super.key, required this.productController, required this.productData});

  @override
  Widget build(BuildContext context) {
    if (productData.description.isEmpty || productData.description.contains('<p>')) {
      return const Offstage();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        16.height,
        ViewAllLabel(label: locale.value.productDetails, isShowAll: false).paddingSymmetric(horizontal: 16),
        ReadMoreText(
          parseHtmlString(productData.description),
          trimLines: 3,
          style: secondaryTextStyle(size: 13),
          colorClickableText: secondaryColor,
          trimMode: TrimMode.Line,
          trimCollapsedText: " ...${locale.value.readMore}",
          trimExpandedText: locale.value.readLess,
          locale: Localizations.localeOf(context),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
