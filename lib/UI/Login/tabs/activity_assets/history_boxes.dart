import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import '../../username.dart';

class HistoryBoxes extends StatefulWidget {
  @override
  _HistoryBoxesState createState() => _HistoryBoxesState();
}

class _HistoryBoxesState extends State<HistoryBoxes> {
  List<Widget> items = [];
  int index = -1;

  File jsonFile;
  Directory dir;
  String fileName = "$username.json";
  bool fileExists = false;
  List<dynamic> fileContent = [];

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
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
    index -= 1;
    removeFromFile();
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
                setState(() {
                  writeToFile(0, 0, 0, DateTime.now().toString());
                  index += 1;
                });
                print("Items length: ${items.length}");
                print("File content length: ${fileContent.length}");
                print("Index: $index");
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
                print("Index: $index");
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
                )
              ],
            ),
          ],
        ));
  }
}
