import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'dart:async';
import 'intermediate_loader_screen.dart';
import 'edit_address.dart';

class Addresses_Screen extends StatefulWidget {

  String doc_address;
  String GPS_address;
  Addresses_Screen({required this.doc_address, required this.GPS_address});

  @override
  _Addresses_ScreenState createState() => _Addresses_ScreenState();
}

class _Addresses_ScreenState extends State<Addresses_Screen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, actions: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: (){
            //To edit address screen:-
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Edit_Address(doc_address: widget.doc_address,)));
          },
        )
      ],),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    "Address on Scanned Document: " + widget.doc_address,
                    style: TextStyle(fontSize: 30.0,),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    "Current Device Address: " + widget.GPS_address,
                    style: TextStyle(fontSize: 30.0,),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
