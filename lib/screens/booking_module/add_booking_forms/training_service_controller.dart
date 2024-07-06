import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/booking_module/model/choose_pet_widget.dart';
import 'package:porosenocheck/screens/pet/my_pets_controller.dart';

import '../../../utils/app_common.dart';
import '../../../utils/common_base.dart';
import '../../../utils/constants.dart';
import '../../dashboard/dashboard_controller.dart';
import '../../dashboard/dashboard_res_model.dart';
import '../../pet/model/pet_list_res_model.dart';
import '../booking_detail/booking_detail_controller.dart';
import '../model/booking_data_model.dart';
import '../model/employe_model.dart';
import '../model/training_model.dart';
import '../model/walking_model.dart';
import '../payment_controller.dart';
import '../payment_screen.dart';
import '../services/booking_service_apis.dart';
import '../services/services_form_api.dart';
import 'model/book_trainning_req.dart';

class TrainingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool showBookBtn = false.obs;
  RxBool isRefresh = false.obs;
  BookTrainingReq bookTrainingReq = BookTrainingReq();
  Rx<TrainingModel> selectedTraining = TrainingModel().obs;

  //Service
  RxList<TrainingModel> trainingList = RxList();
  RxList<TrainingModel> trainingFilterList = RxList();

  //Error Service
  RxBool hasErrorFetchingTraining = false.obs;
  RxString errorMessageTraining = "".obs;

  //Trainer
  Rx<EmployeeModel> selectedTrainer = EmployeeModel(profileImage: "".obs).obs;
  RxList<EmployeeModel> trainerList = RxList();
  RxList<EmployeeModel> trainerFilterList = RxList();

  //Error Trainer
  RxBool hasErrorFetchingTrainer = false.obs;
  RxString errorMessageTrainer = "".obs;
  RxBool isUpdateForm = false.obs;
  TextEditingController dateCont = TextEditingController();
  TextEditingController timeCont = TextEditingController();
  TextEditingController trainingCont = TextEditingController();
  TextEditingController trainerCont = TextEditingController();
  TextEditingController additionalInfoCont = TextEditingController();
  Rx<DurationData> selectedDuration = DurationData().obs;
  Rx<Future<List<DurationData>>> duration = Future(() => <DurationData>[]).obs;
  RxList<DurationData> durationList = RxList();
  Rx<BookingDataModel> bookingFormData = BookingDataModel(service: SystemService(), payment: PaymentDetails(), training: Training()).obs;

  //Search
  TextEditingController searchCont = TextEditingController();

  @override
  void onInit() {
    bookTrainingReq.systemServiceId = currentSelectedService.value.id;
    if (myPetsScreenController.myPets.length == 1) {
      /// Pet Selection When there is only single pet
      bookTrainingReq.petId = myPetsScreenController.myPets.first.id;
    }
    if (Get.arguments is BookingDataModel) {
      try {
        isUpdateForm(true);
        bookingFormData(Get.arguments as BookingDataModel);
        additionalInfoCont.text = bookingFormData.value.note;
        duration(PetServiceFormApis.getDuration(serviceType: ServicesKeyConst.training)).then((value) {
          selectedDuration(value.firstWhere((p0) => p0.duration == bookingFormData.value.duration, orElse: () => DurationData()));
          if (selectedDuration.value.id > 0 && selectedDuration.value.price > 0) {
            currentSelectedService.value.serviceAmount = selectedDuration.value.price.toDouble();
            bookTrainingReq.price = selectedDuration.value.price.toDouble();
            showBookBtn(true);
          }
        });
        getTraining();
        getTrainer();
        selectedPet(myPetsScreenController.myPets.firstWhere((element) => element.name.toLowerCase() == bookingFormData.value.petName.toLowerCase(), orElse: () => PetData()));
        bookTrainingReq.petId = selectedPet.value.id;
      } catch (e) {
        log('training book again E: $e');
      }
    } else {
      getTraining();
      getTrainer();
      duration(PetServiceFormApis.getDuration(serviceType: ServicesKeyConst.training));
    }

    try {
      log('BookingDetailsController called init');
      BookingDetailsController bDetailCont = Get.find();
      currentSelectedService(bDetailCont.bookingDetail.value.service);
      dateCont.text = bDetailCont.bookingDetail.value.serviceDateTime.dateInyyyyMMddHHmmFormat.formatDateDDMMYY();
      timeCont.text = bDetailCont.bookingDetail.value.serviceDateTime.dateInyyyyMMddHHmmFormat.formatTimeHHmmAMPM();
      bookTrainingReq.date = bDetailCont.bookingDetail.value.serviceDateTime.dateInyyyyMMddFormat.formatDateYYYYmmdd();
      bookTrainingReq.time = bDetailCont.bookingDetail.value.serviceDateTime.dateInyyyyMMddHHmmFormat.formatTimeHHmm24hour().toString();
    } catch (e) {
      log('training Reschedule init E: $e');
    }

    super.onInit();
  }

  void clearTrainerSelection() {
    trainerCont.clear();
    selectedTrainer(EmployeeModel(profileImage: "".obs));
  }

  ///Get Training List
  getTraining({String searchtext = ""}) {
    isLoading(true);
    PetServiceFormApis.getTraining(search: searchtext).then((value) {
      isLoading(false);
      trainingList(value.data);
      hasErrorFetchingTraining(false);
      if (isUpdateForm.value) {
        selectedTraining(trainingList.firstWhere((p0) => p0.name == bookingFormData.value.training.name, orElse: () => TrainingModel()));
        trainingCont.text = selectedTraining.value.name;
      }
    }).onError((error, stackTrace) {
      hasErrorFetchingTraining(true);
      errorMessageTraining(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }

  ///Get Trainner List
  getTrainer({String searchtext = ""}) {
    isLoading(true);
    PetServiceFormApis.getEmployee(role: EmployeeKeyConst.training, search: searchtext).then((value) {
      isLoading(false);
      trainerList(value.data);

      hasErrorFetchingTrainer(false);

      if (isUpdateForm.value) {
        selectedTrainer(trainerList.firstWhere((p0) => p0.id == bookingFormData.value.employeeId, orElse: () => EmployeeModel(profileImage: "".obs)));
        trainerCont.text = selectedTrainer.value.fullName;
      }
    }).onError((error, stackTrace) {
      hasErrorFetchingTrainer(true);
      errorMessageTrainer(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }

  void searchTrainingFunc({
    required String searchtext,
    required RxList<TrainingModel> trainingFilterList,
    required RxList<TrainingModel> trainingSList,
  }) {
    trainingFilterList.value = List.from(trainingSList.where((element) => element.name.toString().toLowerCase().contains(searchtext.toString().toLowerCase())));
    for (var i = 0; i < trainingFilterList.length; i++) {
      log('SEARCHEDNAMES : ${trainingFilterList[i].toJson()}');
    }
    log('SEARCHEDNAMES.LENGTH: ${trainingFilterList.length}');
  }

  void onSearchChange(searchtext) {
    searchTrainingFunc(
      searchtext: searchtext,
      trainingFilterList: trainingFilterList,
      trainingSList: trainingList,
    );
  }

  void searchTrainerFunc({
    required String searchtext,
    required RxList<EmployeeModel> trainerFilterList,
    required RxList<EmployeeModel> trainerSList,
  }) {
    trainerFilterList.value = List.from(trainerSList.where((element) => element.fullName.toString().toLowerCase().contains(searchtext.toString().toLowerCase())));
    for (var i = 0; i < trainerFilterList.length; i++) {
      log('SEARCHEDNAMES : ${trainerFilterList[i].toJson()}');
    }
    log('SEARCHEDNAMES.LENGTH: ${trainerFilterList.length}');
  }

  void onTrainerSearchChange(searchtext) {
    searchTrainerFunc(
      searchtext: searchtext,
      trainerFilterList: trainerFilterList,
      trainerSList: trainerList,
    );
  }

  bool get isShowTrainerFullList => trainerFilterList.isEmpty && searchCont.text.trim().isEmpty;

  bool get isShowFullList => trainingFilterList.isEmpty && searchCont.text.trim().isEmpty;

  handleBookNowClick({bool isFromReschedule = false}) {
    bookTrainingReq.additionalInfo = additionalInfoCont.text.trim();
    bookTrainingReq.totalAmount = totalAmount;
    bookTrainingReq.employeeId = selectedTrainer.value.id;
    bookTrainingReq.trainingId = selectedTraining.value.id;
    bookingSuccessDate("${bookTrainingReq.date} ${bookTrainingReq.time}".trim());
    log('BOOKBOARDINGREQ.TOJSON(): ${bookTrainingReq.toJson()}');

    if (isFromReschedule) {
      try {
        BookingDetailsController bDetailCont = Get.find();
        Map<String, dynamic> req = {
          'id': bDetailCont.bookingDetail.value.id,
          'date_time': "${bookTrainingReq.date.trim()} ${bookTrainingReq.time.trim()}",
        };
        isLoading(true);
        BookingServiceApis.updateBooking(request: req).then((value) {
          bDetailCont.init(showLoader: false);
          Get.back();
        }).catchError((e) {
          toast(e.toString(), print: true);
        }).whenComplete(() => isLoading(false));
      } catch (e) {
        log('Training Reschedule booking save E: $e');
      }
    } else {
      paymentController = PaymentController(bookingService: currentSelectedService.value);
      Get.to(() => const PaymentScreen(), binding: BindingsBuilder(() {
        getAppConfigurations();
      }));
    }
  }
}
