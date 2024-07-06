import '../../../models/employee_review_data.dart';

class EmployeeReviewRes {
  bool status;
  List<EmployeeReviewData> reviewData;
  String message;

  EmployeeReviewRes({
    this.status = false,
    this.reviewData = const <EmployeeReviewData>[],
    this.message = "",
  });

  factory EmployeeReviewRes.fromJson(Map<String, dynamic> json) {
    return EmployeeReviewRes(
      status: json['status'] is bool ? json['status'] : false,
      reviewData: json['data'] is List ? List<EmployeeReviewData>.from(json['data'].map((x) => EmployeeReviewData.fromJson(x))) : [],
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': reviewData.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }
}
