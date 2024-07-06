import '../../../../generated/assets.dart';

class ProductModel {
  String? image;

  ProductModel({
    this.image,
  });
}

List<ProductModel> getProductDetail() {
  List<ProductModel> productDetail = [
    ProductModel(image: Assets.imagesPetCare),
    ProductModel(image: Assets.imagesPetCare),
    ProductModel(image: Assets.imagesPetCare),
  ];
  return productDetail;
}
