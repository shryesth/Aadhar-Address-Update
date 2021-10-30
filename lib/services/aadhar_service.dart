import 'package:http/http.dart' as http;
import 'dart:convert';

class AadharService {
  var getOtpUrl = Uri.parse('https://stage1.uidai.gov.in/onlineekyc/getOtp/');
  var getEKycUrl = Uri.parse('https://stage1.uidai.gov.in/onlineekyc/getEkyc/');

  Future<void> getOTP() async {

    var response = await http.post(getOtpUrl,
        headers: <String, String>{
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          //Aditya's UID - If you get a 952 that is a OTP Flooding Error
          'uid': '999941971149',
          'txnId': '0acbaa8b-b3ae-433d-a5d2-51250ea8e970'
        }));
    print(response.statusCode);

    var otpResponse = OTPResponse.fromJson(jsonDecode(response.body));
    print(otpResponse.status);
    print(jsonDecode(response.body));

    if (response.statusCode == 200) {
      var otpResponse = OTPResponse.fromJson(jsonDecode(response.body));
      print(otpResponse.status);
    } else {
      throw Exception('Failed to get OTP.');
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
      errCode: json['errCode'] ?? '',
    );
  }
}
