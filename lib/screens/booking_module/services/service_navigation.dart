import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/generated/assets.dart';
import 'package:porosenocheck/screens/booking_module/add_booking_forms/boarding_service_controller.dart';
import 'package:porosenocheck/screens/booking_module/add_booking_forms/daycare_service_controller.dart';
import 'package:porosenocheck/screens/booking_module/add_booking_forms/grooming_service_controller.dart';
import 'package:porosenocheck/screens/booking_module/add_booking_forms/training_service_controller.dart';
import 'package:porosenocheck/screens/booking_module/add_booking_forms/veterinery_service_controller.dart';
import 'package:porosenocheck/screens/booking_module/add_booking_forms/walking_service_controller.dart';
import 'package:porosenocheck/main.dart';
import 'package:porosenocheck/utils/colors.dart';

import '../../dashboard/dashboard_screen.dart';
import '../../home/home_controller.dart';
import '../../pet/model/pet_list_res_model.dart';
import '../../pet/my_pets_controller.dart';
import '../booking_list/bookings_controller.dart';
import '../../dashboard/dashboard_controller.dart';
import '../../../utils/app_common.dart';
import '../../../utils/constants.dart';
import '../model/booking_data_model.dart';
import '../add_booking_forms/boarding_service_screen.dart';
import '../add_booking_forms/daycare_service_screen.dart';
import '../add_booking_forms/grooming_service_screen.dart';
import '../../dashboard/dashboard_res_model.dart';
import '../booking_success_screen.dart';
import '../add_booking_forms/training_service_screen.dart';
import '../add_booking_forms/veterinery_service_screen.dart';
import '../add_booking_forms/walking_service_screen.dart';
import '../model/choose_pet_widget.dart';

void navigateToService(SystemService service, {dynamic arguments}) {
  try {
    HomeScreenController hCont = Get.find();
    hCont.init();
  } catch (e) {
    log('onChooseService Err: $e');
  }
  currentSelectedService(service);
  myPetsScreenController.init();
  selectedPet(PetData());
  if (service.slug.contains(ServicesKeyConst.boarding)) {
    Get.to(() => BoardingServicesScreen(), arguments: arguments, duration: const Duration(milliseconds: 800));
  } else if (service.slug.contains(ServicesKeyConst.veterinary)) {
    Get.to(() => VeterineryServiceScreen(), arguments: arguments, duration: const Duration(milliseconds: 800));
  } else if (service.slug.contains(ServicesKeyConst.grooming)) {
    Get.to(() => GroomingScreen(), arguments: arguments, duration: const Duration(milliseconds: 800));
  } else if (service.slug.contains(ServicesKeyConst.walking)) {
    Get.to(() => WalkingServiceScreen(), arguments: arguments, duration: const Duration(milliseconds: 800));
  } else if (service.slug.contains(ServicesKeyConst.training)) {
    Get.to(() => TrainingServiceScreen(), arguments: arguments, duration: const Duration(milliseconds: 800));
  } else if (service.slug.contains(ServicesKeyConst.dayCare)) {
    Get.to(() => DayCareScreen(), arguments: arguments, duration: const Duration(milliseconds: 800));
  }
}

String getServiceKeyByServiceElement(SystemService service) {
  if (service.slug.contains(ServicesKeyConst.boarding)) {
    return ServicesKeyConst.boarding;
  } else if (service.slug.contains(ServicesKeyConst.veterinary)) {
    return ServicesKeyConst.veterinary;
  } else if (service.slug.contains(ServicesKeyConst.grooming)) {
    return ServicesKeyConst.grooming;
  } else if (service.slug.contains(ServicesKeyConst.walking)) {
    return ServicesKeyConst.walking;
  } else if (service.slug.contains(ServicesKeyConst.training)) {
    return ServicesKeyConst.training;
  } else if (service.slug.contains(ServicesKeyConst.dayCare)) {
    return ServicesKeyConst.dayCare;
  } else {
    return "";
  }
}

String getServiceNameByServiceElement({required String serviceSlug}) {
  if (serviceSlug.contains(ServicesKeyConst.boarding)) {
    return locale.value.boarding;
  } else if (serviceSlug.contains(ServicesKeyConst.veterinary)) {
    return locale.value.veterinary;
  } else if (serviceSlug.contains(ServicesKeyConst.grooming)) {
    return locale.value.grooming;
  } else if (serviceSlug.contains(ServicesKeyConst.walking)) {
    return locale.value.walking;
  } else if (serviceSlug.contains(ServicesKeyConst.training)) {
    return locale.value.training;
  } else if (serviceSlug.contains(ServicesKeyConst.dayCare)) {
    return locale.value.daycare;
  } else {
    return "";
  }
}

