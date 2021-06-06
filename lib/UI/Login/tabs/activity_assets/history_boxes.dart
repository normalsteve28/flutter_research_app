import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import '../../username.dart';
import 'package:heart_go/UI/Login/assets.dart';

class HistoryBoxes extends StatefulWidget {
  @override
  _HistoryBoxesState createState() => _HistoryBoxesState();
}

class _HistoryBoxesState extends State<HistoryBoxes> {
  List<Widget> items = [];

  File jsonFile;
  Directory dir;
  String fileName = "$username.json";
  bool fileExists = false;
  List<dynamic> fileContent = [];

  TextEditingController _sys = TextEditingController();
  TextEditingController _dia = TextEditingController();
  TextEditingController _hr = TextEditingController();

  int sys;
  int dia;
  int hr;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 0), (Timer t) => itemsEqualFile());
    getExternalStorageDirectory().then((Directory directory) {
      dir = directory;
      jsonFile = new File(dir.path + "/" + fileName);
      fileExists = jsonFile.existsSync();
      if (fileExists)
        this.setState(
            () => fileContent = json.decode(jsonFile.readAsStringSync()));
    });
  }

  void createFile(List<dynamic> content, Directory dir, String fileName) {
    print("Creating file!");
    File file = new File(dir.path + "/" + fileName);
    print(dir);
    file.createSync();
    fileExists = true;
    file.writeAsStringSync(json.encode(content));
  }

  void writeToFile(int sys, int dia, int hr, String dt) {
    print("Writing to file!");
    String dtString = dt.toString();
    List<dynamic> initialContent = [
      {'sys': sys, 'dia': dia, 'hr': hr, 'dt': dt}
    ];
    Map<String, dynamic> content = {
      'sys': sys,
      'dia': dia,
      'hr': hr,
      'dt': dt,
    };

    if (fileExists) {
      print("File exists");

      print("Old file content: " + jsonFile.readAsStringSync());
      print(json.decode(jsonFile
          .readAsStringSync())); // Prints old file content and json decode of file  content

      List<dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.add(content);
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));

      print("New file content: " + jsonFile.readAsStringSync());
      print(json.decode(jsonFile
          .readAsStringSync())); // Prints new file content and json decode of file content
      items.add(HistoryBoxContainer(sys, dia, hr, dt));
    } else {
      print("File does not exist!");
      createFile(initialContent, dir, fileName);
      print("New file content: " + jsonFile.readAsStringSync());
      print(json.decode(jsonFile
          .readAsStringSync())); // Prints new file content and json decode of file content
      items.add(HistoryBoxContainer(sys, dia, hr, dt));
    }
    this.setState(() => fileContent = json.decode(jsonFile
        .readAsStringSync())); // setstate makes sure any widget that uses fileContent updates as fileContent changes
    print(fileContent);
  }

  void removeFromFile() {
    if (fileExists) {
      print('File exists! Removing last item...');
      List<dynamic> jsonFileContent = json.decode(jsonFile.readAsStringSync());
      jsonFileContent.removeLast();
      jsonFile.writeAsStringSync(json.encode(jsonFileContent));
      print(jsonFile.readAsStringSync());
      print(json.decode(jsonFile.readAsStringSync()));
      items.removeLast();
    } else {
      print('File does not exist! Create one by writing to file!');
    }
  }

  removeHistoryBox() {
    // removes history boxes
    removeFromFile();
  }

  itemsEqualFile() {
    if (items.length == fileContent.length) {
      print("Items length and fileContent.length are equal!");
    } else if (items.length < fileContent.length) {
      print("Items length less than fileContent length");
      for (var i = 0; i < fileContent.length; i++) {
        setState(() {
          items.add(HistoryBoxContainer(
              fileContent[i]["sys"],
              fileContent[i]["dia"],
              fileContent[i]["hr"],
              fileContent[i]["dt"]));
        });
      }
    } else {
      print("Items length greater than fileContent length");
      for (var i = items.length; i > fileContent.length; i--) {
        items.removeLast();
      }
    }
  }

  _displayDialog() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 6,
            backgroundColor: Colors.transparent,
            child: _DialogWithTextField(context),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            TextButton(
              // Button that adds history boxes for testing ( it adds blank data to bp data list )
              onPressed: () {
                _displayDialog();
              },
              child: Text(
                '+',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 35,
                ),
              ),
            ),
            TextButton(
              // Button that removes history boxes
              onPressed: () {
                setState(() {
                  removeHistoryBox();
                });
                print("Items length: ${items.length}");
                print("File content length: ${fileContent.length}");
                // printListLength();
              },
              child: Text(
                '-',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 45,
                ),
              ),
            )
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: [
                items.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("You havent started measuring yet.",
                            style: TextStyle(fontSize: 18)),
                      )
                    : Container(),
                ...items
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _DialogWithTextField(BuildContext context) => Container(
        height: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 24),
            Text(
              "ADD A MEASUREMENT".toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            SizedBox(height: 10),
            Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
                child: TextField(
                  controller: _sys,
                  maxLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Systolic',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                )),
            Container(
              width: 150.0,
              height: 1.0,
              color: Colors.grey[400],
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                child: TextField(
                  controller: _dia,
                  maxLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Diastolic',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                )),
            SizedBox(height: 10),
            Container(
              width: 150.0,
              height: 1.0,
              color: Colors.grey[400],
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                child: TextField(
                  controller: _hr,
                  maxLines: 1,
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Heart Rate',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                )),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                RaisedButton(
                  color: Colors.white,
                  child: Text(
                    "Save".toUpperCase(),
                    style: TextStyle(
                      color: Colors.redAccent,
                    ),
                  ),
                  onPressed: () {
                    print('Update the user info');
                    setState(() {
                      sys = int.parse(_sys.text) ?? 0;
                      dia = int.parse(_dia.text) ?? 0;
                      hr = int.parse(_hr.text) ?? 0;
                      writeToFile(sys, dia, hr, DateTime.now().toString());
                      itemsEqualFile();
                      print("Items length: ${items.length}");
                      print("File content length: ${fileContent.length}");
                    });
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            ),
          ],
        ),
      );
}

class HistoryBoxContainer extends StatelessWidget {
  final int sys;
  final int dia;
  final int hr;
  final String dt;

  HistoryBoxContainer(this.sys, this.dia, this.hr, this.dt);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      width: 164,
      height: 91,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Color(0x7f000000),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            // Systolic
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Systolic:",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                ),
              ),
              Text(
                "$sys mmhg",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            // Diastolic
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Diastolic:",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                ),
              ),
              Text(
                "$dia mmhg",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Row(
            // Heart Rate
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Heart Rate:",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                ),
              ),
              Text(
                "$hr bpm",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            height: 5,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgPicture.asset(timeIconSvg),
                Text(
                  "${(DateFormat('EEEE').format(DateTime.parse(dt)))}, ${(DateFormat('h:mm a').format(DateTime.parse(dt)))}",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
