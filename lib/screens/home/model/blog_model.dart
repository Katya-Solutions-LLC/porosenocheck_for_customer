import '../../dashboard/dashboard_res_model.dart';

class BlogRes {
  bool status;
  List<Blog> data;
  String message;

  BlogRes({
    this.status = false,
    this.data = const <Blog>[],
    this.message = "",
  });

  factory BlogRes.fromJson(Map<String, dynamic> json) {
    return BlogRes(
      status: json['status'] is bool ? json['status'] : false,
      data: json['data'] is List ? List<Blog>.from(json['data'].map((x) => Blog.fromJson(x))) : [],
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
