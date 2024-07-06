class SaveBookingRes {
  String message;
  bool status;
  int bookingId;

  SaveBookingRes({
    this.message = "",
    this.status = false,
    this.bookingId = -1,
  });

  factory SaveBookingRes.fromJson(Map<String, dynamic> json) {
    return SaveBookingRes(
      message: json['message'] is String ? json['message'] : "",
      status: json['status'] is bool ? json['status'] : false,
      bookingId: json['booking_id'] is int ? json['booking_id'] : -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'booking_id': bookingId,
    };
  }
}
