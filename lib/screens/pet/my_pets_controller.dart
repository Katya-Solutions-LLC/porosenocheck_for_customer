// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'model/pet_list_res_model.dart';
import 'services/pet_service_apis.dart';

MyPetsScreenController myPetsScreenController = MyPetsScreenController();

class MyPetsScreenController extends GetxController {
  Rx<Future<List<PetData>>> getPets = Future(() => <PetData>[]).obs;
  RxBool isLoading = false.obs;
  XFile? pickedFile;
  Rx<File> imageFile = File("").obs;
  RxList<PetData> myPets = RxList();
  Rx<PetData> selectedPetProfile = PetData().obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() {
    getPets(PetService.getPetListApi(pets: myPets));
  }
}
