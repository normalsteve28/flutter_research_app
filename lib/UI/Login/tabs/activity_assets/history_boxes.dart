import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/services.dart';
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

  void writeToFile(int sys, int dia, int hr, String dth, String dtm) {
    print("Writing to file!");
    List<dynamic> initialContent = [
      {'sys': sys, 'dia': dia, 'hr': hr, 'dth': dth, 'dtm': dtm}
    ];
    Map<String, dynamic> content = {
      'sys': sys,
      'dia': dia,
      'hr': hr,
      'dth': dth,
      'dtm': dtm,
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
    } else {
      print("File does not exist!");
      createFile(initialContent, dir, fileName);
      print("New file content: " + jsonFile.readAsStringSync());
      print(json.decode(jsonFile
          .readAsStringSync())); // Prints new file content and json decode of file content
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
    } else {
      print('File does not exist! Create one by writing to file!');
    }
  }

  addHistoryBox() {
    items.add(
      // Adds history box with systolic, diastolic, heart rate values
      HistoryBoxContainer(index, fileContent),
    );
  }

  removeHistoryBox() {
    // removes history boxes
    removeFromFile();
    items.removeLast();

    index -= 1;
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
                  writeToFile(0, 0, 0, DateTime.now().hour.toString(),
                      DateTime.now().minute.toString());
                  index += 1;
                  addHistoryBox();
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
          // This SingleChildScrollView allows the horizontal scrolling of the contents
          // of the child of Container, which is Row
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              items.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          "You havent started measuring yet.\n(Can add boxes for testing purposes)",
                          style: TextStyle(fontSize: 18)),
                    )
                  : Container(),
              ...items,
            ],
          ),
        )),
      ],
    );
  }
}

class HistoryBoxContainer extends StatelessWidget {
  final int index;
  final List<dynamic> fileContent;

  HistoryBoxContainer(this.index, this.fileContent);

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
                  "${fileContent[index]['sys']} mmhg",
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
                  "${fileContent[index]['dia']} mmhg",
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
                  "${fileContent[index]['hr']} bpm",
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
