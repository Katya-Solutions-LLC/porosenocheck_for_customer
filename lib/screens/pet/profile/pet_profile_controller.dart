// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/auth/model/login_response.dart';
import 'package:porosenocheck/screens/pet/my_pets_controller.dart';

import '../model/pet_note_model.dart';
import '../services/pet_service_apis.dart';
import '../../../utils/common_base.dart';
import '../../home/home_controller.dart';

class PetProfileController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController titleCont = TextEditingController();
  TextEditingController noteCont = TextEditingController();
  Rx<NotePetModel> selectedNote = NotePetModel(createdbyUser: UserData(), isPrivate: false.obs).obs;
  Rx<Future<List<NotePetModel>>> notes = Future(() => <NotePetModel>[]).obs;
  RxList<NotePetModel> getNotes = RxList();
  RxBool isLastPage = false.obs;
  RxInt page = 1.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    getNoteApi();
    final HomeScreenController homeScreenController = Get.find();
    homeScreenController.getDashboardDetail();
  }

  //get note apis
  getNoteApi({bool showLoader = false}) async {
    if (showLoader) {
      isLoading(true);
    }
    await notes(
      PetService.getNoteApi(
        petId: myPetsScreenController.selectedPetProfile.value.id,
        page: page.value,
        notes: getNotes,
        lastPageCallBack: (p0) {
          isLastPage(p0);
        },
      ).whenComplete(() => isLoading(false)),
    );
  }

  addEditNote() async {
    isLoading(true);
    hideKeyBoardWithoutContext();

    Map<String, dynamic> req = {
      "id": !selectedNote.value.id.isNegative ? selectedNote.value.id : "",
      "pet_id": myPetsScreenController.selectedPetProfile.value.id,
      "title": titleCont.text.trim(),
      "description": noteCont.text.trim(),
      "is_private": selectedNote.value.isPrivate.value.getIntBool()
    };

    PetService.addNoteApi(request: req).then((value) async {
      getNoteApi(showLoader: true);
      titleCont.clear();
      noteCont.clear();
      Get.back();
    }).catchError((e) {
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }

  deleteNote({bool isFromEditNote = false}) async {
    isLoading(true);
    await PetService.deleteNote(id: selectedNote.value.id).then((value) async {
      getNoteApi(showLoader: true);
      titleCont.clear();
      noteCont.clear();
      if (isFromEditNote) Get.back();
    }).catchError((e) {
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }

  deletePet() async {
    isLoading(true);
    await PetService.deletePet(id: myPetsScreenController.selectedPetProfile.value.id).then((value) async {
      myPetsScreenController.init();
      Get.back();
    }).catchError((e) {
      toast(e.toString(), print: true);
    }).whenComplete(() => isLoading(false));
  }
}
