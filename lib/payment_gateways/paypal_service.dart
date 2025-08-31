// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/app_common.dart';
import '../../configs.dart';
import '../../utils/constants.dart';

class PayPalService {
  static Future<void> paypalCheckOut({
    required BuildContext context,
    required num totalAmount,
    required Function(Map<String, dynamic>) onComplete,
    required Function(bool) loderOnOFF,
  }) async {
    // Временно отключено - требуется обновление зависимостей
    toast("PayPal payment temporarily unavailable - updating dependencies");
    loderOnOFF(false);
    
    // TODO: Восстановить после обновления зависимостей
    // onComplete.call({
    //   'transaction_id': 'paypal_placeholder_${DateTime.now().millisecondsSinceEpoch}',
    // });
  }
}
