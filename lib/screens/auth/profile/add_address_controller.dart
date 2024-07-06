import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/common_base.dart';

import '../model/address_models/address_list_response.dart';
import '../model/address_models/country_list_response.dart';
import '../model/address_models/logistic_zone_response.dart';
import '../model/address_models/state_list_response.dart';
import '../services/addresses_apis.dart';

class AddAddressController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<CountryData> countryList = RxList();
  RxList<StateData> stateList = RxList();
  RxList<CityData> cityList = RxList();

  Rx<CountryData> selectedCountry = CountryData().obs;
  Rx<StateData> selectedState = StateData().obs;
  Rx<CityData> selectedCity = CityData(pivot: Pivot()).obs;
  Rx<UserAddress> addressData = UserAddress(id: (-1).obs).obs;

  TextEditingController firstNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController addressLine1Controller = TextEditingController();
  TextEditingController addressLine2Controller = TextEditingController();
  TextEditingController pinCodeCont = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode addressLine1FocusNode = FocusNode();
  FocusNode addressLine2FocusNode = FocusNode();
  FocusNode pinCodeFocus = FocusNode();

  RxBool isEdit = false.obs;
  RxBool isPrimary = false.obs;

  RxInt countryId = 0.obs;
  RxInt stateId = 0.obs;
  RxInt cityId = 0.obs;

  @override
  void onInit() {
    if (Get.arguments is UserAddress) {
      addressData(Get.arguments as UserAddress);
      isEdit(true);
      firstNameCont.text = addressData.value.firstName;
      lastNameCont.text = addressData.value.lastName;
      addressLine1Controller.text = addressData.value.addressLine1;
      addressLine2Controller.text = addressData.value.addressLine2;
      pinCodeCont.text = addressData.value.postalCode.toString();
      cityId(addressData.value.city.toInt());
      stateId(addressData.value.state.toInt());
      countryId(addressData.value.country.toInt());
      isPrimary(addressData.value.isPrimary.getBoolInt());
    }
    init();
    super.onInit();
  }

  Future<void> init() async {
    if (countryId.value != 0) {
      await getCountry();
      await getStates(countryId.value);
      if (stateId.value != 0) {
        await getCity(stateId.value);
      }
    } else {
      await getCountry();
    }
  }

  Future<void> getCountry() async {
    isLoading(true);

    await UserAddressesApis.getCountryList().then((value) async {
      isLoading(false);
      countryList.clear();
      countryList(value);

      for (var e in value) {
        if (e.id == countryId.value) {
          selectedCountry(e);
        }
      }
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  Future<void> getStates(int countryId) async {
    isLoading(true);

    await UserAddressesApis.getStateList(countryId: countryId).then((value) async {
      isLoading(false);
      stateList.clear();
      stateList(value);
      for (var e in value) {
        if (e.id == stateId.value) {
          selectedState(e);
        }
      }
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  Future<void> getCity(int stateId) async {
    isLoading(true);

    await UserAddressesApis.getCityList(stateId: stateId).then((value) async {
      isLoading(false);
      cityList.clear();
      cityList(value);
      for (var e in value) {
        if (e.id == cityId.value) {
          selectedCity(e);
        }
      }
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  addEditAddress() {
    isLoading(true);
    hideKeyBoardWithoutContext();

    //TODO: Model keys
    Map req = {
      "first_name": firstNameCont.text.trim(),
      "last_name": lastNameCont.text.trim(),
      "address_line_1": addressLine1Controller.text.trim(),
      "address_line_2": addressLine2Controller.text.trim(),
      "postal_code": pinCodeCont.text.trim(),
      "city": cityId.value,
      "state": stateId.value,
      "country": countryId.value,
      "is_primary": isPrimary.value.getIntBool(),
    };

    if (isEdit.value) {
      req.putIfAbsent("id", () => addressData.value.id.value);
    }

    UserAddressesApis.addEditAddress(request: req, isEdit: isEdit.value).then((value) {
      Get.back(result: true);
      isLoading(false);
    }).catchError(onError);
  }
}
