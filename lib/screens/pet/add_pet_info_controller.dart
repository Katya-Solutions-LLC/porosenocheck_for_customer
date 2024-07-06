import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:porosenocheck/screens/dashboard/dashboard_res_model.dart';
import 'package:porosenocheck/utils/app_common.dart';

import '../../generated/assets.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import '../../utils/common_base.dart';
import '../../utils/constants.dart';
import '../booking_module/services/services_form_api.dart';
import 'add_pet_success_screen.dart';
import 'model/add_pet_req_model.dart';
import 'model/breed_model.dart';
import 'model/page_view_model.dart';
import 'model/pet_list_res_model.dart';
import 'model/pet_type_model.dart';
import 'my_pets_controller.dart';
import 'services/pet_service_apis.dart';

class AddPetInfoController extends GetxController {
  //Constructor region
  AddPetInfoController({this.petId, this.isProfilePhoto = false});

  bool isProfilePhoto;
  int? petId;

  //Constructor endregion
  RxBool isLoading = false.obs;
  RxBool isFromBookings = false.obs;
  RxBool hasErrorFetchingbookingList = false.obs;
  RxString errorMessage = "".obs;
  AddPetReq addPetReq = AddPetReq();
  PageController pageController = PageController();
  RxInt currentPage = 0.obs;
  Rx<Future<List<ChoosePetModel>>> choosePets = Future(() => <ChoosePetModel>[]).obs;
  RxList<ChoosePetModel> petTypeList = RxList();
  Rx<ChoosePetModel> selectedPetType = ChoosePetModel().obs;

  RxInt page = 1.obs;

  //For Edit Profile
  Rx<PetData> petProfileData = PetData().obs;
  RxBool isUpdateProfile = false.obs;
  RxBool isLastPage = false.obs;

  RxString genderOption = GenderTypeConst.MALE.obs;
  RxInt selectedDay = (-1).obs;
  RxInt selectedMonth = (-1).obs;
  RxInt selectedYear = (-1).obs;
  RxInt selectedBirthDate = (-1).obs;
  RxString petBirthDate = ''.obs;

  //
  Rx<File> imageFile = File("").obs;
  TextEditingController birthdayCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  TextEditingController breedCont = TextEditingController();
  TextEditingController ageCont = TextEditingController();
  TextEditingController weightCont = TextEditingController();
  TextEditingController heightCont = TextEditingController();

  //Breed
  Rx<BreedModel> selectedBreed = BreedModel().obs;
  RxList<BreedModel> breedList = RxList();
  RxList<BreedModel> allBreedList = RxList();

  //Error Breed
  RxBool hasErrorFetchingBreed = false.obs;
  RxString errorMessageBreed = "".obs;

  Rx<UnitModel> selectedHeightUnit = defaulHEIGHT;
  Rx<UnitModel> selectedWeightUnit = defaulWEIGHT;

  List<AddPetPageElementModel> pageViewElementList = [
    AddPetPageElementModel(midImg1: Assets.dogPawDogPaw, appBarTitle: locale.value.selectYourPet, midImg2: Assets.dogPawDogPaw1, isStep2Active: false, isStep3Active: false),
    AddPetPageElementModel(midImg1: Assets.dogPawDogPaw2, appBarTitle: locale.value.addPetInfo, midImg2: Assets.dogPawDogPaw, isStep2Active: true, isStep3Active: false),
    AddPetPageElementModel(midImg1: Assets.dogPawDogPaw2, appBarTitle: locale.value.additionalInfo, midImg2: Assets.dogPawDogPaw2, isStep2Active: true, isStep3Active: true),
  ];

  @override
  void onInit() {
    init();
    super.onInit();
  }

  @override
  void onReady() {
    if (isUpdateProfile.value) {
      handleNext();
    }
    super.onReady();
  }

