// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/home/model/about_page_res.dart';

import '../../home/services/home_service_apis.dart';
import '../services/auth_service_apis.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../../utils/app_common.dart';
import '../../../utils/constants.dart';
import '../../../utils/local_storage.dart';
import '../../home/home_controller.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    try {
      final aboutPageResFromLocal = getValueFromLocal(APICacheConst.ABOUT_RESPONSE);
      if (aboutPageResFromLocal != null) {
        aboutPages(AboutPageRes.fromJson(aboutPageResFromLocal).data);
      }
    } catch (e) {
      log('aboutPageResFromLocal from cache E: $e');
    }
    getAboutPageData();
  }

  handleLogout() async {
    if (isLoading.value) return;
    isLoading(true);
    log('HANDLELOGOUT: called');
    await AuthServiceApis.logoutApi().then((value) async {
      await AuthServiceApis.clearData();
      isLoading(false);
      Get.offAll(() => DashboardScreen(), binding: BindingsBuilder(() {
        Get.put(HomeScreenController());
      }));
    }).catchError((e) {
      isLoading(false);
      toast(e.toString());
    });
  }

  ///Get ChooseService List
  getAboutPageData({bool isFromSwipRefresh = false}) {
    if (!isFromSwipRefresh) {
      isLoading(true);
    }
    isLoading(true);
    HomeServiceApis.getAboutPageData().then((value) {
      isLoading(false);
      aboutPages(value.data);
      setValueToLocal(APICacheConst.ABOUT_RESPONSE, value.toJson());
    }).onError((error, stackTrace) {
      isLoading(false);
      toast(error.toString());
    });
  }
}