String getServiceIconByServiceElement(SystemService service) {
  if (service.slug.contains(ServicesKeyConst.boarding)) {
    return Assets.serviceIconsIcBoarding;
  } else if (service.slug.contains(ServicesKeyConst.veterinary)) {
    return Assets.serviceIconsIcVeterinary;
  } else if (service.slug.contains(ServicesKeyConst.grooming)) {
    return Assets.serviceIconsIcGrooming;
  } else if (service.slug.contains(ServicesKeyConst.walking)) {
    return Assets.serviceIconsIcWalking;
  } else if (service.slug.contains(ServicesKeyConst.training)) {
    return Assets.serviceIconsIcTraining;
  } else if (service.slug.contains(ServicesKeyConst.dayCare)) {
    return Assets.serviceIconsIcDaycare;
  } else {
    return Assets.serviceIconsIcDaycare;
  }
}

String getAddressByServiceElement({required BookingDataModel appointment}) {
  if (appointment.service.slug.contains(ServicesKeyConst.boarding)) {
    return petCenterDetail.value.addressLine1;
  } else if (appointment.service.slug.contains(ServicesKeyConst.veterinary)) {
    return petCenterDetail.value.addressLine1;
  } else if (appointment.service.slug.contains(ServicesKeyConst.grooming)) {
    return petCenterDetail.value.addressLine1;
  } else if (appointment.service.slug.contains(ServicesKeyConst.walking)) {
    return appointment.address;
  } else if (appointment.service.slug.contains(ServicesKeyConst.training)) {
    return petCenterDetail.value.addressLine1;
  } else if (appointment.service.slug.contains(ServicesKeyConst.dayCare)) {
    return appointment.address;
  } else {
    return "";
  }
}

(Map<String, dynamic>, List<PlatformFile>? files) getBookingReqByServiceType({required String serviceType}) {
  try {
    if (serviceType.contains(ServicesKeyConst.boarding)) {
      BoardingServiceController bCont = Get.find();
      return (bCont.bookBoardingReq.toJson(), null);
    } else if (serviceType.contains(ServicesKeyConst.veterinary)) {
      VeterineryController vCont = Get.find();
      return (vCont.bookVeterinaryReq.toJson(), vCont.medicalReportfiles);
    } else if (serviceType.contains(ServicesKeyConst.grooming)) {
      GroomingController gCont = Get.find();
      return (gCont.bookGroomingReq.toJson(), null);
    } else if (serviceType.contains(ServicesKeyConst.walking)) {
      WalkingServiceController wCont = Get.find();
      return (wCont.bookWalkingReq.toJson(), null);
    } else if (serviceType.contains(ServicesKeyConst.training)) {
      TrainingController tCont = Get.find();
      return (tCont.bookTrainingReq.toJson(), null);
    } else if (serviceType.contains(ServicesKeyConst.dayCare)) {
      DayCareServiceController dCont = Get.find();
      return (dCont.bookDayCareReq.toJson(), null);
    } else {
      return ({}, null);
    }
  } catch (e) {
    log('getBookingReqByServiceType E: $e');
    return ({}, null);
  }
}

String getEmployeeRoleByServiceElement({required BookingDataModel appointment}) {
  if (appointment.service.slug.contains(ServicesKeyConst.boarding)) {
    return locale.value.boarder;
  } else if (appointment.service.slug.contains(ServicesKeyConst.veterinary)) {
    return locale.value.veterinarian;
  } else if (appointment.service.slug.contains(ServicesKeyConst.grooming)) {
    return locale.value.groomer;
  } else if (appointment.service.slug.contains(ServicesKeyConst.walking)) {
    return locale.value.walker;
  } else if (appointment.service.slug.contains(ServicesKeyConst.training)) {
    return locale.value.trainer;
  } else if (appointment.service.slug.contains(ServicesKeyConst.dayCare)) {
    return locale.value.daycareTaker;
  } else {
    return "";
  }
}

String getEmployeeRoleByUserType({required String userType}) {
  if (userType.contains(EmployeeKeyConst.boarding)) {
    return locale.value.boarder;
  } else if (userType.contains(EmployeeKeyConst.veterinary)) {
    return locale.value.veterinarian;
  } else if (userType.contains(EmployeeKeyConst.grooming)) {
    return locale.value.groomer;
  } else if (userType.contains(EmployeeKeyConst.walking)) {
    return locale.value.walker;
  } else if (userType.contains(EmployeeKeyConst.training)) {
    return locale.value.trainer;
  } else if (userType.contains(EmployeeKeyConst.dayCare)) {
    return locale.value.daycareTaker;
  } else if (userType.contains(EmployeeKeyConst.petSitter)) {
    return locale.value.petSitter;
  } else {
    return "";
  }
}

Color getBookingStatusColor({required String status}) {
  if (status.toLowerCase().contains(StatusConst.pending)) {
    return pendingStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.upcoming)) {
    return upcomingStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.completed)) {
    return completedStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.confirmed)) {
    return confirmedStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.cancel)) {
    return cancelStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.reject)) {
    return cancelStatusColor;
  } else if (status.toLowerCase().contains(StatusConst.inprogress)) {
    return inprogressStatusColor;
  } else {
    return defaultStatusColor;
  }
}