  init() {
    /*try {
      final petTypesFromLocal = getValueFromLocal(APICacheConst.PET_TYPES);
      log('petTypesFromLocal: ${petTypesFromLocal.runtimeType}');
      afterBuildCreated(() {
        if (petTypesFromLocal != null) {
          choosePetDetail(PetTypeRes.fromJson(petTypesFromLocal).data);
        }
      });
    } catch (e) {
      log('petsFromLocal E: $e');
    }*/
    try {
      getPetTypesApi();
      if (Get.arguments is PetData) {
        petProfileData(Get.arguments as PetData);
        nameCont.text = petProfileData.value.name;
        weightCont.text = petProfileData.value.weight.toString();
        genderOption(petProfileData.value.gender.toLowerCase());
        selectedHeightUnit(heightUnits.firstWhere((element) => element.value.toLowerCase().contains(petProfileData.value.heightUnit.toLowerCase()), orElse: () => defaulHEIGHT.value));
        selectedWeightUnit(weightUnits.firstWhere((element) => element.value.toLowerCase().contains(petProfileData.value.weightUnit.toLowerCase()), orElse: () => defaulWEIGHT.value));
        heightCont.text = petProfileData.value.height.toString();
        ageCont.text = petProfileData.value.age;
        breedCont.text = petProfileData.value.breed;
        birthdayCont.text = petProfileData.value.dateOfBirth.dateInyyyyMMddFormat.formatDateYYYYmmdd();

        isUpdateProfile(true);
      }
      if (Get.arguments is bool) {
        isFromBookings(Get.arguments as bool);
      }
    } catch (e) {
      log('AddPetInfoController init E: $e');
    }
  }

