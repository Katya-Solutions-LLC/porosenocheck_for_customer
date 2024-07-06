// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../main.dart';
import '../services/auth_service_apis.dart';
import '../model/notification_model.dart';

class NotificationScreenController extends GetxController {
  Rx<Future<List<NotificationData>>> getNotifications = Future(() => <NotificationData>[]).obs;
  RxBool isLoading = false.obs;
  RxList<NotificationData> notificationDetail = RxList();
  RxBool isLastPage = false.obs;
  RxInt page = 1.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    await getNotifications(
      AuthServiceApis.getNotificationDetail(
        page: page.value,
        perPage: 8,
        notifications: notificationDetail,
        lastPageCallBack: (p0) {
          isLastPage(p0);
        },
      ),
    ).then((value) {
      log('value.length ==> ${value.length}');
    }).whenComplete(() => isLoading(false));
  }

  Future<void> removeNotification({required BuildContext context, required String notificationId}) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: "${locale.value.doYouWantToRemoveNotification}?",
      positiveText: locale.value.yes,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        isLoading(true);
        await AuthServiceApis.removeNotification(notificationId: notificationId).then((value) {
          init();
          toast("${locale.value.notificationDeleted}  ${locale.value.successfully}");
        }).catchError((error) {
          toast(error.toString());
        }).whenComplete(() => isLoading(false));
      },
    );
  }

  Future<void> clearAllNotification({required BuildContext context}) async {
    showConfirmDialogCustom(
      context,
      primaryColor: context.primaryColor,
      title: "${locale.value.doYouWantToClearAllNotification}?",
      positiveText: locale.value.yes,
      negativeText: locale.value.cancel,
      onAccept: (ctx) async {
        isLoading(true);
        await AuthServiceApis.clearAllNotification().then((value) {
          init();
        }).catchError((error) {
          toast(error.toString());
        }).whenComplete(() => isLoading(false));
      },
    );
  }
}