String getBookingStatus({required String status}) {
  if (status.toLowerCase().contains(StatusConst.pending)) {
    return locale.value.pending;
  } else if (status.toLowerCase().contains(StatusConst.completed)) {
    return locale.value.completed;
  } else if (status.toLowerCase().contains(StatusConst.confirmed)) {
    return locale.value.confirmed;
  } else if (status.toLowerCase().contains(StatusConst.cancel)) {
    return locale.value.cancelled;
  } else if (status.toLowerCase().contains(StatusConst.inprogress)) {
    return locale.value.inProgress;
  } else if (status.toLowerCase().contains(StatusConst.reject)) {
    return locale.value.rejected;
  } else {
    return "";
  }
}

String getBookingNotification({required String notification}) {
  if (notification.toLowerCase().contains(NotificationConst.newBooking)) {
    return locale.value.newBooking;
  } else if (notification.toLowerCase().contains(NotificationConst.completeBooking)) {
    return locale.value.completeBooking;
  } else if (notification.toLowerCase().contains(NotificationConst.rejectBooking)) {
    return locale.value.rejectBooking;
  } else if (notification.toLowerCase().contains(NotificationConst.cancelBooking)) {
    return locale.value.cancelBooking;
  } else if (notification.toLowerCase().contains(NotificationConst.acceptBooking)) {
    return locale.value.acceptBooking;
  } else if (notification.toLowerCase().contains(NotificationConst.changePassword)) {
    return locale.value.changePassword;
  } else if (notification.toLowerCase().contains(NotificationConst.forgetEmailPassword)) {
    return locale.value.forgetEmailPassword;
  } else if (notification.toLowerCase().contains(NotificationConst.orderPlaced)) {
    return locale.value.orderPlaced;
  } else if (notification.toLowerCase().contains(NotificationConst.orderPending)) {
    return locale.value.orderPending;
  } else if (notification.toLowerCase().contains(NotificationConst.orderAccepted)) {
    return "Order Accepted"; //TODO: string
  } else if (notification.toLowerCase().contains(NotificationConst.orderProcessing)) {
    return locale.value.orderProcessing;
  } else if (notification.toLowerCase().contains(NotificationConst.orderDelivered)) {
    return locale.value.orderDelivered;
  } else if (notification.toLowerCase().contains(NotificationConst.orderCancelled)) {
    return locale.value.orderCancelled;
  } else {
    return "";
  }
}

String getOrderStatus({required String status}) {
  if (status.toLowerCase().contains(OrderStatus.OrderPlaced)) {
    return "${locale.value.order} ${locale.value.placed}";
  } else if (status.toLowerCase().contains(OrderStatus.Accepted)) {
    return "Accepted"; //TODO: string
  } else if (status.toLowerCase().contains(OrderStatus.Accept)) {
    return locale.value.accept;
  } else if (status.toLowerCase().contains(OrderStatus.Processing)) {
    return locale.value.processing;
  } else if (status.toLowerCase().contains(OrderStatus.Delivered)) {
    return locale.value.delivered;
  } else if (status.toLowerCase().contains(OrderStatus.Cancelled)) {
    return locale.value.cancelled;
  } else {
    return "";
  }
}

Color getOrderStatusColor({required String status}) {
  if (status.toLowerCase().contains(OrderStatus.OrderPlaced)) {
    return upcomingStatusColor;
  } else if (status.toLowerCase().contains(OrderStatus.Accepted)) {
    return confirmedStatusColor;
  } else if (status.toLowerCase().contains(OrderStatus.Processing)) {
    return pendingStatusColor;
  } else if (status.toLowerCase().contains(OrderStatus.Delivered)) {
    return completedStatusColor;
  } else if (status.toLowerCase().contains(OrderStatus.Cancelled)) {
    return cancelStatusColor;
  } else {
    return defaultStatusColor;
  }
}

Color getPriceStatusColor({required String paymentStatus}) {
  if (paymentStatus.toLowerCase().contains(PaymentStatus.pending)) {
    return pricependingStatusColor;
  } else if (paymentStatus.toLowerCase().contains(PaymentStatus.PAID)) {
    return completedStatusColor;
  } else {
    return pricedefaultStatusColor;
  }
}

void onPaymentSuccess({required String bookingType}) async {
  reLoadBookingsOnDashboard();
  await Future.delayed(const Duration(milliseconds: 300));
  Get.offUntil(GetPageRoute(page: () => BookingSuccess()), (route) => route.isFirst || route.settings.name == '/$DashboardScreen');
}

void reLoadBookingsOnDashboard() {
  try {
    BookingsController bCont = Get.find();
    bCont.getBookingList();
  } catch (e) {
    log('E: $e');
  }
  try {
    DashboardController dashboardController = Get.find();
    dashboardController.currentIndex(1);
  } catch (e) {
    log('E: $e');
  }
}

String getBookingPaymentStatus({required String status}) {
  if (status.toLowerCase().contains(PaymentStatus.pending)) {
    return locale.value.pending;
  } else if (status.toLowerCase().contains(PaymentStatus.PAID)) {
    return locale.value.paid;
  } else if (status.toLowerCase().contains(PaymentStatus.failed)) {
    return locale.value.failed;
  } else {
    return "";
  }
}
