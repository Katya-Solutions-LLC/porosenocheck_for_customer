import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../components/app_scaffold.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/common_base.dart';
import 'billing_address_controller.dart';
import 'order_summary_screen.dart';

class BillingAddressScreen extends StatelessWidget {
  BillingAddressScreen({super.key});

  final GlobalKey<FormState> _additionalformKey = GlobalKey<FormState>();

  final BillingAddressController additionalInfoController = Get.put(BillingAddressController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.billingAddress,
      body: Stack(
        children: [
          AnimatedScrollView(
            children: [
              Form(
                key: _additionalformKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    AppTextField(
                      title: locale.value.fullName,
                      textStyle: primaryTextStyle(size: 12),
                      focus: additionalInfoController.fullNameFocus,
                      controller: additionalInfoController.fullNameCont, // Optional
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG}  ${locale.value.doe}",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                      suffix: Assets.profileIconsIcUserOutlined.iconImage(fit: BoxFit.contain).paddingAll(14),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      title: locale.value.email,
                      textStyle: primaryTextStyle(size: 12),
                      focus: additionalInfoController.emailFocus,
                      controller: additionalInfoController.emailCont, // Optional
                      textFieldType: TextFieldType.EMAIL,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} merry_456@gmail.com",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                      suffix: Assets.iconsIcMail.iconImage(fit: BoxFit.contain).paddingAll(14),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      maxLength: 12,
                      title: locale.value.contactNumber,
                      textStyle: primaryTextStyle(size: 12),
                      textFieldType: TextFieldType.PHONE,
                      controller: additionalInfoController.mobileCont,
                      focus: additionalInfoController.mobileFocus,
                      errorThisFieldRequired: locale.value.thisFieldIsRequired,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG}  1-2188219848",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    AppTextField(
                      maxLength: 12,
                      title: locale.value.alternateContactNumber,
                      textStyle: primaryTextStyle(size: 12),
                      textFieldType: TextFieldType.PHONE,
                      controller: additionalInfoController.alternateMobileCont,
                      focus: additionalInfoController.alternateFocus,
                      errorThisFieldRequired: locale.value.thisFieldIsRequired,
                      isValidationRequired: false,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG}  1-2188219848",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ).paddingSymmetric(horizontal: 16),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: AppButton(
              width: Get.width,
              textStyle: appButtonTextStyleWhite,
              onTap: () async {
                if (_additionalformKey.currentState!.validate()) {
                  _additionalformKey.currentState!.save();
                  Get.to(() => OrderSummaryScreen());
                }
              },
              child: Text(locale.value.confirm, style: boldTextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
