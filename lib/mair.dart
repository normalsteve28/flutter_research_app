import 'package:flutter/material.dart';

import 'UI/Login/loginpage.dart'; // Imports login page
import 'UI/Login/homepage.dart'; // Imports homepage
import 'UI/Login/username.dart'; // Imports username

import 'package:shared_preferences/shared_preferences.dart';
// import 'bloc/resources/repository.dart';
import 'bloc/blocs/user_bloc_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isLoggedIn = false;
  // This has no use. Supposedly, if the person has a username, this will turn true.
  // That way, when they already signed up, the app will not return to the sign up page every time
  // the app restarts.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.yellow,
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        "/login": (_) => Home(username: username)
      }, // This is done so that it won't return to the login page (Fixes the Learn page back button problem)
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String apiKey = "";
  // Repository _repository = Repository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: signinUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          apiKey = snapshot.data;
          print(apiKey);
        } else {
          print("No data");
        }
        // String apiKey = snapshot.data;
        //apiKey.length > 0 ? getHomePage() :
        return apiKey.length > 0
            ? Home(
                username: username,
              )
            : LoginPage(
                login: login,
                newUser: false,
              );
      },
    );
  }

  void login() {
    setState(() {
      build(context);
    });
  }

  Future signinUser() async {
    // String userName = "";
    apiKey = await getApiKey();
    if (apiKey != null) {
      if (apiKey.length > 0) {
        userBloc.signinUser("", apiKey);
      } else {
        print("No api key");
      }
    } else {
      apiKey = "";
    }
    return apiKey;
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return /* await */ prefs.getString("API_Token");
  }
}
