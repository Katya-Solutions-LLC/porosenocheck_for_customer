import '../../../models/employee_review_data.dart';
import '../../dashboard/dashboard_res_model.dart';
import '../../pet/model/pet_list_res_model.dart';
import 'booking_data_model.dart';

class BookingDetailRes {
  bool status;
  BookingDataModel data;
  EmployeeReviewData? customerReview;
  String message;

  BookingDetailRes({
    this.status = false,
    required this.data,
    this.customerReview,
    this.message = "",
  });

  factory BookingDetailRes.fromJson(Map<String, dynamic> json) {
    return BookingDetailRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is Map ? BookingDataModel.fromJson(json['data']) : BookingDataModel(service: SystemService(), payment: PaymentDetails(), training: Training(),petDetails: PetData()),
      customerReview: json['customer_review'] is Map ? EmployeeReviewData.fromJson(json['customer_review']) : null,
      message: json['message'] is String ? json['message'] : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.toJson(),
      'message': message,
      if (customerReview != null) 'customer_review': customerReview!.toJson(),
    };
  }
}
