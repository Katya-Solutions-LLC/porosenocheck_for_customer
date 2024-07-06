import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/home/model/pet_center_detail.dart';
import 'package:porosenocheck/screens/auth/other/settings_screen.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/shop_dashboard_screen.dart';
import '../auth/profile/profile_controller.dart';
import '../auth/services/auth_service_apis.dart';
import '../booking_module/booking_list/bookings_screen.dart';
import '../home/services/home_service_apis.dart';
import '../home/model/status_list_res.dart';
import '../auth/profile/profile_screen.dart';
import '../home/home_screen.dart';
import '../../utils/app_common.dart';
import '../../utils/common_base.dart';
import '../../utils/constants.dart';
import '../../utils/local_storage.dart';
import '../pet/my_pets_controller.dart';
import '../shop/order/order_apis.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool isLoading = false.obs;

  RxList<StatelessWidget> screen = [
    HomeScreen(),
    BookingsScreen(),
    ShopDashboardScreen(),
    isLoggedIn.value ? ProfileScreen() : SettingScreen(),
  ].obs;

  @override
  void onInit() {
    myPetsScreenController.init();
    if (!isLoggedIn.value) {
      ProfileController().getAboutPageData();
    }
    init();
    super.onInit();
  }

  @override
  void onReady() {
    if (Get.context != null) {
      View.of(Get.context!).platformDispatcher.onPlatformBrightnessChanged = () {
        WidgetsBinding.instance.handlePlatformBrightnessChanged();
        try {
          final getThemeFromLocal = getValueFromLocal(SettingsLocalConst.THEME_MODE);
          if (getThemeFromLocal is int) {
            toggleThemeMode(themeId: getThemeFromLocal);
          }
        } catch (e) {
          log('getThemeFromLocal from cache E: $e');
        }
      };
    }
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.context != null) {
        showForceUpdateDialog(Get.context!);
      }
    });
    super.onReady();
  }

  void reloadBottomTabs() {
    screen(<StatelessWidget>[
      HomeScreen(),
      BookingsScreen(),
      ShopDashboardScreen(),
      isLoggedIn.value ? ProfileScreen() : SettingScreen(),
    ]);
  }

  void init() {
    try {
      final statusListResFromLocal = getValueFromLocal(APICacheConst.STATUS_RESPONSE);
      if (statusListResFromLocal != null) {
        allStatus(StatusListRes.fromJson(statusListResFromLocal).data);
      }
    } catch (e) {
      log('statusListResFromLocal from cache E: $e');
    }
    try {
      final petCenterResFromLocal = getValueFromLocal(APICacheConst.PET_CENTER_RESPONSE);
      if (petCenterResFromLocal != null) {
        petCenterDetail(PetCenterRes.fromJson(petCenterResFromLocal).data);
      }
    } catch (e) {
      log('petCenterResFromLocal from cache E: $e');
    }
    getAllStatusUsedForBooking();
    getPetCenterDetail();
    getAppConfigurations(isFromDashboard: true);
    getAllStatusUsedForOrder();
  }

  ///Get ChooseService List
  getAllStatusUsedForBooking() {
    isLoading(true);
    HomeServiceApis.getAllStatusUsedForBooking().then((value) {
      isLoading(false);
      allStatus(value.data);
      setValueToLocal(APICacheConst.STATUS_RESPONSE, value.toJson());
    }).onError((error, stackTrace) {
      isLoading(false);
      toast(error.toString());
    });
  }

  getAllStatusUsedForOrder() {
    isLoading(true);
    OrderApis.getOrderFilterStatus().then((value) {
      isLoading(false);
      allOrderStatus(value.data);
      setValueToLocal(APICacheConst.STATUS_RESPONSE, value.toJson());
    }).onError((error, stackTrace) {
      isLoading(false);
      toast(error.toString());
    });
  }

  ///Get ChooseService List
  getPetCenterDetail() {
    isLoading(true);
    HomeServiceApis.getPetCenterDetail().then((value) {
      isLoading(false);
      petCenterDetail(value.data);
      setValueToLocal(APICacheConst.PET_CENTER_RESPONSE, value.toJson());
    }).onError((error, stackTrace) {
      isLoading(false);
      toast(error.toString());
    });
  }
}

///Get ChooseService List
getAppConfigurations({bool isFromDashboard = false}) {
  AuthServiceApis.getAppConfigurations().then((value) async {
    appCurrency(value.currency);
    appConfigs(value);

    /// Place ChatGPT Key Here
    chatGPTAPIkey = value.chatgptKey;

    if (getValueFromLocal(SharedPreferenceConst.IS_LOGGED_IN) == true && appConfigs.value.isUserPushNotification && isFromDashboard) {
      await Future.delayed(const Duration(seconds: 1));
    }
    setValueToLocal(APICacheConst.APP_CONFIGURATION_RESPONSE, value.toJson());
  }).onError((error, stackTrace) {
    toast(error.toString());
  });
}
