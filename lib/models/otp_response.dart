class OTPResponse {
  final String status;
  final String errCode;

  OTPResponse({required this.status, required this.errCode});

  factory OTPResponse.fromJson(Map<String, dynamic> json) {
    return OTPResponse(
      status: json['status'],
      errCode: json['errCode'] ?? '',
    );
  }
}