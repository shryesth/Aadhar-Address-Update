import 'package:address/screens/addresses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';

class ScanDocScreen extends StatefulWidget {
  String gps_address;
  ScanDocScreen({Key? key, required this.gps_address}) : super(key: key);

  @override
  _ScanDocScreenState createState() => _ScanDocScreenState();
}

class _ScanDocScreenState extends State<ScanDocScreen> {
  // @override
  // void initState() {
  //   FlutterMobileVision.start().then((x) => setState(() {}));
  //   super.initState();
  // }

  final int _ocrCamera = FlutterMobileVision.CAMERA_BACK;
  String _text = "TEXT";

  Future<void> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _ocrCamera,
        waitTap: true,
      );
      setState(() {
        _text = texts[0].value;
        print("HERE IS THE LIST OF ALL THE DOC TEXT" + _text);
      });
    } on Exception {
      texts.add( OcrText('Failed to recognize text'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('OCR In Flutter'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(_text,style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async{
                  await _read();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Addresses_Screen(doc_address: _text, GPS_address: widget.gps_address,)));
                },
                child: const Text('Scanning',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
