// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/generated/assets.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/app_common.dart';
import 'package:uuid/uuid.dart';
import '../../configs.dart';
import '../../utils/constants.dart';
import '../network/network_utils.dart';

class FlutterWaveService {
  final Customer customer = Customer(
    name: loginUserData.value.userName,
    phoneNumber: loginUserData.value.mobile,
    email: loginUserData.value.email,
  );

  void checkout({
    required BuildContext ctx,
    required num totalAmount,
    required int bookingId,
    required bool isTestMode,
    required Function(Map<String, dynamic>) onComplete,
    required Function(bool) loderOnOFF,
  }) async {
    String transactionId = const Uuid().v1();

    Flutterwave flutterWave = Flutterwave(
      publicKey: appConfigs.value.flutterwavePay.flutterwavePublickey,
      currency: appCurrency.value.currencyCode,
      redirectUrl: BASE_URL,
      txRef: "$transactionId$bookingId",
      amount: totalAmount.validate().toStringAsFixed(Constants.DECIMAL_POINT),
      customer: customer,
      paymentOptions: "ussd, card, payattitude, barter, bank transfer",
      customization: Customization(title: locale.value.payWithFlutterwave, logo: Assets.imagesLogo),
      isTestMode: isTestMode,
    );

    await flutterWave.charge(ctx).then((value) {
      if (value.status == "successful") {
        verifyPayment(
          transactionId: value.transactionId.validate(),
          flutterWaveSecretKey: appConfigs.value.flutterwavePay.flutterwaveSecretkey,
          loderOnOFF: loderOnOFF,
        ).then((isSuccess) async {
          if (isSuccess) {
            onComplete.call({
              'transaction_id': value.transactionId.validate(value: "#$bookingId"),
            });
          } else {
            toast(locale.value.transactionFailed);
          }
        }).catchError((e) {
          toast(e.toString());
        });
      } else {
        toast(locale.value.transactionCancelled);
      }
    });
  }
}

//region FlutterWave Verify Transaction API
Future<bool> verifyPayment({required String transactionId, required String flutterWaveSecretKey, required Function(bool) loderOnOFF}) async {
  try {
    var res = await handleResponse(
      await buildHttpResponse("https://api.flutterwave.com/v3/transactions/$transactionId/verify", extraKeys: {
        'isFlutterWave': true,
        'flutterWaveSecretKey': appConfigs.value.flutterwavePay.flutterwaveSecretkey,
      }),
      isFlutterWave: true,
    );
    log("Response: $res");
    loderOnOFF.call(false);
    return res["status"] == "success";
  } catch (e) {
    toast(e.toString(), print: true);
  }
  return false;
}
//endregion
