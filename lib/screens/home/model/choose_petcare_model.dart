

import '../../../generated/assets.dart';

class ChoosePetCareModel {
  String? image;
  String? name;
  String? title;

  ChoosePetCareModel({
    this.image,
    this.name,
    this.title,
  });
}

List<ChoosePetCareModel> getPetCareDetail() {
  List<ChoosePetCareModel> petCareDetail = [
    ChoosePetCareModel(image: Assets.imagesPetCare, name: "Smart Pet Care Veterinary", title: "Find perfect veterinary for your pets"),
    ChoosePetCareModel(image: Assets.imagesPetCare, name: "Smart Pet Care Veterinary", title: "Find perfect veterinary for your pets"),
    ChoosePetCareModel(image: Assets.imagesPetCare, name: "Smart Pet Care Veterinary", title: "Find perfect veterinary for your pets"),
  ];
  return petCareDetail;
}
