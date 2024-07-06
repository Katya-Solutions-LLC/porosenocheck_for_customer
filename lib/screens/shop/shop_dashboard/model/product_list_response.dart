import 'package:get/get.dart';

import '../../product/model/product_review_response.dart';

class ProductListResponse {
  bool status;
  List<ProductItemData> data;
  String message;

  ProductListResponse({
    this.status = false,
    this.data = const <ProductItemData>[],
    this.message = "",
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) {
    return ProductListResponse(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<ProductItemData>.from(json['data'].map((x) => ProductItemData.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}

class ProductItemData {
  int id;
  String slug;
  String name;
  int userId;
  int productId;
  String productName;
  String productDescription;
  String productImage;
  List<Category> category;
  int brandId;
  String brandName;
  int unitId;
  String unitName;
  String shortDescription;
  String description;
  num minPrice;
  num maxPrice;
  num discountValue;
  String discountType;
  num minDiscountedProductAmount;
  num maxDiscountedProductAmount;
  String discountStartDate;
  String discountEndDate;
  dynamic sellTarget;
  int stockQty;
  int status;
  int minPurchaseQty;
  int maxPurchaseQty;
  int hasVariation;
  num rating;
  List<VariationData> variationData;
  List<String>? productGallaryData;
  List<ProductReviewDataModel>? productReview;
  int ratingCount;
  RxBool inWishlist;
  int hasWarranty;
  dynamic createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  String soldBy;

  //local
  bool get isDiscount => discountValue != 0;

  ProductItemData({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.userId = -1,
    this.productId = -1,
    this.productName = "",
    this.productDescription = "",
    this.productImage = "",
    this.category = const <Category>[],
    this.brandId = -1,
    this.brandName = "",
    this.unitId = -1,
    this.unitName = "",
    this.shortDescription = "",
    this.description = "",
    this.minPrice = 0,
    this.maxPrice = 0,
    this.discountValue = 0,
    this.discountType = "",
    this.minDiscountedProductAmount = 0,
    this.maxDiscountedProductAmount = 0,
    this.discountStartDate = "",
    this.discountEndDate = "",
    this.sellTarget,
    this.stockQty = -1,
    this.status = -1,
    this.minPurchaseQty = -1,
    this.maxPurchaseQty = -1,
    this.hasVariation = -1,
    this.rating = 0,
    this.variationData = const <VariationData>[],
    this.ratingCount = -1,
    this.productGallaryData,
    this.productReview,
    required this.inWishlist,
    this.hasWarranty = -1,
    this.createdBy,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
    this.soldBy = "",
  });

  factory ProductItemData.fromJson(Map<String, dynamic> json) {
    return ProductItemData(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      userId: json['user_id'] is int ? json['user_id'] : -1,
      productId: json['product_id'] is int ? json['product_id'] : -1,
      productName: json['product_name'] is String ? json['product_name'] : "",
      productDescription: json['product_description'] is String ? json['product_description'] : "",
      productImage: json['product_image'] is String ? json['product_image'] : "",
      category: json['category'] is List ? List<Category>.from(json['category'].map((x) => Category.fromJson(x))) : [],
      brandId: json['brand_id'] is int ? json['brand_id'] : -1,
      brandName: json['brand_name'] is String ? json['brand_name'] : "",
      unitId: json['unit_id'] is int ? json['unit_id'] : -1,
      unitName: json['unit_name'] is String ? json['unit_name'] : "",
      shortDescription: json['short_description'] is String ? json['short_description'] : "",
      description: json['description'] is String ? json['description'] : "",
      minPrice: json['min_price'] is num ? json['min_price'] : 0,
      maxPrice: json['max_price'] is num ? json['max_price'] : 0,
      discountValue: json['discount_value'] is num ? json['discount_value'] : 0,
      discountType: json['discount_type'] is String ? json['discount_type'] : "",
      minDiscountedProductAmount: json['min_discounted_product_amount'] is num ? json['min_discounted_product_amount'] : 0,
      maxDiscountedProductAmount: json['max_discounted_product_amount'] is num ? json['max_discounted_product_amount'] : 0,
      discountStartDate: json['discount_start_date'] is String ? json['discount_start_date'] : "",
      discountEndDate: json['discount_end_date'] is String ? json['discount_end_date'] : "",
      sellTarget: json['sell_target'],
      stockQty: json['stock_qty'] is int ? json['stock_qty'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      minPurchaseQty: json['min_purchase_qty'] is int ? json['min_purchase_qty'] : -1,
      maxPurchaseQty: json['max_purchase_qty'] is int ? json['max_purchase_qty'] : -1,
      hasVariation: json['has_variation'] is int ? json['has_variation'] : -1,
      rating: json['rating'] is num ? json['rating'] : 0,
      variationData: json['variation_data'] is List ? List<VariationData>.from(json['variation_data'].map((x) => VariationData.fromJson(x))) : [],
      inWishlist: json['in_wishlist'] is int ? (json['in_wishlist'] == 1).obs : false.obs,
      ratingCount: json['rating_count'] is int ? json['rating_count'] : -1,
      hasWarranty: json['has_warranty'] is int ? json['has_warranty'] : -1,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
      productGallaryData: json['product_gallary'] != null ? List<String>.from(json['product_gallary']) : null,
      productReview: json['product_review'] != null ? (json['product_review'] as List).map((i) => ProductReviewDataModel.fromJson(i)).toList() : null,
      soldBy: json['sold_by'] is String ? json['sold_by'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'user_id': userId,
      'product_id': productId,
      'product_name': productName,
      'product_description': productDescription,
      'product_image': productImage,
      'category': category.map((e) => e.toJson()).toList(),
      'brand_id': brandId,
      'brand_name': brandName,
      'unit_id': unitId,
      'unit_name': unitName,
      'short_description': shortDescription,
      'description': description,
      'min_price': minPrice,
      'max_price': maxPrice,
      'discount_value': discountValue,
      'discount_type': discountType,
      'min_discounted_product_amount': minDiscountedProductAmount,
      'max_discounted_product_amount': maxDiscountedProductAmount,
      'discount_start_date': discountStartDate,
      'discount_end_date': discountEndDate,
      'sell_target': sellTarget,
      'stock_qty': stockQty,
      'status': status,
      'min_purchase_qty': minPurchaseQty,
      'max_purchase_qty': maxPurchaseQty,
      'has_variation': hasVariation,
      'rating': rating,
      'variation_data': variationData.map((e) => e.toJson()).toList(),
      'in_wishlist': inWishlist.value,
      'has_warranty': hasWarranty,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'rating_count': ratingCount,
      'sold_by': soldBy,
    };
  }
}

class Category {
  int id;
  dynamic slug;
  String name;
  dynamic parentId;
  dynamic brandId;
  int status;
  dynamic categoryImage;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  Category({
    this.id = -1,
    this.slug,
    this.name = "",
    this.parentId,
    this.brandId,
    this.status = -1,
    this.categoryImage,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'],
      name: json['name'] is String ? json['name'] : "",
      parentId: json['parent_id'],
      brandId: json['brand_id'],
      status: json['status'] is int ? json['status'] : -1,
      categoryImage: json['category_image'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
      'parent_id': parentId,
      'brand_id': brandId,
      'status': status,
      'category_image': categoryImage,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class VariationData {
  int id;
  int variationKey;
  String sku;
  String code;
  int locationId;
  int productStockQty;
  int isStockAvaible;
  List<Combination> combination;
  num productAmount;
  RxBool inCart;
  num taxIncludeProductPrice;
  num discountedProductPrice;

  VariationData({
    this.id = -1,
    this.variationKey = -1,
    this.sku = "",
    this.code = "",
    this.locationId = -1,
    this.productStockQty = -1,
    this.isStockAvaible = -1,
    this.combination = const <Combination>[],
    this.productAmount = 0,
    required this.inCart,
    this.taxIncludeProductPrice = 0,
    this.discountedProductPrice = 0,
  });

  factory VariationData.fromJson(Map<String, dynamic> json) {
    return VariationData(
      id: json['id'] is int ? json['id'] : -1,
      variationKey: json['variation_key'] is int ? json['variation_key'] : -1,
      sku: json['sku'] is String ? json['sku'] : "",
      code: json['code'] is String ? json['code'] : "",
      locationId: json['location_id'] is int ? json['location_id'] : -1,
      productStockQty: json['product_stock_qty'] is int ? json['product_stock_qty'] : -1,
      isStockAvaible: json['is_stock_avaible'] is int ? json['is_stock_avaible'] : -1,
      combination: json['combination'] is List ? List<Combination>.from(json['combination'].map((x) => Combination.fromJson(x))) : [],
      productAmount: json['product_amount'] is num ? json['product_amount'] : 0,
      inCart: json['in_cart'] is int ? (json['in_cart'] == 1).obs : false.obs,
      taxIncludeProductPrice: json['tax_include_product_price'] is num ? json['tax_include_product_price'] : 0,
      discountedProductPrice: json['discounted_product_price'] is num ? json['discounted_product_price'] : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'variation_key': variationKey,
      'sku': sku,
      'code': code,
      'location_id': locationId,
      'product_stock_qty': productStockQty,
      'is_stock_avaible': isStockAvaible,
      'combination': combination.map((e) => e.toJson()).toList(),
      'product_amount': productAmount,
      'in_cart': inCart.value,
      'tax_include_product_price': taxIncludeProductPrice,
      'discounted_product_price': discountedProductPrice,
    };
  }
}

class Combination {
  int id;
  String productVariationType;
  String productVariationName;
  String productVariationValue;

  Combination({
    this.id = -1,
    this.productVariationType = "",
    this.productVariationName = "",
    this.productVariationValue = "",
  });

  factory Combination.fromJson(Map<String, dynamic> json) {
    return Combination(
      id: json['id'] is int ? json['id'] : -1,
      productVariationType: json['product_variation_type'] is String ? json['product_variation_type'] : "",
      productVariationName: json['product_variation_name'] is String ? json['product_variation_name'] : "",
      productVariationValue: json['product_variation_value'] is String ? json['product_variation_value'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_variation_type': productVariationType,
      'product_variation_name': productVariationName,
      'product_variation_value': productVariationValue,
    };
  }
}
