// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../components/cached_image_widget.dart';
import '../../configs.dart';

import '../../generated/assets.dart';
import '../../main.dart';
import '../../utils/app_common.dart';
import '../../utils/colors.dart';
import '../../utils/common_base.dart';

class ConfirmBookingDialog extends StatelessWidget {
  RxBool isAgree = false.obs;
  final VoidCallback onConfirm;
  final String? titleText;
  final String? subTitleText;
  final String? confirmText;
  final String? changeToastMessage;
  final bool hideAgree;
  ConfirmBookingDialog({
    super.key,
    required this.onConfirm,
    this.titleText,
    this.subTitleText,
    this.confirmText,
    this.changeToastMessage,
    this.hideAgree = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: boxDecorationDefault(color: context.cardColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 100,
            width: 100,
            alignment: Alignment.center,
            decoration: boxDecorationDefault(shape: BoxShape.circle, color: secondaryColor),
            child: const CachedImageWidget(url: Assets.imagesConfirm, height: 50, width: 50, fit: BoxFit.contain),
          ),
          16.height,
          Text(titleText ?? locale.value.confirmBooking, style: primaryTextStyle()),
          16.height,
          Text(subTitleText ?? locale.value.doYouConfirmThisBooking, textAlign: TextAlign.center, style: primaryTextStyle(color: secondaryTextColor)).paddingSymmetric(horizontal: 32),
          16.height,
          Obx(
            () => CheckboxListTile(
              checkColor: whiteColor,
              value: isAgree.value,
              activeColor: primaryColor,
              onChanged: (val) async {
                isAgree.value = !isAgree.value;
              },
              checkboxShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              side: const BorderSide(color: secondaryTextColor, width: 1.5),
              title: Text("${confirmText ?? locale.value.iHaveReadAll} $APP_NAME.", style: secondaryTextStyle()),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ).paddingSymmetric(horizontal: 16).visible(!hideAgree),
          ),
          32.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton(
                text: locale.value.cancel,
                textStyle: appButtonTextStyleGray,
                color: isDarkMode.value ? lightPrimaryColor2 : lightSecondaryColor,
                onTap: () {
                  Get.back();
                },
              ).expand(),
              32.width,
              AppButton(
                text: locale.value.confirm,
                textStyle: appButtonTextStyleWhite,
                onTap: () {
                  if (hideAgree) {
                    onConfirm.call();
                  } else {
                    if (isAgree.value) {
                      onConfirm.call();
                    } else {
                      toast(changeToastMessage ?? locale.value.pleaseAcceptTermsAnd);
                    }
                  }
                },
              ).expand(),
            ],
          ).paddingSymmetric(horizontal: 32),
        ],
      ),
    );
  }
}
