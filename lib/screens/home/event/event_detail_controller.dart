import 'package:get/get.dart';

import '../../dashboard/dashboard_res_model.dart';

class EventDetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<PetEvent> eventDetail = RxList();
  Rx<PetEvent> eventDetailFromArg = PetEvent().obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    if (Get.arguments is PetEvent) {
      eventDetailFromArg(Get.arguments as PetEvent);
    }
  }
}
