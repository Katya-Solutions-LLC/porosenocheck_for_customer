// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../utils/app_common.dart';
import '../utils/common_base.dart';

class PriceWidget extends StatelessWidget {
  final num price;
  final String? priceText;
  final double? size;
  final Color? color;
  final Color? hourlyTextColor;
  final bool isBoldText;
  final bool isSemiBoldText;
  final bool isLineThroughEnabled;
  final bool isDiscountedPrice;
  final bool isHourlyService;
  final bool isFreeService;

  const PriceWidget({
    super.key,
    required this.price,
    this.size = 16.0,
    this.color,
    this.hourlyTextColor,
    this.isLineThroughEnabled = false,
    this.isBoldText = true,
    this.isSemiBoldText = false,
    this.isDiscountedPrice = false,
    this.isHourlyService = false,
    this.isFreeService = false,
    this.priceText,
  });

  @override
  Widget build(BuildContext context) {
    TextDecoration? textDecoration() => isLineThroughEnabled ? TextDecoration.lineThrough : null;

    TextStyle _textStyle({int? aSize}) {
      if (isSemiBoldText) {
        return primaryTextStyle(
          size: aSize ?? size!.toInt(),
          color: color ?? context.primaryColor,
          fontFamily: fontFamilyFontWeight600,
          decoration: textDecoration(),
        );
      }
      return isBoldText
          ? boldTextStyle(
              size: aSize ?? size!.toInt(),
              color: color ?? context.primaryColor,
              fontFamily: fontFamilyFontBold,
              decoration: textDecoration(),
            )
          : secondaryTextStyle(
              size: aSize ?? size!.toInt(),
              color: color ?? context.primaryColor,
              decoration: textDecoration(),
            );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          isDiscountedPrice ? ' -' : '',
          style: _textStyle(),
        ),
        Text(
          priceText ?? "${leftCurrencyFormat()}${price.validate().toStringAsFixed(appCurrency.value.noOfDecimal).formatNumberWithComma(seperator: appCurrency.value.thousandSeparator)}${rightCurrencyFormat()}",
          style: _textStyle(),
        ),
      ],
    );
  }
}

String leftCurrencyFormat() {
  if (isCurrencyPositionLeft || isCurrencyPositionLeftWithSpace) {
    return isCurrencyPositionLeftWithSpace ? '${appCurrency.value.currencySymbol} ' : appCurrency.value.currencySymbol;
  }
  return '';
}

String rightCurrencyFormat() {
  if (isCurrencyPositionRight || isCurrencyPositionRightWithSpace) {
    return isCurrencyPositionRightWithSpace ? ' ${appCurrency.value.currencySymbol}' : appCurrency.value.currencySymbol;
  }
  return '';
}
