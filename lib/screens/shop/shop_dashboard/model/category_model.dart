import 'package:porosenocheck/screens/shop/shop_dashboard/model/product_list_response.dart';

import 'category_response.dart';

class DashboardShopRes {
  bool status;
  DashboardShopModel shopDashData;
  String message;

  DashboardShopRes({
    this.status = false,
    required this.shopDashData,
    this.message = "",
  });

  factory DashboardShopRes.fromJson(Map<String, dynamic> json) {
    return DashboardShopRes(
      status: json['status'] is bool ? json['status'] : false,
      shopDashData: json['data'] is Map ? DashboardShopModel.fromJson(json['data']) : DashboardShopModel(),
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': shopDashData.toJson(),
      'message': message,
    };
  }
}

class DashboardShopModel {
  List<CategoryData> category;
  List<ProductItemData> featuredProduct;
  List<ProductItemData> bestsellerProduct;
  List<ProductItemData> discountProduct;

  DashboardShopModel({
    this.category = const <CategoryData>[],
    this.featuredProduct = const <ProductItemData>[],
    this.bestsellerProduct = const <ProductItemData>[],
    this.discountProduct = const <ProductItemData>[],
  });

  factory DashboardShopModel.fromJson(Map<String, dynamic> json) {
    return DashboardShopModel(
      category: json['category'] is List ? List<CategoryData>.from(json['category'].map((x) => CategoryData.fromJson(x))) : [],
      featuredProduct: json['featured_product'] is List ? List<ProductItemData>.from(json['featured_product'].map((x) => ProductItemData.fromJson(x))) : [],
      bestsellerProduct: json['bestseller_product'] is List ? List<ProductItemData>.from(json['bestseller_product'].map((x) => ProductItemData.fromJson(x))) : [],
      discountProduct: json['discount_product'] is List ? List<ProductItemData>.from(json['discount_product'].map((x) => ProductItemData.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category.map((e) => e.toJson()).toList(),
      'featured_product': featuredProduct.map((e) => e.toJson()).toList(),
      'bestseller_product': bestsellerProduct.map((e) => e.toJson()).toList(),
      'discount_product': discountProduct.map((e) => e.toJson()).toList(),
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

class FeaturedProduct {
  int id;
  String slug;
  String name;
  dynamic productImage;
  List<Category> category;
  int brandId;
  String brandName;
  int unitId;
  String unitName;
  String shortDescription;
  String description;
  int minPrice;
  int maxPrice;
  int discountValue;
  String discountType;
  int minDiscountedProductAmount;
  int maxDiscountedProductAmount;
  String discountStartDate;
  String discountEndDate;
  dynamic sellTarget;
  int stockQty;
  int status;
  int minPurchaseQty;
  int maxPurchaseQty;
  int hasVariation;
  int rating;
  List<VariationData> variationData;
  int inWishlist;
  int hasWarranty;
  dynamic createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  FeaturedProduct({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.productImage,
    this.category = const <Category>[],
    this.brandId = -1,
    this.brandName = "",
    this.unitId = -1,
    this.unitName = "",
    this.shortDescription = "",
    this.description = "",
    this.minPrice = -1,
    this.maxPrice = -1,
    this.discountValue = -1,
    this.discountType = "",
    this.minDiscountedProductAmount = -1,
    this.maxDiscountedProductAmount = -1,
    this.discountStartDate = "",
    this.discountEndDate = "",
    this.sellTarget,
    this.stockQty = -1,
    this.status = -1,
    this.minPurchaseQty = -1,
    this.maxPurchaseQty = -1,
    this.hasVariation = -1,
    this.rating = -1,
    this.variationData = const <VariationData>[],
    this.inWishlist = -1,
    this.hasWarranty = -1,
    this.createdBy,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory FeaturedProduct.fromJson(Map<String, dynamic> json) {
    return FeaturedProduct(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      productImage: json['product_image'],
      category: json['category'] is List ? List<Category>.from(json['category'].map((x) => Category.fromJson(x))) : [],
      brandId: json['brand_id'] is int ? json['brand_id'] : -1,
      brandName: json['brand_name'] is String ? json['brand_name'] : "",
      unitId: json['unit_id'] is int ? json['unit_id'] : -1,
      unitName: json['unit_name'] is String ? json['unit_name'] : "",
      shortDescription: json['short_description'] is String ? json['short_description'] : "",
      description: json['description'] is String ? json['description'] : "",
      minPrice: json['min_price'] is int ? json['min_price'] : -1,
      maxPrice: json['max_price'] is int ? json['max_price'] : -1,
      discountValue: json['discount_value'] is int ? json['discount_value'] : -1,
      discountType: json['discount_type'] is String ? json['discount_type'] : "",
      minDiscountedProductAmount: json['min_discounted_product_amount'] is int ? json['min_discounted_product_amount'] : -1,
      maxDiscountedProductAmount: json['max_discounted_product_amount'] is int ? json['max_discounted_product_amount'] : -1,
      discountStartDate: json['discount_start_date'] is String ? json['discount_start_date'] : "",
      discountEndDate: json['discount_end_date'] is String ? json['discount_end_date'] : "",
      sellTarget: json['sell_target'],
      stockQty: json['stock_qty'] is int ? json['stock_qty'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      minPurchaseQty: json['min_purchase_qty'] is int ? json['min_purchase_qty'] : -1,
      maxPurchaseQty: json['max_purchase_qty'] is int ? json['max_purchase_qty'] : -1,
      hasVariation: json['has_variation'] is int ? json['has_variation'] : -1,
      rating: json['rating'] is int ? json['rating'] : -1,
      variationData: json['variation_data'] is List ? List<VariationData>.from(json['variation_data'].map((x) => VariationData.fromJson(x))) : [],
      inWishlist: json['in_wishlist'] is int ? json['in_wishlist'] : -1,
      hasWarranty: json['has_warranty'] is int ? json['has_warranty'] : -1,
      createdBy: json['created_by'],
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
      'in_wishlist': inWishlist,
      'has_warranty': hasWarranty,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class BestsellerProduct {
  int id;
  String slug;
  String name;
  dynamic productImage;
  List<Category> category;
  int brandId;
  String brandName;
  int unitId;
  String unitName;
  String shortDescription;
  String description;
  int minPrice;
  int maxPrice;
  int discountValue;
  String discountType;
  int minDiscountedProductAmount;
  int maxDiscountedProductAmount;
  String discountStartDate;
  String discountEndDate;
  dynamic sellTarget;
  int stockQty;
  int status;
  int minPurchaseQty;
  int maxPurchaseQty;
  int hasVariation;
  int rating;
  List<VariationData> variationData;
  int inWishlist;
  int hasWarranty;
  int createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  BestsellerProduct({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.productImage,
    this.category = const <Category>[],
    this.brandId = -1,
    this.brandName = "",
    this.unitId = -1,
    this.unitName = "",
    this.shortDescription = "",
    this.description = "",
    this.minPrice = -1,
    this.maxPrice = -1,
    this.discountValue = -1,
    this.discountType = "",
    this.minDiscountedProductAmount = -1,
    this.maxDiscountedProductAmount = -1,
    this.discountStartDate = "",
    this.discountEndDate = "",
    this.sellTarget,
    this.stockQty = -1,
    this.status = -1,
    this.minPurchaseQty = -1,
    this.maxPurchaseQty = -1,
    this.hasVariation = -1,
    this.rating = -1,
    this.variationData = const <VariationData>[],
    this.inWishlist = -1,
    this.hasWarranty = -1,
    this.createdBy = -1,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory BestsellerProduct.fromJson(Map<String, dynamic> json) {
    return BestsellerProduct(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      productImage: json['product_image'],
      category: json['category'] is List ? List<Category>.from(json['category'].map((x) => Category.fromJson(x))) : [],
      brandId: json['brand_id'] is int ? json['brand_id'] : -1,
      brandName: json['brand_name'] is String ? json['brand_name'] : "",
      unitId: json['unit_id'] is int ? json['unit_id'] : -1,
      unitName: json['unit_name'] is String ? json['unit_name'] : "",
      shortDescription: json['short_description'] is String ? json['short_description'] : "",
      description: json['description'] is String ? json['description'] : "",
      minPrice: json['min_price'] is int ? json['min_price'] : -1,
      maxPrice: json['max_price'] is int ? json['max_price'] : -1,
      discountValue: json['discount_value'] is int ? json['discount_value'] : -1,
      discountType: json['discount_type'] is String ? json['discount_type'] : "",
      minDiscountedProductAmount: json['min_discounted_product_amount'] is int ? json['min_discounted_product_amount'] : -1,
      maxDiscountedProductAmount: json['max_discounted_product_amount'] is int ? json['max_discounted_product_amount'] : -1,
      discountStartDate: json['discount_start_date'] is String ? json['discount_start_date'] : "",
      discountEndDate: json['discount_end_date'] is String ? json['discount_end_date'] : "",
      sellTarget: json['sell_target'],
      stockQty: json['stock_qty'] is int ? json['stock_qty'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      minPurchaseQty: json['min_purchase_qty'] is int ? json['min_purchase_qty'] : -1,
      maxPurchaseQty: json['max_purchase_qty'] is int ? json['max_purchase_qty'] : -1,
      hasVariation: json['has_variation'] is int ? json['has_variation'] : -1,
      rating: json['rating'] is int ? json['rating'] : -1,
      variationData: json['variation_data'] is List ? List<VariationData>.from(json['variation_data'].map((x) => VariationData.fromJson(x))) : [],
      inWishlist: json['in_wishlist'] is int ? json['in_wishlist'] : -1,
      hasWarranty: json['has_warranty'] is int ? json['has_warranty'] : -1,
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
      'in_wishlist': inWishlist,
      'has_warranty': hasWarranty,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

class DiscountProduct {
  int id;
  String slug;
  String name;
  dynamic productImage;
  List<Category> category;
  int brandId;
  String brandName;
  int unitId;
  String unitName;
  String shortDescription;
  String description;
  int minPrice;
  int maxPrice;
  int discountValue;
  String discountType;
  int minDiscountedProductAmount;
  int maxDiscountedProductAmount;
  String discountStartDate;
  String discountEndDate;
  dynamic sellTarget;
  int stockQty;
  int status;
  int minPurchaseQty;
  int maxPurchaseQty;
  int hasVariation;
  int rating;
  List<VariationData> variationData;
  int inWishlist;
  int hasWarranty;
  dynamic createdBy;
  int updatedBy;
  dynamic deletedBy;
  String createdAt;
  String updatedAt;
  dynamic deletedAt;

  DiscountProduct({
    this.id = -1,
    this.slug = "",
    this.name = "",
    this.productImage,
    this.category = const <Category>[],
    this.brandId = -1,
    this.brandName = "",
    this.unitId = -1,
    this.unitName = "",
    this.shortDescription = "",
    this.description = "",
    this.minPrice = -1,
    this.maxPrice = -1,
    this.discountValue = -1,
    this.discountType = "",
    this.minDiscountedProductAmount = -1,
    this.maxDiscountedProductAmount = -1,
    this.discountStartDate = "",
    this.discountEndDate = "",
    this.sellTarget,
    this.stockQty = -1,
    this.status = -1,
    this.minPurchaseQty = -1,
    this.maxPurchaseQty = -1,
    this.hasVariation = -1,
    this.rating = -1,
    this.variationData = const <VariationData>[],
    this.inWishlist = -1,
    this.hasWarranty = -1,
    this.createdBy,
    this.updatedBy = -1,
    this.deletedBy,
    this.createdAt = "",
    this.updatedAt = "",
    this.deletedAt,
  });

  factory DiscountProduct.fromJson(Map<String, dynamic> json) {
    return DiscountProduct(
      id: json['id'] is int ? json['id'] : -1,
      slug: json['slug'] is String ? json['slug'] : "",
      name: json['name'] is String ? json['name'] : "",
      productImage: json['product_image'],
      category: json['category'] is List ? List<Category>.from(json['category'].map((x) => Category.fromJson(x))) : [],
      brandId: json['brand_id'] is int ? json['brand_id'] : -1,
      brandName: json['brand_name'] is String ? json['brand_name'] : "",
      unitId: json['unit_id'] is int ? json['unit_id'] : -1,
      unitName: json['unit_name'] is String ? json['unit_name'] : "",
      shortDescription: json['short_description'] is String ? json['short_description'] : "",
      description: json['description'] is String ? json['description'] : "",
      minPrice: json['min_price'] is int ? json['min_price'] : -1,
      maxPrice: json['max_price'] is int ? json['max_price'] : -1,
      discountValue: json['discount_value'] is int ? json['discount_value'] : -1,
      discountType: json['discount_type'] is String ? json['discount_type'] : "",
      minDiscountedProductAmount: json['min_discounted_product_amount'] is int ? json['min_discounted_product_amount'] : -1,
      maxDiscountedProductAmount: json['max_discounted_product_amount'] is int ? json['max_discounted_product_amount'] : -1,
      discountStartDate: json['discount_start_date'] is String ? json['discount_start_date'] : "",
      discountEndDate: json['discount_end_date'] is String ? json['discount_end_date'] : "",
      sellTarget: json['sell_target'],
      stockQty: json['stock_qty'] is int ? json['stock_qty'] : -1,
      status: json['status'] is int ? json['status'] : -1,
      minPurchaseQty: json['min_purchase_qty'] is int ? json['min_purchase_qty'] : -1,
      maxPurchaseQty: json['max_purchase_qty'] is int ? json['max_purchase_qty'] : -1,
      hasVariation: json['has_variation'] is int ? json['has_variation'] : -1,
      rating: json['rating'] is int ? json['rating'] : -1,
      variationData: json['variation_data'] is List ? List<VariationData>.from(json['variation_data'].map((x) => VariationData.fromJson(x))) : [],
      inWishlist: json['in_wishlist'] is int ? json['in_wishlist'] : -1,
      hasWarranty: json['has_warranty'] is int ? json['has_warranty'] : -1,
      createdBy: json['created_by'],
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
      'in_wishlist': inWishlist,
      'has_warranty': hasWarranty,
      'created_by': createdBy,
      'updated_by': updatedBy,
      'deleted_by': deletedBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
