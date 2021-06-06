import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import 'assets.dart';
import 'username.dart';
import '../../bloc/blocs/user_bloc_provider.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback login;
  final bool newUser;

  const LoginPage({Key key, this.login, this.newUser}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            children: [
              Positioned(
                  top: 150,
                  child: SvgPicture.asset(heartGo)), //This is HeartGo logo
              Positioned(
                  top: 200,
                  child: SvgPicture.asset(bpDrawing)), // This is the image
              Align(
                // This is aligning the container box that asks for signup
                alignment: Alignment.bottomCenter,
                child: Container(
                  // box contains column that contains Text and Sign Up button
                  width: double.infinity,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3fe14747),
                        blurRadius: 41,
                        offset: Offset(8, 4),
                      ),
                    ],
                    color: Color(0xffffebeb),
                  ),
                  child: Column(
                    // This column contains Text and Sign Up Button
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Measure your blood pressure\nevery where you go",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          "With HeartGo, you can take your blood pressure easily",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Nunito"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "What's your name?",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      LoginForm(
                        login: widget.login,
                        newUser: true,
                      ) // This contains textfield and signup button
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xffffebeb),
    );
  }
}

class LoginForm extends StatefulWidget {
  final VoidCallback login;
  final bool newUser;

  const LoginForm({Key key, this.login, this.newUser}) : super(key: key);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  // this is the form that accepts a name and passes it onto the Homepage
  final usernameController = TextEditingController();
  // The username that the user submits
  Color buttonColor = Colors.grey;
  // This is the variable that holds the color of the sign up button
  Color buttonTextColor = Colors.black;
  // This is the variable that holds the text color of sign up button
  Function buttonFunction;
  // This variable holds the function of the sign up button
  TextEditingController usernameText = new TextEditingController();
  TextEditingController passwordText = new TextEditingController();
  File jsonFile;
  Directory dir;
  String fileName = "userData.json";
  bool fileExists = false;
  Map<String, dynamic> fileContent;

  @override
  void initState() {
    super.initState();

    // Calls the checkIfTextEmpty function every time the text changes.
    usernameController.addListener(checkIfTextEmpty);
    usernameText.addListener(checkIfTextEmpty);
    getExternalStorageDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }

  void createFile(
      Map<String, dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    print(dir);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(String yousername, bool isLoggedIn) {
    print("Writing to file!");
    Map<String, dynamic> content = {
      'username': yousername,
      'isLoggedIn': isLoggedIn
    };

    if (fileExists) {
      print("File exists");

      print("Old file content: " + jsonFile.readAsStringSync());
      print(json.decode(jsonFile
          .readAsStringSync())); // Prints old file content and json decode of file  content

      Map<String, dynamic> jsonFileContent =
          json.decode(jsonFile.readAsStringSync());
      jsonFileContent.addAll(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));

      print("New file content: " + jsonFile.readAsStringSync());
      print(json.decode(jsonFile
          .readAsStringSync())); // Prints new file content and json decode of file content
    } else {
      print("File does not exist!");
      createFile(content, dir, fileName);
      print("New file content: " + jsonFile.readAsStringSync());
      print(json.decode(jsonFile
          .readAsStringSync())); // Prints new file content and json decode of file content
    }
    this.setState(() => fileContent = json.decode(jsonFile
        .readAsStringSync())); // setstate makes sure any widget that uses fileContent updates as fileContent changes
    print(fileContent);
  }

  void checkIfTextEmpty() {
    //This function checks if the text field is empty and assigns color and function to the button
    // depending on whether or not the text field is empty
    if (usernameController.text != "" || usernameText.text != "") {
      // If text is not empty, then button is pink and text is white, leads to homepage when pressed
      setState(() {
        buttonColor = Color(0xfffe7575);
        buttonTextColor = Colors.white;
        buttonFunction = () {
          username = usernameController.text;
          writeToFile(username, true);
          Navigator.pushReplacementNamed(
            context,
            "/login", //This is a route, its value can be found in main (it heads to homepage)
          );
          if (widget.newUser == true) {
            if (username != null) {
              print(username);
              userBloc.registerUser(username).then((_) {
                widget.login();
              });
            }
          } else {
            if (username != null || passwordText.text != null) {
              print("username2");
              userBloc
                  .signinUser(
                username,
                "", /*""*/
              )
                  .then((_) {
                widget.login();
              });
            }
          }
        };
      });
    } else {
      // If text is empty, then button will be grey and text will be black, buttonFunction will be null
      setState(() {
        buttonColor = Colors.grey;
        buttonTextColor = Colors.black;
        buttonFunction = null;
      });
    }
  }

  @override
  void dispose() {
    // Cleans up the controller when the widget is disposed.
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: widget.newUser ? getSignupPage() : getSigninPage(),
      ),
    );
  }

  Widget getSigninPage() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter your name here",
              ),
              controller: usernameText,
            ),
          ),
          Container(
            // This container is what makes the button the shape and color it is
            margin: EdgeInsets.only(top: 20, bottom: 20),
            width: 269,
            height: 59,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3fe14747),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
              color: buttonColor,
            ),
            child: TextButton(
              // This Sign Up button fills the previous container
              // This button heads to home if TextField is not empty
              onPressed: buttonFunction,
              child: Text(
                "Sign in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: buttonTextColor,
                  fontSize: 18,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSignupPage() {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter your name here",
              ),
              controller: usernameController,
            ),
          ),
          Container(
            // This container is what makes the button the shape and color it is
            margin: EdgeInsets.only(top: 20, bottom: 20),
            width: 269,
            height: 59,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3fe14747),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
              color: buttonColor,
            ),
            child: TextButton(
              // This Sign Up button fills the previous container
              // This button heads to home if TextField is not empty
              onPressed: buttonFunction,
              child: Text(
                "Sign up",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: buttonTextColor,
                  fontSize: 18,
                  fontFamily: "Nunito",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
