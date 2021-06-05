import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'UI/Login/loginpage.dart'; // Imports login page
import 'UI/Login/homepage.dart'; // Imports homepage
import 'UI/Login/username.dart'; // Imports username

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences preferences;
  File jsonFile;
  Directory dir;
  String fileName = "userData.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  @override
  void initState() {
    super.initState();
    getExternalStorageDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
    print('execute');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.yellow,
      home: fileExists
          ? Home(username: fileContent["username"])
          : LoginPage(
              newUser: true,
            ),
      routes: {
        "/login": (_) => Home(username: username)
      }, // This is done so that it won't return to the login page (Fixes the Learn page back button problem)
    );
  }
}
