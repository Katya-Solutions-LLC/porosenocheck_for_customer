// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';

import '../generated/assets.dart';
import '../screens/shop/shop_dashboard/product_list_controller.dart';
import '../utils/common_base.dart';

class SearchBarWidget extends StatelessWidget {
  final String? hintText;
  final Function(String)? onFieldSubmitted;
  final Function()? onTap;
  final Function()? onClearButton;
  final ProductListController productListController;

  const SearchBarWidget({
    super.key,
    this.hintText,
    this.onTap,
    this.onFieldSubmitted,
    this.onClearButton,
    required this.productListController,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: productListController.searchCont,
      textFieldType: TextFieldType.OTHER,
      textInputAction: TextInputAction.done,
      textStyle: primaryTextStyle(),
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (p0) {
        productListController.isSearchText(productListController.searchCont.text.trim().isNotEmpty);
        productListController.searchStream.add(p0);
      },
      suffix: Obx(
        () => appCloseIconButton(
          context,
          onPressed: () {
            hideKeyboard(context);
            productListController.searchCont.clear();
            productListController.isSearchText(productListController.searchCont.text.trim().isNotEmpty);
            if (onClearButton != null) {
              onClearButton!.call();
            }
          },
          size: 11,
        ).visible(productListController.isSearchText.value),
      ),
      decoration: inputDecorationWithOutBorder(
        context,
        hintText: hintText ?? locale.value.searchHere,
        filled: true,
        fillColor: context.cardColor,
        prefixIcon: commonLeadingWid(imgPath: Assets.iconsIcSearch, icon: Icons.search_outlined, size: 18).paddingAll(14),
      ),
    );
  }
}
