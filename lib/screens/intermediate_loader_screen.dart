import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'dart:async';
import 'package:address/screens/addresses_screen.dart';

class Intermediate_Loader_Screen extends StatefulWidget {

  String doc_address;
  String GPS_address;
  Intermediate_Loader_Screen({required this.doc_address, required this.GPS_address});

  @override
  _Intermediate_Loader_ScreenState createState() => _Intermediate_Loader_ScreenState();
}

class _Intermediate_Loader_ScreenState extends State<Intermediate_Loader_Screen> {

  void initState() {
    // TODO: implement initState
    const duration = Duration(seconds: 3);
    Timer(duration, () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Addresses_Screen(doc_address: widget.doc_address, GPS_address: widget.GPS_address))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width,
            child: LoadingBouncingGrid.square(size: 200, backgroundColor: Colors.purple,),
          )),
    );
  }
}
