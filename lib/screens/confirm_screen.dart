import 'package:address/constants.dart';
import 'package:address/screens/home_screen.dart';
import 'package:address/services/aadhar_service.dart';
import 'package:flutter/material.dart';

class ConfirmScreen extends StatefulWidget {
  String uid;
  String txnId;
  ConfirmScreen({Key? key, required this.uid, required this.txnId}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  final TextEditingController _controllerOTP = TextEditingController();
  final AadharService _aadharService = AadharService();

  @override
  void dispose() {
    _controllerOTP.dispose();
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
        title: const Text('Confirm OTP'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: size.height * 0.07),
                Text(
                  'OTP Validation',
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
                    controller: _controllerOTP,
                    maxLength: 6,
                    decoration: InputDecoration(
                      focusColor: kPrimaryRed,
                      hintText: '6 digit OTP',
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
                    if (_controllerOTP.text.length == 6) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Confirming OTP..')));
                      await _aadharService.getEKyc(widget.uid, widget.txnId, _controllerOTP.text);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid OTP')));
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
                      'Confirm',
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
