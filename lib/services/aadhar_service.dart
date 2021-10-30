import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  AadharService aadharService = AadharService();
  await aadharService.getOTP(869560636448);
}

class AadharService {
  var getOtpUrl = Uri.parse('https://stage1.uidai.gov.in/onlineekyc/getOtp/');
  var getEKycUrl = Uri.parse('https://stage1.uidai.gov.in/onlineekyc/getEkyc/');

  Future<void> getOTP(int aadharNumber) async {
    final response = await http.post(
      getOtpUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': aadharNumber.toString(),
        'txnId': "0acbaa8b-b3ae-433d-a5d2-51250ea8e970"
      }),
    );

    var otpResponse = OTPResponse.fromJson(jsonDecode(response.body));
    print(otpResponse.status);

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var otpResponse = OTPResponse.fromJson(jsonDecode(response.body));
      print(otpResponse.status);
    } else {
      throw Exception('Failed to get OTP.');
    }
  }

  Future<void> getEKyc(int aadharNumber) async {
    final response = await http.post(
      getOtpUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'uid': aadharNumber.toString(),
        'txnId': "0acbaa8b-b3ae-433d-a5d2-51250ea8e970"
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var otpResponse = OTPResponse.fromJson(jsonDecode(response.body));
      print(otpResponse.status);
    } else {
      throw Exception('Failed to KYC.');
    }
  }
}

class OTPResponse {
  final String status;
  final String errCode;

  OTPResponse({required this.status, required this.errCode});

  factory OTPResponse.fromJson(Map<String, dynamic> json) {
    return OTPResponse(
      status: json['status'],
      errCode: json['errCode'],
    );
  }
}