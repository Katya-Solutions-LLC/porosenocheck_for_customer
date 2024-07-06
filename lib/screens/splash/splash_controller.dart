// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/auth/services/auth_service_apis.dart';
import '../../utils/common_base.dart';
import '../auth/model/login_response.dart';
import '../dashboard/dashboard_screen.dart';
import '../walkthrough/walkthrough_screen.dart';
import '../../utils/app_common.dart';
import '../../utils/constants.dart';
import '../../utils/local_storage.dart';
import '../home/home_controller.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    init();
  }

  @override
  void onReady() {
    try {
      final getThemeFromLocal = getValueFromLocal(SettingsLocalConst.THEME_MODE);
      if (getThemeFromLocal is int) {
        toggleThemeMode(themeId: getThemeFromLocal);
      } else {
        toggleThemeMode(themeId: THEME_MODE_SYSTEM);
      }
    } catch (e) {
      log('getThemeFromLocal from cache E: $e');
    }
    super.onReady();
  }

  void init() {
    getAppConfigurations();
  }

  ///Get ChooseService List
  getAppConfigurations() {
    AuthServiceApis.getAppConfigurations().then((value) {
      appCurrency(value.currency);
      appConfigs(value);
      
      ///Navigation logic
      navigationLogic();
    }).onError((error, stackTrace) {
      toast(error.toString());

      ///Navigation logic
      navigationLogic();
    });
  }

  void navigationLogic() {
    if ((getValueFromLocal(SharedPreferenceConst.FIRST_TIME) ?? false) == false) {
      Get.offAll(() => WalkthroughScreen());
    } else if (getValueFromLocal(SharedPreferenceConst.IS_LOGGED_IN) == true) {
      try {
        final userData = getValueFromLocal(SharedPreferenceConst.USER_DATA);
        isLoggedIn(true);
        loginUserData(UserData.fromJson(userData));
        Get.offAll(() => DashboardScreen(), binding: BindingsBuilder(() {
          Get.put(HomeScreenController());
        }));
      } catch (e) {
        log('SplashScreenController Err: $e');
        Get.offAll(() => DashboardScreen(), binding: BindingsBuilder(() {
          Get.put(HomeScreenController());
        }));
      }
    } else {
      Get.offAll(() => DashboardScreen(), binding: BindingsBuilder(() {
        Get.put(HomeScreenController());
      }));
    }
  }
}
