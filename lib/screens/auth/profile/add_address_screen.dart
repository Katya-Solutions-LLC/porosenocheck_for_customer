import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/auth/profile/add_address_controller.dart';
import 'package:porosenocheck/utils/app_common.dart';

import '../../../components/app_scaffold.dart';
import '../../../generated/assets.dart';
import '../../../main.dart';
import '../../../utils/colors.dart';
import '../../../utils/common_base.dart';
import '../model/address_models/country_list_response.dart';
import '../model/address_models/logistic_zone_response.dart';
import '../model/address_models/state_list_response.dart';

class AddAddressScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final ScrollController scrollController = ScrollController();

  final AddAddressController addAddressController = Get.put(AddAddressController());

  AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBartitleText: locale.value.myAddresses,
      isLoading: addAddressController.isLoading,
      body: Stack(
        children: [
          AnimatedScrollView(
            controller: scrollController,
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 60, top: 30),
            children: [
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      title: locale.value.firstName,
                      textStyle: primaryTextStyle(size: 12),
                      controller: addAddressController.firstNameCont,
                      focus: addAddressController.firstNameFocus,
                      nextFocus: addAddressController.lastNameFocus,
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(
                        context,
                        hintText: '${locale.value.eG}  ${locale.value.merry}',
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                      suffix: Assets.profileIconsIcUserOutlined.iconImage(fit: BoxFit.contain).paddingAll(14),
                    ),
                    16.height,
                    AppTextField(
                      title: locale.value.lastName,
                      textStyle: primaryTextStyle(size: 12),
                      controller: addAddressController.lastNameCont,
                      focus: addAddressController.lastNameFocus,
                      textFieldType: TextFieldType.NAME,
                      decoration: inputDecoration(
                        context,
                        hintText: '${locale.value.eG}  ${locale.value.merry}',
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                      suffix: Assets.profileIconsIcUserOutlined.iconImage(fit: BoxFit.contain).paddingAll(14),
                    ),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(locale.value.country, style: primaryTextStyle()),
                            4.height,
                            Obx(
                              () => DropdownButtonFormField<CountryData>(
                                decoration: inputDecoration(
                                  context,
                                  hintText: locale.value.selectCountry,
                                  fillColor: context.cardColor,
                                  filled: true,
                                ),
                                isExpanded: true,
                                validator: (value) {
                                  if (value == null) {
                                    return locale.value.thisFieldIsRequired;
                                  }

                                  return null;
                                },
                                value: addAddressController.selectedCountry.value.id > 0 ? addAddressController.selectedCountry.value : null,
                                dropdownColor: context.cardColor,
                                items: addAddressController.countryList.map((CountryData e) {
                                  return DropdownMenuItem<CountryData>(
                                    value: e,
                                    child: Text(e.name, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  );
                                }).toList(),
                                onChanged: (CountryData? value) async {
                                  hideKeyboard(context);
                                  addAddressController.countryId(value!.id);
                                  addAddressController.selectedCountry(value);
                                  addAddressController.selectedState(StateData());
                                  addAddressController.selectedCity(CityData(pivot: Pivot()));
                                  addAddressController.getStates(value.id);
                                },
                              ),
                            ),
                          ],
                        ).expand(),
                        Obx(() => 12.width.visible(addAddressController.stateList.isNotEmpty)),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(locale.value.state, style: primaryTextStyle()),
                              4.height,
                              Obx(
                                () => DropdownButtonFormField<StateData>(
                                  decoration: inputDecoration(
                                    context,
                                    hintText: locale.value.selectState,
                                    fillColor: context.cardColor,
                                    filled: true,
                                  ),
                                  isExpanded: true,
                                  validator: (value) {
                                    if (value == null) {
                                      return locale.value.thisFieldIsRequired;
                                    }

                                    return null;
                                  },
                                  dropdownColor: context.cardColor,
                                  value: addAddressController.selectedState.value.id > 0 ? addAddressController.selectedState.value : null,
                                  items: addAddressController.stateList.map((StateData e) {
                                    return DropdownMenuItem<StateData>(
                                      value: e,
                                      child: Text(e.name, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                                    );
                                  }).toList(),
                                  onChanged: (StateData? value) async {
                                    hideKeyboard(context);
                                    addAddressController.selectedCity(CityData(pivot: Pivot()));
                                    addAddressController.selectedState(value);
                                    addAddressController.stateId(value!.id);
                                    await addAddressController.getCity(value.id);
                                  },
                                ),
                              ),
                            ],
                          ).expand().visible(addAddressController.stateList.isNotEmpty),
                        ),
                      ],
                    ),
                    16.height,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(locale.value.city, style: primaryTextStyle()),
                              4.height,
                              DropdownButtonFormField<CityData>(
                                decoration: inputDecoration(
                                  context,
                                  hintText: locale.value.selectCity,
                                  fillColor: context.cardColor,
                                  filled: true,
                                ),
                                isExpanded: true,
                                validator: (value) {
                                  if (value == null) {
                                    return locale.value.thisFieldIsRequired;
                                  }

                                  return null;
                                },
                                value: addAddressController.selectedCity.value.id > 0 ? addAddressController.selectedCity.value : null,
                                style: primaryTextStyle(size: 12),
                                dropdownColor: context.cardColor,
                                items: addAddressController.cityList.map((CityData e) {
                                  return DropdownMenuItem<CityData>(
                                    value: e,
                                    child: Text(e.name, style: primaryTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  );
                                }).toList(),
                                onChanged: (CityData? value) async {
                                  hideKeyboard(context);
                                  addAddressController.selectedCity(value);
                                  addAddressController.cityId(value!.id);
                                },
                              ),
                            ],
                          ).expand().visible(addAddressController.cityList.isNotEmpty),
                        ),
                        Obx(() => 12.width.visible(addAddressController.cityList.isNotEmpty)),
                        AppTextField(
                          title: locale.value.pinCode,
                          textStyle: primaryTextStyle(size: 12),
                          textFieldType: TextFieldType.NUMBER,
                          controller: addAddressController.pinCodeCont,
                          focus: addAddressController.pinCodeFocus,
                          nextFocus: addAddressController.addressLine1FocusNode,
                          decoration: inputDecoration(
                            context,
                            hintText: '${locale.value.eG} 123456',
                            fillColor: context.cardColor,
                            filled: true,
                          ),
                          onTap: () {
                            scrollController.animToBottom();
                          },
                          onChanged: (p0) {
                            scrollController.animToBottom();
                          },
                        ).expand(),
                      ],
                    ),
                    16.height,
                    AppTextField(
                      title: "${locale.value.addressLine} 1",
                      textStyle: primaryTextStyle(size: 12),
                      textFieldType: TextFieldType.MULTILINE,
                      minLines: 3,
                      controller: addAddressController.addressLine1Controller,
                      nextFocus: addAddressController.addressLine2FocusNode,
                      focus: addAddressController.addressLine1FocusNode,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} 123, ${locale.value.mainStreet}",
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ),
                    16.height,
                    AppTextField(
                      title: "${locale.value.addressLine} 2",
                      textStyle: primaryTextStyle(size: 12),
                      textFieldType: TextFieldType.MULTILINE,
                      minLines: 3,
                      isValidationRequired: false,
                      controller: addAddressController.addressLine2Controller,
                      focus: addAddressController.addressLine2FocusNode,
                      decoration: inputDecoration(
                        context,
                        hintText: "${locale.value.eG} ${locale.value.apt} 4B", //No Localization here
                        fillColor: context.cardColor,
                        filled: true,
                      ),
                    ),
                    8.height,
                    setAsPrimaryWidget(),
                    16.height,
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
              color: primaryColor,
              onTap: () async {
                if (!addAddressController.isLoading.value) {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    /// Add Or Edit Address Api Call
                    addAddressController.addEditAddress();
                  }
                }
              },
              child: Text(addAddressController.isEdit.value ? locale.value.saveChanges : locale.value.save, style: primaryTextStyle(color: white)),
            ),
          ),
        ],
      ),
    );
  }

  /// region Service List Widget
  Widget setAsPrimaryWidget() {
    return Obx(
      () => ListTileTheme(
        horizontalTitleGap: 0.0,
        child: CheckboxListTile(
          value: addAddressController.isPrimary.value,
          checkColor: white,
          title: Text(locale.value.setAsPrimary, style: primaryTextStyle(color: isDarkMode.value ? textPrimaryColorGlobal : primaryColor, size: 14)),
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          checkboxShape: RoundedRectangleBorder(borderRadius: radius(5)),
          side: const BorderSide(color: primaryColor),
          dense: true,
          activeColor: isDarkMode.value ? primaryColor : primaryColor,
          onChanged: (value) {
            addAddressController.isPrimary(!addAddressController.isPrimary.value);
          },
        ),
      ),
    );
  }
}
