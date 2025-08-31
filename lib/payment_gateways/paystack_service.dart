// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/app_common.dart';
import '../../configs.dart';
import '../../utils/constants.dart';

class PayStackService {
  late dynamic paystackPlugin;
  num totalAmount = 0;
  int bookingId = 0;
  late Function(Map<String, dynamic>) onComplete;
  late Function(bool) loderOnOFF;

  init({
    required num totalAmount,
    required int bookingId,
    required Function(Map<String, dynamic>) onComplete,
    required Function(bool) loderOnOFF,
  }) {
    // Временно отключено - требуется обновление зависимостей
    this.totalAmount = totalAmount;
    this.bookingId = bookingId;
    this.onComplete = onComplete;
    this.loderOnOFF = loderOnOFF;
  }

  Future<void> checkout(BuildContext context) async {
    // Временно отключено - требуется обновление зависимостей
    toast("PayStack payment temporarily unavailable - updating dependencies");
    loderOnOFF(false);
    
    // TODO: Восстановить после обновления зависимостей
    // onComplete.call({
    //   'transaction_id': 'paystack_placeholder_${DateTime.now().millisecondsSinceEpoch}',
    // });
  }
}
