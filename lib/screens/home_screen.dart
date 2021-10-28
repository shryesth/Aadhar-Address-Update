import 'package:address/screens/scan_doc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


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
