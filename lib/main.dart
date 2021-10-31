import 'package:address/constants.dart';
import 'package:address/screens/bottom_navigation.dart';
import 'package:address/screens/home_screen.dart';
import 'package:address/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'screens/addresses_screen.dart';
import 'screens/scan_doc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: kPrimaryRed
      ),
      home: HomeScreen(),
    );
  }
}