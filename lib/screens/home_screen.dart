import 'package:address/screens/scan_doc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_ip/flutter_ip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstTime();
    print(same_IP);
  }

  bool same_IP = true;

  void firstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool('first_time');

    if (firstTime == null) {
      // first time, store the current IP in the device cache
      prefs.setBool('first_time', false);
      String local_IP = await FlutterIp.internalIP;
      prefs.setString('local_IP', local_IP);
    } else {
      // Not first time, check the current IP from the one stored in the device cache
      print('IT IS NOT THE FIRST TIME');
      same_IP = await checkIP();
    }
  }

  Future<bool> checkIP() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String local_IP = await FlutterIp.internalIP;
    String? stored_IP = prefs.getString('local_IP');
    if(stored_IP != null && local_IP == stored_IP){
      return true;
    }
    else{
      return false;
    }
  }

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
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          getRequiredPermissions();
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScanDocScreen()));
        },
      ),
    );
  }
}

