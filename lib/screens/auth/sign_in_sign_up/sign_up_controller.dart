// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../services/auth_service_apis.dart';
import 'sign_in_controller.dart';

class SignUpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool agree = false.obs;
  RxBool isAcceptedTc = false.obs;
  TextEditingController emailCont = TextEditingController();
  TextEditingController fisrtNameCont = TextEditingController();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController mobileCont = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode fisrtNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode mobileFocus = FocusNode();

  saveForm() async {
    if (isAcceptedTc.value) {
      isLoading(true);
      hideKeyBoardWithoutContext();
      Map<String, dynamic> req = {
        "first_name": fisrtNameCont.text.trim(),
        "last_name": lastNameCont.text.trim(),
        "email": emailCont.text.trim(),
        "mobile": mobileCont.text.trim(),
        "password": passwordCont.text.trim(),
        UserKeys.userType: LoginTypeConst.LOGIN_TYPE_USER,
      };

      await AuthServiceApis.createUser(request: req).then((value) async {
        toast(value.message.toString(), print: true);
        try {
          final SignInController sCont = Get.find();
          sCont.emailCont.text = emailCont.text.trim();
          sCont.passwordCont.text = passwordCont.text.trim();
          isLoading(true);
          sCont.saveForm().whenComplete(() => isLoading(false));
        } catch (e) {
          isLoading(false);
          log('E: $e');
          toast(e.toString(), print: true);
        }
        // Get.offUntil(GetPageRoute(page: () => SignInScreen()), (route) => route.isFirst || route.settings.name == '/$OptionScreen');
      }).catchError((e) {
        isLoading(false);
        toast(e.toString(), print: true);
      }).whenComplete(() => isLoading(false));
    } else {
      toast(locale.value.pleaseAcceptTermsAnd);
    }
  }
}