  void handleNext() {
    hideKeyBoardWithoutContext();
    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  void handlePrevious() {
    hideKeyBoardWithoutContext();
    pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  /*onBirthDateChanges() {
    try {
      DateTime bDay = DateTime(selectedYear.value, selectedMonth.value, selectedDay.value);
      log('BDAY: $bDay');
      petBirthDate(bDay.formatDateYYYYmmdd());
      log('PET BIRTHDATE: $petBirthDate');
    } catch (e) {
      log('onDateTimeChanges E: $e');
    }
  }*/

  void _getFromGallery() async {
    XFile? pickedFile;
    pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      imageFile(File(pickedFile.path));
      addPetReq.petImages = [pickedFile];
      log('ADDPETREQ.PETIMAGES: ${addPetReq.petImages.validate().length}');

      if (isProfilePhoto) {
        showConfimDialogChoosePhoto();
      }
    }
  }

  _getFromCamera() async {
    XFile? pickedFile;
    pickedFile = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
    if (pickedFile != null) {
      imageFile(File(pickedFile.path));
      addPetReq.petImages.validate().add(pickedFile);
      if (isProfilePhoto) {
        showConfimDialogChoosePhoto();
      }
    }
  }

  void showConfimDialogChoosePhoto() {
    showConfirmDialogCustom(
      getContext,
      primaryColor: primaryColor,
      negativeText: locale.value.cancel,
      positiveText: locale.value.accept,
      onAccept: (_) {
        addPetApi();
      },
      dialogType: DialogType.ACCEPT,
      customCenterWidget: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(
            imageFile.value,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              alignment: Alignment.center,
              width: 100,
              height: 100,
              decoration: boxDecorationDefault(shape: BoxShape.circle, color: primaryColor.withOpacity(0.4)),
              child: Text(
                "${myPetsScreenController.selectedPetProfile.value.name.firstLetter.toUpperCase()}${myPetsScreenController.selectedPetProfile.value.name.firstLetter.toUpperCase()}",
                style: const TextStyle(fontSize: 100 * 0.3, color: Colors.white),
              ),
            ),
          ).cornerRadiusWithClipRRect(45),
        ],
      ).paddingSymmetric(vertical: 16),
      title: "${locale.value.wouldYouLikeToSetPictureAs} ${myPetsScreenController.selectedPetProfile.value.name}${locale.value.sProfilePicture}",
    );
  }

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: context.cardColor,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SettingItemWidget(
              title: locale.value.gallery,
              leading: const Icon(Icons.image, color: primaryColor),
              onTap: () async {
                _getFromGallery();
                finish(context);
              },
            ),
            SettingItemWidget(
              title: locale.value.camera,
              leading: const Icon(Icons.camera, color: primaryColor),
              onTap: () {
                _getFromCamera();
                finish(context);
              },
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
          ],
        ).paddingAll(16.0);
      },
    );
  }

  addPetApi() async {
    isLoading(true);
    hideKeyBoardWithoutContext();
    addPetReq.breedId = isUpdateProfile.value ? petProfileData.value.breedId : selectedBreed.value.id;
    addPetReq.pettypeId = selectedPetType.value.id.toString();
    addPetReq.gender = genderOption.value.toLowerCase();
    addPetReq.weight = weightCont.text.trim();
    addPetReq.height = heightCont.text.trim();
    addPetReq.weightUnit = selectedWeightUnit.value.value;
    addPetReq.heightUnit = selectedHeightUnit.value.value;
    addPetReq.heightUnit = selectedHeightUnit.value.value;
    addPetReq.birthdate = birthdayCont.text.trim();
    log('ADDPETREQ.TOJSON(): ${addPetReq.toJson()}');
    PetService.addPetDetailsApi(
      petId: isProfilePhoto
          ? petId
          : isUpdateProfile.value
              ? petProfileData.value.id
              : null,
      request: addPetReq.toJson(),
      isUpdateProfilePic: isProfilePhoto,
      files: addPetReq.petImages,
      onPetAdd: () {
        isLoading(false);
        if (isFromBookings.value || isUpdateProfile.value || isProfilePhoto) {
          myPetsScreenController.init();
          toast("${locale.value.petProfileUpdate} ${locale.value.successfully}");
          Get.back();
          if (isUpdateProfile.value) {
            Get.back();
          }
        } else {
          myPetsScreenController.init();
          Get.offUntil(GetPageRoute(page: () => AddPetSuccessScreen()), (route) => route.isFirst || route.settings.name == '/MyPetsScreen');
        }
      },
      loaderOff: () {
        isLoading(false);
      },
    ).then((value) async {}).catchError((e) {
      isLoading(false);
      toast(e.toString(), print: true);
    }); //
  }

  getPetTypesApi() async {
    isLoading(true);
    hideKeyBoardWithoutContext();
    PetService.getPetTypeApi(
      petTypeList: petTypeList,
      page: page.value,
      lastPageCallBack: (p0) {
        isLastPage(p0);
      },
    ).then((value) async {
      hasErrorFetchingbookingList(false);
      if (isUpdateProfile.value) {
        selectedPetType(petTypeList.firstWhere((p0) => p0.name.toLowerCase().contains(petProfileData.value.pettype.toLowerCase()), orElse: () => ChoosePetModel()));
      }
      isLoading(false);
    }).catchError((e) {
      isLoading(false);
      hasErrorFetchingbookingList(true);
      errorMessage(e.toString());
    }); //
  }

  ///Get Breed List
  getBreed({String searchtext = ""}) {
    if (selectedPetType.value.id.isNegative) return;
    isLoading(true);
    PetServiceFormApis.getBreed(petTypeId: selectedPetType.value.id, search: searchtext).then((value) {
      isLoading(false);
      allBreedList(value.data);
      if (isUpdateProfile.value) {
        selectedBreed(allBreedList.firstWhere((element) => petProfileData.value.breedId.toInt() == element.id, orElse: () => BreedModel()));
        breedList(allBreedList.where((p0) => petProfileData.value.pettype.toLowerCase() == p0.pettype.toLowerCase()).toList());
        breedCont.text = selectedBreed.value.name;
      } else {
        breedList(allBreedList.where((p0) => selectedPetType.value.name.toLowerCase() == p0.pettype.toLowerCase()).toList());
      }

      hasErrorFetchingBreed(false);
    }).onError((error, stackTrace) {
      hasErrorFetchingBreed(true);
      errorMessageBreed(error.toString());
      isLoading(false);
      // toast(error.toString());
    });
  }
}
