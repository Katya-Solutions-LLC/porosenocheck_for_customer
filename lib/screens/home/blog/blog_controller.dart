import 'package:get/get.dart';
import 'package:porosenocheck/screens/home/services/home_service_apis.dart';

import '../../dashboard/dashboard_res_model.dart';

class BlogController extends GetxController {
  Rx<Future<List<Blog>>> getBlog = Future(() => <Blog>[]).obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxList<Blog> blogList = RxList();
  RxInt page = 1.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    await getBlog(HomeServiceApis.getBlog(
      page: page.value,
      blogs: blogList,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).whenComplete(() => isLoading(false)));
  }
}
