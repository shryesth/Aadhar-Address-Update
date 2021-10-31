class KYCResponse {
  final String status;
  final String eKycString;
  final String errCode;

  KYCResponse({required this.status, required this.eKycString, required this.errCode});

  factory KYCResponse.fromJson(Map<String, dynamic> json) {
    return KYCResponse(
      status: json['status'],
      eKycString: json['eKycString'],
      errCode: json['errCode'] ?? '',
    );
  }
}