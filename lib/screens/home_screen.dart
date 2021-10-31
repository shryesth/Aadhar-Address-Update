import 'package:address/constants.dart';
import 'package:address/screens/scan_doc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:flutter_ip/flutter_ip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool _isLoading = false;
  late String currentAddress;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  //getting the current device location by GPS:-
  void _getCurrentAddress() async{
    try{
      Position position = await _determinePosition();
      print(position.latitude);
      print(position.longitude);
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude
      );
      Placemark place = placemarks[0];
      currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      print(currentAddress);
      setState(() {
        _isLoading = false;
      });
    }
    catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // firstTime();
    _isLoading = true;
    _getCurrentAddress();
    // print(same_IP);
  }

  // bool same_IP = true;
  //
  // void firstTime() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? firstTime = prefs.getBool('first_time');
  //
  //   if (firstTime == null) {
  //     // first time, store the current IP in the device cache
  //     prefs.setBool('first_time', false);
  //     String local_IP = await FlutterIp.internalIP;
  //     prefs.setString('local_IP', local_IP);
  //   } else {
  //     // Not first time, check the current IP from the one stored in the device cache
  //     print('IT IS NOT THE FIRST TIME');
  //     same_IP = await checkIP();
  //   }
  // }
  //
  // Future<bool> checkIP() async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String local_IP = await FlutterIp.internalIP;
  //   String? stored_IP = prefs.getString('local_IP');
  //   if(stored_IP != null && local_IP == stored_IP){
  //     return true;
  //   }
  //   else{
  //     return false;
  //   }
  // }

  void getRequiredPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
    ].request();

    //TODO: Handle case for when permission is not given.
    print(statuses[Permission.location]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? CircularProgressIndicator()
          :
      Column(
        children: [
          Container(
            width:  MediaQuery.of(context).size.width,
          ),
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
              color: kPrimaryRed,
              // gradient: LinearGradient(
              //   colors: [kPrimaryRed, kPrimaryYellow],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              // ),
            ),
            child: Center(
              child: Text(
                'Verify and Update Address',
                style: TextStyle(
                    color: Colors.white
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getRequiredPermissions();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ScanDocScreen(gps_address: currentAddress,)));
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: kPrimaryRed,
      ),
    );
  }
}
