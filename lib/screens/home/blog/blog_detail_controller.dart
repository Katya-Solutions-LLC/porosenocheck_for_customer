import 'package:get/get.dart';

import '../../dashboard/dashboard_res_model.dart';

class BlogDetailController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Blog> blogDetailFromArg = Blog().obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    if (Get.arguments is Blog) {
      blogDetailFromArg(Get.arguments as Blog);
    }
  }
}
