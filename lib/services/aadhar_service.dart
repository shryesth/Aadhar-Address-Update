import 'package:address/models/kyc_response.dart';
import 'package:address/models/otp_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:xml/xml.dart';

class AadharService {
  var getOtpUrl = Uri.parse('https://stage1.uidai.gov.in/onlineekyc/getOtp/');
  var getEKycUrl = Uri.parse('https://stage1.uidai.gov.in/onlineekyc/getEkyc/');

  Future<void> getOTP(String uid, String txnId) async {
    var response = await http.post(getOtpUrl,
        headers: <String, String>{
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          'uid': uid,
          'txnId': txnId
        }));
    print(response.statusCode);

    if (response.statusCode == 200) {
      var otpResponse = OTPResponse.fromJson(jsonDecode(response.body));
      print(otpResponse.status);
    } else {
      throw Exception('Failed to get OTP.');
    }
  }

  Future<void> getEKyc(String uid, String txnId, String otp) async {

    var response = await http.post(getEKycUrl,
        headers: <String, String>{
          'Content-type': 'application/json',
        },
        body: jsonEncode({
          'uid': uid,
          'txnId': txnId,
          'otp': otp,
        }));

    print(response.statusCode);

    if (response.statusCode == 200) {
      var kycResponse = KYCResponse.fromJson(jsonDecode(response.body));
      final document = XmlDocument.parse(kycResponse.eKycString);
      print(document);
    } else {
      throw Exception('Failed to get OTP.');
    }
  }
}


