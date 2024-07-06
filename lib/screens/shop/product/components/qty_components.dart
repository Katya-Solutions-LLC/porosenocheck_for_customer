import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/colors.dart';
import 'package:porosenocheck/utils/view_all_label_component.dart';

import '../product_controller.dart';

class QtyComponents extends StatelessWidget {
  final ProductDetailController productController;

  const QtyComponents({super.key, required this.productController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        8.height,
        ViewAllLabel(label: locale.value.quantity, isShowAll: false).paddingSymmetric(horizontal: 16),
        Container(
          decoration: boxDecorationDefault(color: containerColor, shape: BoxShape.rectangle),
          width: Get.width * 0.35,
          height: 40,
          child: Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    if (productController.qtyCount.value > 1) productController.qtyCount.value--;
                  },
                  icon: const Icon(Icons.remove, color: iconColor, size: 15),
                ),
                Text(
                  '${productController.qtyCount}',
                  style: secondaryTextStyle(color: iconColor),
                ),
                IconButton(
                  onPressed: () {
                    if (productController.qtyCount.value < productController.selectedVariationData.value.productStockQty) {
                      productController.qtyCount.value++;
                    } else {
                      Fluttertoast.cancel();
                      toast("${locale.value.outOfStock}!!!");
                    }
                  },
                  icon: const Icon(Icons.add, color: iconColor, size: 15),
                ),
              ],
            ),
          ),
        ).paddingSymmetric(horizontal: 16),
      ],
    );
  }
}
