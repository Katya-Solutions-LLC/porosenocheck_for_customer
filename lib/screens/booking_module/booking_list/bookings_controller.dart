import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/screens/home/home_controller.dart';
import 'package:porosenocheck/utils/common_base.dart';
import 'package:stream_transform/stream_transform.dart';
import '../model/booking_data_model.dart';
import '../services/booking_service_apis.dart';

class BookingsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLastPage = false.obs;
  Rx<Future<RxList<BookingDataModel>>> getBookings = Future(() => RxList<BookingDataModel>()).obs;
  RxList<BookingDataModel> bookings = RxList();
  RxInt page = 1.obs;
  RxSet<String> selectedStatus = RxSet();
  RxSet<String> selectedService = RxSet();

  ///Search
  TextEditingController searchCont = TextEditingController();
  RxBool isSearchText = false.obs;
  StreamController<String> searchStream = StreamController<String>();
  final _scrollController = ScrollController();

  @override
  void onInit() {
    _scrollController.addListener(() => Get.context != null ? hideKeyboard(Get.context) : null);
    searchStream.stream.debounce(const Duration(seconds: 1)).listen((s) {
      getBookingList();
    });
    getBookingList(showloader: false);
    super.onInit();
  }

  getBookingList({bool showloader = true, String search = ""}) {
    if (showloader) {
      isLoading(true);
    }
    getBookings(BookingServiceApis.getBookingList(
      filterByStatus: selectedStatus.join(","),
      filterByService: selectedService.join(","),
      page: page.value,
      search: searchCont.text.trim(),
      bookings: bookings,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    )).whenComplete(() => isLoading(false));
  }

  updateBooking({required int bookingId, required String status, VoidCallback? onUpdateBooking}) async {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      "id": bookingId,
      "status": status,
    };

    await BookingServiceApis.updateBooking(request: req).then((value) async {
      if (onUpdateBooking != null) {
        onUpdateBooking.call();
        toast(locale.value.bookingCancelSuccessfully);
      }
      try {
        HomeScreenController hCont = Get.find();
        hCont.init();
      } catch (e) {
        log('onItemSelected Err: $e');
      }
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    });
  }

  @override
  void onClose() {
    searchStream.close();
    if (Get.context != null) {
      _scrollController.removeListener(() => hideKeyboard(Get.context));
    }
    super.onClose();
  }
}
