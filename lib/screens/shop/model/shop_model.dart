import 'package:nb_utils/nb_utils.dart';

import '../shop_dashboard/model/product_list_response.dart';

class ShopRes {
  bool status;
  List<ShopModel> data;
  String message;

  ShopRes({
    this.status = false,
    this.data = const <ShopModel>[],
    this.message = "",
  });

  factory ShopRes.fromJson(Map<String, dynamic> json) {
    return ShopRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<ShopModel>.from(json['data'].map((x) => ShopModel.fromJson(x))) : [],
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

class ShopModel {
  int id;
  String slug;
  String name;
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
  num taxIncludeMinPrice;
  num taxIncludeMaxPrice;
  num discountValue;
  String discountType;
  num minDiscountedProductAmount;
  num maxDiscountedProductAmount;
  String discountStartDate;
  String discountEndDate;
  int sellTarget;
  int stockQty;
  int isPublished;
  int minPurchaseQty;
  int maxPurchaseQty;
  int hasVariation;
  List<VariationData> variationData;
  List<ProductGallary> productGallary;
  int hasWarranty;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;
  num rating;

  ShopModel({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.productImage = "",
    this.category = const <Category>[],
    this.brandId = -1,
    this.brandName = "",
    this.unitId = -1,
    this.unitName = "",
    this.shortDescription = "",
    this.description = "",
    this.minPrice = -1,
    this.maxPrice = -1,
    this.taxIncludeMinPrice = -1,
    this.taxIncludeMaxPrice = -1,
    this.discountValue = -1,
    this.discountType = "",
    this.minDiscountedProductAmount = -1,
    this.maxDiscountedProductAmount = -1,
    this.discountStartDate = "",
    this.discountEndDate = "",
    this.sellTarget = -1,
    this.stockQty = -1,
    this.isPublished = -1,
    this.minPurchaseQty = -1,
    this.maxPurchaseQty = -1,
    this.hasVariation = -1,
    this.variationData = const <VariationData>[],
    this.productGallary = const <ProductGallary>[],
    this.hasWarranty = -1,
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
    this.rating = 0,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    log("--------------${json['name'].runtimeType}");
    return ShopModel(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
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
      taxIncludeMinPrice: json['tax_include_min_price'] is num ? json['tax_include_min_price'] : 0,
      taxIncludeMaxPrice: json['tax_include_max_price'] is num ? json['tax_include_max_price'] : 0,
      discountValue: json['discount_value'] is num ? json['discount_value'] : 0,
      discountType: json['discount_type'] is String ? json['discount_type'] : "",
      minDiscountedProductAmount: json['min_discounted_product_amount'] is num ? json['min_discounted_product_amount'] : 0,
      maxDiscountedProductAmount: json['max_discounted_product_amount'] is num ? json['max_discounted_product_amount'] : 0,
      discountStartDate: json['discount_start_date'] is String ? json['discount_start_date'] : "",
      discountEndDate: json['discount_end_date'] is String ? json['discount_end_date'] : "",
      sellTarget: json['sell_target'] is int ? json['sell_target'] : -1,
      stockQty: json['stock_qty'] is int ? json['stock_qty'] : -1,
      isPublished: json['is_published'] is int ? json['is_published'] : -1,
      minPurchaseQty: json['min_purchase_qty'] is int ? json['min_purchase_qty'] : -1,
      maxPurchaseQty: json['max_purchase_qty'] is int ? json['max_purchase_qty'] : -1,
      hasVariation: json['has_variation'] is int ? json['has_variation'] : -1,
      variationData: json['variation_data'] is List ? List<VariationData>.from(json['variation_data'].map((x) => VariationData.fromJson(x))) : [],
      productGallary: json['product_gallary'] is List ? List<ProductGallary>.from(json['product_gallary'].map((x) => ProductGallary.fromJson(x))) : [],
      hasWarranty: json['has_warranty'] is int ? json['has_warranty'] : -1,
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
      rating: json['rating'] is int ? json['rating'] : 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'name': name,
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
      'tax_include_min_price': taxIncludeMinPrice,
      'tax_include_max_price': taxIncludeMaxPrice,
      'discount_value': discountValue,
      'discount_type': discountType,
      'min_discounted_product_amount': minDiscountedProductAmount,
      'max_discounted_product_amount': maxDiscountedProductAmount,
      'discount_start_date': discountStartDate,
      'discount_end_date': discountEndDate,
      'sell_target': sellTarget,
      'stock_qty': stockQty,
      'is_published': isPublished,
      'min_purchase_qty': minPurchaseQty,
      'max_purchase_qty': maxPurchaseQty,
      'has_variation': hasVariation,
      'variation_data': variationData.map((e) => e.toJson()).toList(),
      'product_gallary': productGallary.map((e) => e.toJson()).toList(),
      'has_warranty': hasWarranty,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'rating': rating,
    };
  }
}

class Category {
  int id;
  String slug;
  String name;
  dynamic parentId;
  int brandId;
  int status;
  dynamic categoryImage;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  Category({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.parentId,
    this.brandId = -1,
    this.status = -1,
    this.categoryImage,
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      parentId: json['parent_id'],
      brandId: json['brand_id'] is int ? json['brand_id'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      categoryImage: json['category_image'],
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
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

class ProductGallary {
  int id;
  int productId;
  int status;
  String fullUrl;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  ProductGallary({
    this.id = -1,
    this.productId = -1,
    this.status = -1,
    this.fullUrl = "",
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory ProductGallary.fromJson(Map<String, dynamic> json) {
    return ProductGallary(
      id: json['id'] is int ? json['id'] : -1,
      productId: json['product_id'] is int ? json['product_id'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      fullUrl: json['full_url'] is String ? json['full_url'] : "",
      createdBy: json['created_by'] is int ? json['created_by'] : -1,
      updatedBy: json['updated_by'] is int ? json['updated_by'] : -1,
      deletedBy: json['deleted_by'],
      createdAt: json['created_at'] is String ? json['created_at'] : "",
      updatedAt: json['updated_at'] is String ? json['updated_at'] : "",
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'status': status,
      'full_url': fullUrl,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
