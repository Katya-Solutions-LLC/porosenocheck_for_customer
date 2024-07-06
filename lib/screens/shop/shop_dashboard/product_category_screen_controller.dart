import 'package:get/get.dart';
import 'package:porosenocheck/screens/shop/shop_dashboard/model/category_response.dart';

import 'dashboard_shop_apis.dart';

class ProductCategoryScreenController extends GetxController {
  Rx<Future<List<CategoryData>>> future = Future(() => <CategoryData>[]).obs;
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  RxList<CategoryData> categoryList = RxList();
  RxInt page = 1.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    await future(DashboardShopApi.getCategory(
      page: page.value,
      category: categoryList,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).whenComplete(
      () => isLoading(false),
    ));
  }
}
