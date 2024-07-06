import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_common.dart';

class BillingAddressController extends GetxController {
  RxBool isLoading = false.obs;

  TextEditingController fullNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();
  TextEditingController alternateMobileCont = TextEditingController();

  FocusNode fullNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();
  FocusNode alternateFocus = FocusNode();

  @override
  void onInit() {
    fullNameCont.text = loginUserData.value.userName;
    emailCont.text = loginUserData.value.email;
    mobileCont.text = loginUserData.value.mobile;
    super.onInit();
  }
}
