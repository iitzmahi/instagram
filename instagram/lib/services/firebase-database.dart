import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instagram/models/contacts.dart';

var id;
Future<void> addProduct(
  String number,
  String name,
) async {
  /*  if (number == "8866535452" ||
      number == "9106116309" ||
      number == "7014799875") {
    userId = "aWfOSS3W81eprgxms6QZT11vTZr1";
  } */
  try {
    var url =
        "https://instafake-bcf66-default-rtdb.asia-southeast1.firebasedatabase.app/$id/.json";
    print(number);
    print(name);
    final response = await http.post(url,
        body: json.encode({'number': number, 'name': name}));
    print(json.decode(response.body));
    print("ho gi ya");
  } catch (error) {
    print(error);
    throw error;
  }
}
