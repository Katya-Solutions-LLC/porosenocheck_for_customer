import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../../utils/app_common.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/common_base.dart';
import '../../cart/cart_screen.dart';

class CartIconBtn extends StatelessWidget {
  final bool showBGCardColor;
  const CartIconBtn({super.key, this.showBGCardColor = false});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        height: showBGCardColor ? 42 : null,
        decoration: showBGCardColor ? boxDecorationWithShadow(boxShape: BoxShape.circle, backgroundColor: cardColor) : null,
        child: Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart_outlined, color: switchColor, size: 25),
              onPressed: () {
                hideKeyboard(context);
                doIfLoggedIn(context, () {
                  Get.to(() => CartScreen());
                });
              },
            ).paddingRight(cartItemCount.value > 0 ? 5 : 0),
            Positioned(
              top: cartItemCount.value < 10 ? 0 : 4,
              right: cartItemCount.value < 10 ? 12 : 10,
              child: Obx(() => Container(
                    padding: const EdgeInsets.all(4),
                    decoration: boxDecorationDefault(color: primaryColor, shape: BoxShape.circle),
                    child: Text(
                      '${cartItemCount.value}',
                      style: primaryTextStyle(size: cartItemCount.value < 10 ? 12 : 8, color: white),
                    ),
                  ).visible(cartItemCount.value > 0)),
            ),
          ],
        ),
      ),
    );
  }
}
