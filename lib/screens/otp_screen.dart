import 'package:address/constants.dart';
import 'package:address/screens/confirm_screen.dart';
import 'package:address/services/aadhar_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _controllerAadhar = TextEditingController();
  final AadharService _aadharService = AadharService();
  var uuid = const Uuid();

  @override
  void dispose() {
    _controllerAadhar.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: kPrimaryYellow,
      appBar: AppBar(
        backgroundColor: kPrimaryRed,
        centerTitle: true,
        title: const Text('Verify Aadhar'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: size.height * 0.07),
                Text(
                  'Aadhar Validation',
                  style: TextStyle(
                    fontSize: 24,
                    color: kPrimaryRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.07),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: TextFormField(
                    controller: _controllerAadhar,
                    maxLength: 12,
                    decoration: InputDecoration(
                      focusColor: kPrimaryRed,
                      hintText: 'Aadhar Number',
                      contentPadding: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        bottom: 20,
                        top: 0,
                      ),
                      prefixStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      border: const OutlineInputBorder(
                        gapPadding: 4,
                        borderRadius: BorderRadius.all(
                          Radius.circular(22),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                MaterialButton(
                  onPressed: () async {
                    if (_controllerAadhar.text.length == 12) {
                      String uid = _controllerAadhar.text;
                      String txnId =  uuid.v4();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sending OTP..')));
                      await _aadharService.getOTP(uid, txnId);
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ConfirmScreen(uid: uid, txnId: txnId)));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid Aadhar number')));
                    }
                  },
                  // color: kPrimaryPurple,
                  elevation: 1,
                  color: kPrimaryRed,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: size.height * 0.05,
                // ),
                // MaterialButton(
                //   // color: kPrimaryPurple,
                //   elevation: 1,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(15),
                //     ),
                //   ),
                //   onPressed: () {
                //     if (_controllerAadhar.text.length == 10) {
                //       Scaffold.of(context).showSnackBar(SnackBar(content: Text('Sending OTP..')));
                //     } else {
                //       Scaffold.of(context).showSnackBar(SnackBar(content: Text('Enter a valid Aadhar number.')));
                //     }
                //   },
                //   child: Text(
                //     'Resend OTP',
                //     style: TextStyle(color: Colors.white),
                //   ),
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//
