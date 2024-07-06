import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/utils/constants.dart';

import '../main.dart';
import '../screens/auth/model/notification_model.dart';
import '../screens/booking_module/booking_detail/booking_detail_screen.dart';
import '../screens/booking_module/model/booking_data_model.dart';
import '../screens/dashboard/dashboard_res_model.dart';
import '../screens/shop/cart/model/cart_list_model.dart';
import '../screens/shop/order/order_detail_screen.dart';
import '../screens/shop/product/model/product_review_response.dart';
import '../screens/shop/shop_dashboard/model/product_list_response.dart';
import 'app_common.dart';

class PushNotificationService {
// It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupFirebaseMessaging() async {
    await initFirebaseMessaging();

    await enableIOSNotifications();
  }

  Future<void> initFirebaseMessaging() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(alert: true, badge: true, sound: true, provisional: true).catchError((e) {
      log('------Request Notification Permission ERROR-----------');
    });

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('------Request Notification Permission COMPLETED-----------');
      await registerNotificationListeners().then((value) {
        log('------Notification Listener REGISTRATION COMPLETED-----------');
      }).catchError((e) {
        log('------Notification Listener REGISTRATION ERROR-----------');
      });

      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true).then((value) {
        log('------setForegroundNotificationPresentationOptions COMPLETED-----------');
      }).catchError((e) {
        log('------setForegroundNotificationPresentationOptions ERROR-----------');
      });
    }
  }

  Future<void> registerFCMAndTopics() async {
    if (isLoggedIn.value) {
      if (Platform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken != null) {
          subScribeToTopic();
        } else {
          Future.delayed(const Duration(seconds: 3), () async {
            apnsToken = await FirebaseMessaging.instance.getAPNSToken();
            if (apnsToken != null) {
              subScribeToTopic();
            }
          });
        }
        log("===============${FirebaseTopicConst.apnsNotificationTokenKey}===============\n$apnsToken");
      }
      FirebaseMessaging.instance.getToken().then((token) {
        log("===============${FirebaseTopicConst.fcmNotificationTokenKey}===============\n$token");
      });
      subScribeToTopic();
    }
  }

  Future<void> subScribeToTopic() async {
    await FirebaseMessaging.instance.subscribeToTopic(appNameTopic).whenComplete(() {
      log("${FirebaseTopicConst.topicSubscribed}$appNameTopic");
    });
    await FirebaseMessaging.instance.subscribeToTopic("${FirebaseTopicConst.userWithUnderscoreKey}${loginUserData.value.id}").then((value) {
      log("${FirebaseTopicConst.topicSubscribed}${FirebaseTopicConst.userWithUnderscoreKey}${loginUserData.value.id}");
    });
  }

  Future<void> unsubscribeFirebaseTopic() async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(appNameTopic).then((value) {
      log("${FirebaseTopicConst.topicUnSubscribed}$appNameTopic");
    });
    await FirebaseMessaging.instance.unsubscribeFromTopic('${FirebaseTopicConst.userWithUnderscoreKey}${loginUserData.value.id}').then((value) {
      log("${FirebaseTopicConst.topicUnSubscribed}${FirebaseTopicConst.userWithUnderscoreKey}${loginUserData.value.id}");
    });
  }

  void handleNotificationClick(RemoteMessage message, {bool isForeGround = false}) {
    printLogsNotificationData(message);
    NotificationData notificationData = NotificationData.fromJson(message.data);
    log("===============${FirebaseTopicConst.notificationDataKey}===============\n${notificationData.toJson()}");
    if (isForeGround) {
      showNotification(currentTimeStamp(), message.notification!.title.validate(), message.notification!.body.validate(), message);
    } else {
      log('=============== ELSE PART ===============');
      try {
        Map<String, dynamic> additionalData = jsonDecode(message.data[FirebaseTopicConst.additionalDataKey]) ?? {};
        if (additionalData.isNotEmpty) {
          int? notId = additionalData[FirebaseTopicConst.idKey];
          log("notId=== $notId");
          if (notId != null) {
            log("additionalData[FirebaseTopicConst.notificationGroupKey]=== ${additionalData[FirebaseTopicConst.notificationGroupKey]}");
            log("FirebaseTopicConst.shopKey=== ${FirebaseTopicConst.shopKey}");
            if (additionalData[FirebaseTopicConst.notificationGroupKey] == FirebaseTopicConst.shopKey) {
              log("============ IN SHOP ================");
              Get.to(
                () => OrderDetailScreen(),
                arguments: CartListData(
                  orderId: additionalData[FirebaseTopicConst.idKey],
                  id: additionalData[FirebaseTopicConst.itemIdKey],
                  orderCode: additionalData[FirebaseTopicConst.orderCodeKey],
                  qty: 0.obs,
                  productVariation: VariationData(inCart: false.obs),
                  productReviewData: ProductReviewDataModel(),
                ),
              );
            } else {
              log("============ IN BOOKING ================");
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  return Get.to(
                    () => BookingDetailScreen(),
                    arguments: BookingDataModel(
                      id: notId,
                      service: SystemService(slug: additionalData[FirebaseTopicConst.bookingServicesNameKey].toString().toLowerCase()),
                      payment: PaymentDetails(),
                      training: Training(),
                    ),
                  );
                },
              );
            }
          }
        }
      } catch (e) {
        log('${FirebaseTopicConst.notificationErrorKey}: $e');
      }
    }
  }

  Future<void> registerNotificationListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      handleNotificationClick(message, isForeGround: true);
    }, onError: (e) {
      log("${FirebaseTopicConst.onMessageListen} $e");
    });

    // replacement for onResume: When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationClick(message);
    }, onError: (e) {
      log("${FirebaseTopicConst.onMessageOpened} $e");
    });

    // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        handleNotificationClick(message);
      }
    }, onError: (e) {
      log("${FirebaseTopicConst.onGetInitialMessage} $e");
    });
  }

  void showNotification(int id, String title, String message, RemoteMessage remoteMessage) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    //code for background notification channel
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      FirebaseTopicConst.notificationChannelIdKey,
      FirebaseTopicConst.notificationChannelNameKey,
      importance: Importance.high,
      enableLights: true,
      playSound: true,
      showBadge: true,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_stat_onesignal_default');

    var iOS = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) {
        handleNotificationClick(remoteMessage, isForeGround: true);
      },
    );
    var macOS = iOS;

    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: iOS, macOS: macOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (details) {
      handleNotificationClick(remoteMessage);
    });

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      FirebaseTopicConst.notificationChannelIdKey,
      FirebaseTopicConst.notificationChannelNameKey,
      importance: Importance.high,
      visibility: NotificationVisibility.public,
      autoCancel: true,
      //color: primaryColor,
      playSound: true,
      priority: Priority.high,
      icon: '@drawable/ic_stat_onesignal_default',
    );

    var darwinPlatformChannelSpecifics = const DarwinNotificationDetails(
      presentSound: true,
      presentBanner: true,
      presentBadge: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: darwinPlatformChannelSpecifics,
      macOS: darwinPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin.show(id, title, message, platformChannelSpecifics);
  }

  Future<void> enableIOSNotifications() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  void printLogsNotificationData(RemoteMessage message) {
    log("====================");
    log('${FirebaseTopicConst.notificationDataKey} : ${message.data}');
    log('${FirebaseTopicConst.notificationTitleKey} : ${message.notification?.title}');
    log('${FirebaseTopicConst.bookingServicesNameKey} : ${message.notification?.body}');
    log('${FirebaseTopicConst.messageDataCollapseKey} : ${message.collapseKey}');
    log('${FirebaseTopicConst.messageDataMessageIdKey} : ${message.messageId}');
    log('${FirebaseTopicConst.messageDataMessageTypeKey} : ${message.messageType}');
  }
}
