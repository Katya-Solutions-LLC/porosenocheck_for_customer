class ProductReviewsResponse {
  List<ProductReviewDataModel>? data;
  String? message;
  bool? status;

  ProductReviewsResponse({this.data, this.message, this.status});

  factory ProductReviewsResponse.fromJson(Map<String, dynamic> json) {
    return ProductReviewsResponse(
      data: json['data'] != null ? (json['data'] as List).map((i) => ProductReviewDataModel.fromJson(i)).toList() : null,
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductReviewDataModel {
  int? id;
  int? productId;
  int? rating;
  int? reviewDislikes;
  int? isUserLike;
  int? isUserDislike;
  List<ReviewGallaryData>? reviewGallary;
  int? reviewLikes;
  String? reviewMsg;
  int? userId;
  String? userName;
  String? createdAt;
  String? deletedAt;
  String? updatedAt;

  ///order detail
  String? featureImage;
  List<ReviewGallaryData>? gallery;
  int? productVariationId;

  ProductReviewDataModel({
    this.id,
    this.productId,
    this.rating,
    this.reviewDislikes,
    this.isUserLike,
    this.isUserDislike,
    this.reviewGallary,
    this.reviewLikes,
    this.reviewMsg,
    this.userId,
    this.userName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.featureImage,
    this.gallery,
    this.productVariationId,
  });

  factory ProductReviewDataModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewDataModel(
      id: json['id'],
      productId: json['product_id'],
      rating: json['rating'],
      reviewDislikes: json['review_dislikes'],
      isUserLike: json['is_user_like'],
      isUserDislike: json['is_user_dislike'],
      reviewGallary: json['review_gallary'] != null ? (json['review_gallary'] as List).map((i) => ReviewGallaryData.fromJson(i)).toList() : null,
      reviewLikes: json['review_likes'],
      reviewMsg: json['review_msg'],
      userId: json['user_id'],
      userName: json['user_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      featureImage: json['feature_image'],
      gallery: json['gallery'] != null ? (json['gallery'] as List).map((i) => ReviewGallaryData.fromJson(i)).toList() : null,
      productVariationId: json['product_variation_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['rating'] = rating;
    data['review_dislikes'] = reviewDislikes;
    data['is_user_like'] = isUserLike;
    data['is_user_dislike'] = isUserDislike;
    data['review_likes'] = reviewLikes;
    data['review_msg'] = reviewMsg;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (reviewGallary != null) {
      data['review_gallary'] = reviewGallary!.map((v) => v.toJson()).toList();
    }
    if (deletedAt != null) {
      data['deleted_at'] = deletedAt;
    }
    return data;
  }
}

class ReviewGallaryData {
  String? createdAt;
  int? createdBy;
  String? deletedAt;
  int? deletedBy;
  String? fullUrl;
  int? id;
  int? reviewId;
  int? status;
  String? updatedAt;
  int? updatedBy;

  ReviewGallaryData({this.createdAt, this.createdBy, this.deletedAt, this.deletedBy, this.fullUrl, this.id, this.reviewId, this.status, this.updatedAt, this.updatedBy});

  factory ReviewGallaryData.fromJson(Map<String, dynamic> json) {
    return ReviewGallaryData(
      createdAt: json['created_at'],
      createdBy: json['created_by'],
      deletedAt: json['deleted_at'],
      deletedBy: json['deleted_by'],
      fullUrl: json['full_url'],
      id: json['id'],
      reviewId: json['review_id'],
      status: json['status'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['full_url'] = fullUrl;
    data['id'] = id;
    data['review_id'] = reviewId;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['updated_by'] = updatedBy;
    if (deletedAt != null) {
      data['deleted_at'] = deletedAt;
    }
    if (deletedBy != null) {
      data['deleted_by'] = deletedBy;
    }
    return data;
  }
}

class ProductReviewLikeDislikeModel {
  int? dislikeCount;
  int? likeCount;
  String? message;
  bool? status;

  ProductReviewLikeDislikeModel({this.dislikeCount, this.likeCount, this.message, this.status});

  factory ProductReviewLikeDislikeModel.fromJson(Map<String, dynamic> json) {
    return ProductReviewLikeDislikeModel(
      dislikeCount: json['dislike_count'],
      likeCount: json['like_count'],
      message: json['message'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dislike_count'] = dislikeCount;
    data['like_count'] = likeCount;
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
